
# Bind duktape funcions and types

{.compile: "../vendor/duktape/duktape.c".}

type
  DTContext* = pointer
  DTCFunction* = proc (ctx: DTContext): cint{.cdecl.}

proc duk_create_heap_default*(): DTContext {.header: "duktape.h".}
proc duk_eval_string*(ctx: DTContext, s: cstring) {.header: "duktape.h".}
proc duk_to_string*(ctx: DTContext, index: cint): cstring {.header: "duktape.h".}

proc duk_push_number*(ctx: DTContext, index: cint) {.header: "duktape.h".}
proc duk_push_c_function*(ctx: DTContext, f: DTCFunction, nargs: cint) {.header: "duktape.h".}
proc duk_put_global_string*(ctx: DTContext, key: cstring): cint {.header: "duktape.h".}
