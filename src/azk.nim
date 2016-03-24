
import duktape

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
