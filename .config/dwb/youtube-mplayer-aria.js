//!javascript
// roda videos do youtube
var regex = new RegExp("http(.*)://www.youtube.com/watch\\?(.*&)*v=.*");

signals.connect("navigation", function (wv, frame, request) {
  if (wv.mainFrame == frame && regex.test(request.uri)){
    system.spawn("sh /home/thi/.config/dwb/userscripts/youtube-dl-aria.sh " + request.uri);
        return false;
  }});
