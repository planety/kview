import karax / [karaxdsl, vdom]

import unittest, os, strutils

import ../karax_view/src/view


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


suite "Test Karax View":
  let 
    first = "first"
    second = "second"
  test "can generate test_login.html":
    discard login(first)
    discard login(second)
    check readFile("tests/test_login.html").strip() == """<div class="mt-3">
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
