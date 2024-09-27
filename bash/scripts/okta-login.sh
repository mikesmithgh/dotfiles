#!/usr/bin/env bash

# copied from https://www.linkedin.com/pulse/get-okta-oauth2-accesstoken-from-command-line-max-fortun-v4yae/

set -e

oktaConfigFile=$HOME/.config/okta/${1:-default}.json
oktaConfigDir=$(dirname $oktaConfigFile)

[ -d $oktaConfigDir ] || mkdir -p $oktaConfigDir
[ -e $oktaConfigFile ] || echo '{}' >$oktaConfigFile

function updateConfig() {
  local path="$1"
  jq "$path" $oktaConfigFile >$oktaConfigFile.changed
  mv $oktaConfigFile.changed $oktaConfigFile
  chmod og-rwx $oktaConfigFile
}

function readConfig() {
  local path="$1"
  if [ ! -e $oktaConfigFile ]; then
    echo null
    return
  fi
  jq -r "$path" $oktaConfigFile
}

org=$1
username=$2

org=$(readConfig .okta.defaults.org)
if [ "$org" = null ]; then
  echo -n "Okta Org (https://your_org.okta.com): "
  read org
  updateConfig '.okta.defaults.org = "'"$org"'"'
fi

client_id=$(readConfig .okta.defaults.oauth2.client_id)
if [ "$client_id" = null ]; then
  echo -n "Oauth2 client_id: "
  read client_id
  updateConfig '.okta.defaults.oauth2.client_id = "'"$client_id"'"'
fi

redirect_uri=$(readConfig .okta.defaults.oauth2.redirect_uri)
if [ "$redirect_uri" = null ]; then
  echo -n "Oauth2 redirect_uri: "
  read redirect_uri
  updateConfig '.okta.defaults.oauth2.redirect_uri = "'"$redirect_uri"'"'
fi

authorization_server=$(readConfig .okta.defaults.oauth2.authorization_server)
if [ "$authorization_server" = null ]; then
  echo -n "Oauth2 authorization server (default, your own, or leave empty): "
  read authorization_server
  updateConfig '.okta.defaults.oauth2.authorization_server = "'"$authorization_server"'"'
fi

username=$(readConfig .okta.defaults.username)
if [ "$username" = null ]; then
  echo -n "$org username: "
  read username
  updateConfig '.okta.defaults.username = "'"$username"'"'
fi

password=$(readConfig '.okta.orgs."'"$org"'".users."'"$username"'".password')
if [ "$password" = null ]; then
  echo -n "$org $username password: "
  read -s password
  echo

  # We do not really want to store our password in plaintext
  # updateConfig '.okta.orgs."'"$org"'".users."'"$username"'".password = "'"$password"'"'
fi

authn_response=$(curl -s -X POST \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
		"username": "'"$username"'",
		"password": "'"$password"'",
		"options": {
			"multiOptionalFactorEnroll": true,
			"warnBeforePasswordExpired": true
		}
	}' \
  "$org/api/v1/authn")

authn_status=$(echo "$authn_response" | jq -r '.status')
if [ "$authn_status" != "SUCCESS" ] && [ "$authn_status" != "MFA_REQUIRED" ]; then
  echo "ERROR! Don't know how to process Okta authn response:"
  echo "$authn_response"
  exit 1
fi

if [ "$authn_status" = "SUCCESS" ]; then
  session_token=$(echo "$authn_response" | jq -r '.sessionToken')
else
  mfa_provider=$(readConfig .okta.defaults.mfa.provider)
  mfa_name=$(readConfig .okta.defaults.mfa.vendor_name)
  mfa_type=$(readConfig .okta.defaults.mfa.factor_type)

  if [ "$mfa_provider" = null ] || [ "$mfa_type" = null ]; then
    mfa_list=$(echo "$authn_response" | jq -r '._embedded.factors[]|[.vendorName, .provider, .factorType]|join(" ")' | sort)

    i=1
    while read name provider type; do
      echo "$i) $name $type"
      i=$((i + 1))
    done < <(echo "$mfa_list")

    echo -n "Number of the MFA you would like to use: "
    read -n1 mfa_id
    echo

    read mfa_name mfa_provider mfa_type < <(echo "$mfa_list" | sed -n "${mfa_id}p")
    updateConfig '.okta.defaults.mfa.provider = "'"$mfa_provider"'"'
    updateConfig '.okta.defaults.mfa.factor_type = "'"$mfa_type"'"'
  fi

  factor=$(echo "$authn_response" | jq -r '._embedded.factors[]|select(.provider == "'"$mfa_provider"'" and .factorType == "'"$mfa_type"'")')
  verify=$(echo "$factor" | jq -r '._links.verify.href')
  state_token=$(echo "$authn_response" | jq -r '.stateToken')

  factor_result=WAITING
  while true; do
    factor_response=$(curl -s -X POST \
      -H 'Accept: application/json' \
      -H 'Content-Type: application/json' \
      -d '{
				"stateToken": "'"$state_token"'"
			}' \
      $verify)

    factor_result=$(echo "$factor_response" | jq -r .factorResult)
    if [ "$factor_result" = "WAITING" ]; then
      sleep 5
    else
      break
    fi
  done

  factor_status=$(echo "$factor_response" | jq -r .status)
  if [ "$factor_status" != "SUCCESS" ]; then
    echo "ERROR! Unknown response from Okta:"
    echo "$factor_response"
    exit 1
  fi

  session_token=$(echo "$factor_response" | jq -r '.sessionToken')
fi

updateConfig '.okta.session.token = "'"$session_token"'"'

[ -z "$authorization_server" ] || authorization_server=/$authorization_server
location=$(curl -v "$org/oauth2$authorization_server/v1/authorize?client_id=$client_id&response_type=token&scope=openid%20profile%20email&redirect_uri=$redirect_uri&sessionToken=$session_token&state=empty&nonce=$(date +%s)" 2>&1 | grep -i '^< location:' | tr -d '\r\n')

while read line; do
  tokens=(${line/=/ })
  updateConfig '.okta.oauth2.'"${tokens[0]}"' = "'"${tokens[1]}"'"'
done < <(echo "${location##*#}" | tr '&' '\n')
