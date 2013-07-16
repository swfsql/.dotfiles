VIDEO_DATA=`youtube-dl -g --get-url --get-filename "$1"`
FILENAME=`echo "$VIDEO_DATA" | tail -n 1`
URL=`echo "$VIDEO_DATA" | head -n 1`
PREF=""

if [ -e "$HOME/yt/old/$FILENAME" ]
then
  PREF="old/"
fi

FILE="${HOME}/yt/${PREF}${FILENAME}.aria2"

cont=1

if [ ! -e "$FILE" ] && [ ! -e "${HOME}/yt/${PREF}${FILENAME}"  ]
then
  diana --out="${PREF}${FILENAME}" add $URL
  while [ ! -e "FILE" ]
  do
    sleep 1
    let cont++
    if [ $cont -ge 120 ]
    then 
      break
    fi
  done
else
  diana --out="${PREF}${FILENAME}" add $URL
fi

while [ -e "$FILE" ]
do
  sleep 2
done

echo pause | mplayer -slave "${HOME}/yt/${PREF}${FILENAME}"

#https://github.com/tobbez/youtube-dl-aria/blob/master/youtube-dl-aria
