VIDEO_DATA=`youtube-dl -g --get-url --get-filename "$1"`
FILENAME=`echo "$VIDEO_DATA" | tail -n 1`
URL=`echo "$VIDEO_DATA" | head -n 1`
#aria2c -s 16 -o "$FILENAME" "$URL"
#echo "antes"
PREF=""

if [ -e "$HOME/down/.yt/old/$FILENAME" ]
then
  PREF="old/"
fi

diana --out="${PREF}${FILENAME}" add $URL

FILE="${HOME}/down/.yt/${PREF}${FILENAME}.aria2"

cont=1
while [ ! -e "${HOME}/down/.yt/${PREF}${FILENAME}.aria2" ]
do
  sleep 1
  let cont++
  if [ $cont -ge 120 ]
  then 
    break
  fi
done

if [ -e "${HOME}/down/.yt/${PREF}${FILENAME}.aria2" ]
  then
    echo "existe, poha"
  else
    echo "nao existe, caralho"
fi

while [ -e "${HOME}/down/.yt/${PREF}${FILENAME}.aria2" ]
do
  sleep 2
done

echo "acordou"
echo pause | mplayer -slave "$HOME/down/.yt/${PREF}${FILENAME}"

#echo "depois"
#mplayer /home/thi/down/.yt/"$FILENAME"
#https://github.com/tobbez/youtube-dl-aria/blob/master/youtube-dl-aria
