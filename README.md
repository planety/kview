![Test Prologue](https://github.com/planety/kview/workflows/Test%20Prologue/badge.svg)

# kview

### Installation

```text
nimble install https://github.com/planety/karax_view
```

For karax html preview written in Nim.

```nim
# app.nim
import os, strutils

from kview import writeExample
import karax / [karaxdsl, vdom]

const 
  places = @["boston", "cleveland", "los angeles", "new orleans"] 
  first = "first"
  second = "second"

# will write app_login.html
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

assert readFile("app_login.html").strip() == """<div class="mt-3">
  <h1>My Web Page</h1>
  <p>Hello first</p>
  <ul>
    <li>boston</li>
    <li>cleveland</li>
    <li>los angeles</li>
    <li>new orleans</li>
  </ul>
  <dl>
    <dt>Can I use Karax for client side single page apps?</dt>
    <dd>Yes</dd>
    <dt>Can I use Karax for server side HTML rendering?</dt>
    <dd>Yes</dd>
  </dl>
</div>
""".strip()
```

more examples in [tests](https://github.com/planety/kview/blob/master/tests/test.nim).
