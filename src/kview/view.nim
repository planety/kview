import macros

import os


macro writeExample*(procDef: untyped): untyped =
  procDef.expectKind(nnkProcDef)
  var procName: NimNode
  let definition = procDef[0]
  case definition.kind
  of nnkPostfix:
    # Postfix
    # Ident "*"
    # Ident "hello"
    procName = definition[1]
  of nnkIdent:
    # Ident "hello"
    procName = definition
  else:
    discard

  let
    res = ident"result"
    procNameStr = procName.toStrLit
    procWriteOnce = quote do:
      once:
        writeFile(getAppFilename()[0 .. ^5] & "_" &
            `procNameStr` & ".html", $(`res`))

  procDef.body.add(procWriteOnce)

  return procDef

when isMainModule:
  import karax / [karaxdsl, vdom]

  const 
    places = @["boston", "cleveland", "los angeles", "new orleans"] 
    first = "first"
    second = "second"

  proc login*(name: string): string {.writeExample.} =
    let vnode = buildHtml(tdiv(class = "mt-3")):
      h1: text "My Web Page"
      p: text "Hello " & name
      ul:
        for place in places:
          li: text place
      dl:
        dt: text "Can I use Karax for client side single page apps?"
        dd: text "Yes"

        dt: text "Can I use Karax for server side HTML rendering?"
        dd: text "Yes"
    result = $vnode

  discard login(first)
  discard login(second)
