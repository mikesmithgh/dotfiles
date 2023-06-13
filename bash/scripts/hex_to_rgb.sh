#!/bin/bash

usage() {
    echo ""
    echo "$0 - Convert hex color code to RGB and RGB to HEX (Hexadecimal)"
    echo ""
    echo "Usage: $0 [HEX] or [RGB] color value"
    echo ""
    echo "Example HEX to RGB: $0 0000ff"
    echo "Example RGB to HEX: $0 0,0,255"
    echo ""
    exit 1
}

if [ $# -eq 0 ]; then
    echo 'Invalid color value!';
    usage;
fi

if [[ $1 =~ ([[:xdigit:]]{2})([[:xdigit:]]{2})([[:xdigit:]]{2}) ]]; then
    printf "%d %d %d" \
           0x"${BASH_REMATCH[1]}" 0x"${BASH_REMATCH[2]}" 0x"${BASH_REMATCH[3]}"
elif [[ $1 =~ ([[:digit:]]{1,3}),([[:digit:]]{1,3}),([[:digit:]]{1,3}) ]]; then
    printf "#%02x%02x%02x\n" \
           "${BASH_REMATCH[1]}" "${BASH_REMATCH[2]}" "${BASH_REMATCH[3]}"
fi

# #!/bin/bash
#
# usage() {
#     echo ""
#     echo "$0 - Convert hex color code to RGB and RGB to HEX (Hexadecimal)"
#     echo ""
#     echo "Usage: $0 [HEX] or [RGB] color value"
#     echo ""
#     echo "Example HEX to RGB: $0 0000ff"
#     echo "Example RGB to HEX: $0 0,0,255"
#     echo ""
#     exit 1
# }
#
# if [ $# -eq 0 ]; then
#     echo 'Invalid color value!';
#     usage;
# fi
#
# printf "%d %d %d\n" 0x"${1:0:2}" 0x"${1:2:2}" 0x"${1:4:2}"
#
# echo "$1" | awk '{
#   hex=$1
#   r_hex=sprintf("0x%s",substr(hex, 1, 2))
#   g_hex=sprintf("0x%s",substr(hex, 3, 2))
#   b_hex=sprintf("0x%s",substr(hex, 5, 2))
#   printf "%d %d %d\n",r_hex,g_hex,b_hex
# }'
#   # printf "0x%s ",substr($1, 0, 2)
#   # printf "0x%s ",substr($1, 2, 2)
#   # printf "0x%s\n",substr($1, 4, 2)
