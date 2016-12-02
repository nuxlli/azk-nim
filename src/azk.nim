
import duktape
import streams
import docopt

let fs  = newFileStream("./share/locales/usage-en.txt", fmRead)
let doc = readAll(fs)
fs.close

# echo doc
var args = docopt(doc, version = "azk 0.1.0")
if args["info"]:
  var dt = new Duktape()
  dt.eval("""
    var pp = require('./modules/utils.js').prettyPrint;
    try {
      var _systems = {}
      function systems(data) { _systems = data; }
      function path(data) { return data; }
      function sync(data) { return data; }
      require('./Azkfile.js');
      pp("Azkfile", _systems);
    } catch (e) {
      pp(e);
    }
  """)
else:
  echo doc
