VIDEO_DATA=`youtube-dl -g --get-url --get-filename "$1"`
FILENAME=`echo "$VIDEO_DATA" | tail -n 1`
URL=`echo "$VIDEO_DATA" | head -n 1`
PREF=""

if [ -e "$HOME/down/.yt/old/$FILENAME" ]
then
  PREF="old/"
fi

diana --out="${PREF}${FILENAME}" add $URL

FILE="${HOME}/down/.yt/${PREF}${FILENAME}.aria2"

cont=1

if [ ! -e "$FILE" ] && [ ! -e "${HOME}/down/.yt/${PREF}${FILENAME}"  ]
then
  while [ ! -e "FILE" ]
  do
    sleep 1
    let cont++
    if [ $cont -ge 120 ]
    then 
      break
    fi
  done
fi

while [ -e "$FILE" ]
do
  sleep 2
done

echo pause | mplayer -slave "${HOME}/down/.yt/${PREF}${FILENAME}"

#https://github.com/tobbez/youtube-dl-aria/blob/master/youtube-dl-aria
