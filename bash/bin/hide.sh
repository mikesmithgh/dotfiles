#/bin/bash
hideinput()
{
  if [ -t 0 ]; then
     stty -echo -icanon time 0 min 0
  fi
}

cleanup()
{
  if [ -t 0 ]; then
    stty sane
  fi
}

trap cleanup EXIT
trap hideinput CONT
hideinput
while true; do
  read line
  sleep 2073600
done
echo
