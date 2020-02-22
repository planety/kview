# Package

version       = "0.1.2"
author        = "flywind"
description   = "For karax html preview."
license       = "BSD-3-Clause"
srcDir        = "src"



# Dependencies

requires "nim >= 1.0.0"
requires "karax"


task test, "Run all tests":
  exec "nim c -r tests/test.nim"
