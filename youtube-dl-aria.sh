VIDEO_DATA=`youtube-dl -g --get-url --get-filename "$1"`
FILENAME=`echo "$VIDEO_DATA" | tail -n 1`
URL=`echo "$VIDEO_DATA" | head -n 1`
aria2c -s 16 -o "$FILENAME" "$URL"
mplayer /home/thi/down/.yt/"$FILENAME"
#https://github.com/tobbez/youtube-dl-aria/blob/master/youtube-dl-aria
