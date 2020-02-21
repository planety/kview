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
    procName = definition[0]
  else:
    discard

  let
    res = ident"result"
    procNameId = ident("karax_view_proc_name")
    procNameDef = newLetStmt(procNameId, procName.toStrLit)
    procWriteOnce = quote do:
      once:
        writeFile(getAppFilename()[0 .. ^5] & "_" &
            `procNameId` & ".html", $(`res`))

  procDef.body.insert(0, procNameDef)
  procDef.body.add(procWriteOnce)

  return procDef

when isMainModule:
  import karax / [karaxdsl, vdom]

  const places = @["boston", "cleveland", "los angeles", "new orleans"]


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
