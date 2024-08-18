{-# LANGUAGE OverloadedStrings #-}

import Fmt -- redundnat b/c in .cabal file too

testFormatting = do
  let name = "foo"
      last_name = "bar"
      age = 100

  print "foo"

-- cabal repl -- b/c this deps on Fmt