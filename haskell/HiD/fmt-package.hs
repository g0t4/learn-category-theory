{-# LANGUAGE OverloadedStrings #-}

import Fmt

testFormatting = do
  let name = "foo"
      last_name = "bar"
      age = 100

  fmt $ "name: " +| name |+ ", last: " +| last_name |+ ""