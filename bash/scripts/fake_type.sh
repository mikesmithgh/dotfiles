#!/usr/bin/env bash
# bytes=$(wc -c </Users/mike/tmp/input.txt)
# file=$(</Users/mike/tmp/input.txt)
# for ((i = 0; i < bytes; i++)); do
# 	echo "$file" | cut -c $i
# 	# if [[ "$char" == '"' ]]; then
# 	# 	char="'"
# 	# fi
# 	# if [[ "$char" == "'" ]]; then
# 	# 	char='"'
# 	# fi
# 	# kitty @ send-text --match="id:417" "'""$char""'"
# 	# echo "$char"
# 	sleep 0.2
# done

bytes=$(wc -c </Users/mike/tmp/input.txt)
file=$(</Users/mike/tmp/input.txt)

for ((i = 0; i < bytes; i++)); do
	c=$(echo $file | cut -c $i)
	echo $c | xargs
	# if [[ "$char" == '"' ]]; then
	# 	char="'"
	# fi
	# if [[ "$char" == "'" ]]; then
	# 	char='"'
	# fi
	# echo "$char" | xargs kitty @ send-text --match="id:417"
	sleep 1
done
