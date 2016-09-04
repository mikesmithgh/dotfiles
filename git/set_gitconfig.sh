#!/bin/bash
if [ ! -z $1 ] ; then
  git config --global user.name "$1"
fi
if [ ! -z $2 ] ; then
  git config --global user.email "$2"
fi  
git config --global core.excludesfile ~/.gitignore
git config --global core.autocrlf true
git config --global remote.origin.prune true
git config --global push.default current
git config --global diff.tool vimdiff 
git config --global merge.tool vimdiff 
git config --global difftool.prompt false 
git config --global mergetool.prompt false
git config --global log.date 'format:%m/%d/%Y %I:%M %p'
git config --global color.status.untracked magenta 
git config --global pretty.distinguishedoneline '%C(66 bold)%h  %C(173 nobold)%ad  %C(150 nobold)%an  %C(reset)%s'
git config --global pretty.distinguishedonelinetab '%C(66 bold)%<(8)%h %C(173 nobold)%<(20)%ad %C(150 nobold)%<(19)%an %C(reset)%s'
git config --global pretty.distinguishedmediumtab '%C(173 nobold)commit %C(66 bold)%H%n%C(173 nobold)Merge: %C(66 bold)%p%n%C(186 bold)Author: %C(143 nobold)%an %Creset<%C(150)%ae%Creset>%n%C(186 bold)Date:   %C(143 nobold)%ad%n%n%C(reset)%w(50,4,4)%s%n%n%w(0,4,4)%b'
git config --global alias.alias "! git config --get-regexp ^alias\. | sed -e s_^alias\._\"\$(printf '%b' '\\033[38;5;173m')\"_ -e s_\ _\"\$(printf '%b%s%b' '\\033[0m' '☠' '\\033[38;5;150m')\"_ | grep -v alias | column -n -t -s '☠'"
git config --global alias.br branch
git config --global alias.cbr 'symbolic-ref --short HEAD'
git config --global alias.ci commit
git config --global alias.cl '! git --no-pager log'
git config --global alias.co checkout
git config --global alias.dt difftool
git config --global alias.f fetch
git config --global alias.graph 'log --graph --format=distinguishedoneline'
git config --global alias.l '! git --no-pager lv --max-count=10'
git config --global alias.ll '! git --no-pager llv --max-count=2'
git config --global alias.llv 'log --format=distinguishedmediumtab'
git config --global alias.lv 'log --format=distinguishedonelinetab'
git config --global alias.ml '! git l --format=distinguishedoneline --author="$(git config --get user.name)"'
git config --global alias.mll '! git ll --author="$(git config --get user.name)"'
git config --global alias.mllv '! git llv --author="$(git config --get user.name)"'
git config --global alias.mlv '! git lv --format=distinguishedoneline --author="$(git config --get user.name)"'
git config --global alias.mrb '! git for-each-ref --format="%(color:66 bold)%(objectname:short)  %(color:173 nobold)%(authordate:format:%m/%d/%Y %I:%M %p)  %(color:150)%(authorname)  %(color:reset)%(refname:strip=3)" --sort=authordate refs/remotes | grep "$(git config --get user.name)"' 
git config --global alias.mt mergetool
git config --global alias.p pull
git config --global alias.rb '! git for-each-ref --format="%(color:66 bold)%(objectname:short)  %(color:173 nobold)%(authordate:format:%m/%d/%Y %I:%M %p)  %(align:28,left)%(color:150)%(authorname)%(end) %(color:reset)%(refname:strip=3)" --sort=authordate refs/remotes'
git config --global alias.st status
