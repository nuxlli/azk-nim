import ../vendor/nim-extensions/oop_macro
export oop_macro

import streams
import duktape_sys

class Duktape* of RootObj:
  var context: DTContext

  method init*(context: DTContext) {.base.} =
    self.context = context

    var require: DTCFunction = (proc (ctx: DTContext): cint{.cdecl.} =
      var duktape = new Duktape(context: ctx)
      return cast[cint](duktape.require())
    )
    var _ = self.add_function(require, "require")

  method init*() {.base.} =
    self.init(duk_create_heap_default())

  method eval*(code: string) {.base.} =
    try:
      duk_eval_string(self.context, code)
    except:
      let
        e = getCurrentException()
        msg = getCurrentExceptionMsg()
      echo "Got exception ", repr(e), " with message ", msg

  method to_string*(index: cint): cstring {.base.} =
    return duk_to_string(self.context, index)

  method add_function*(ptrf: DTCFunction, name: string): bool {.base.} =
    duk_push_c_function(self.context, ptrf, cast[cint](-1))
    var r = duk_put_global_string(self.context, name)
    result = cast[bool](r)

  method require(): int {.base.} =
    var file = self.to_string(0)
    try:
      var fs = newFileStream($file, fmRead)
      self.eval(readAll(fs))
      fs.close()
    except:
      let
        e = getCurrentException()
        msg = getCurrentExceptionMsg()
      echo "Got exception ", repr(e), " with message ", msg
    result = 1
