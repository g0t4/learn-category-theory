{-# LANGUAGE OverloadedStrings #-}

import Data.Text (Text)
import Fmt

testFormatting :: Text
testFormatting =
  let name = "foo"
      last_name = "bar"
      age = 100
   in -- fmt $ "name: " +|name|+ ", last: " +|last_name|+ ""
      fmt ("Hello, " +|| name ||+ "!")

-- fmt is using show on name? and even if "world" constant String passed it uses show before buidling it into string so its wrapped funny... wtf is going on.. this is the issue with all this type magic and compiler inference... it becomes next to impossible to know wtf is going to happen at runtime and/or when smth goes wrong b/c type inference is far too sophisticated to track all of how it will behave at runtime (why the same expression behaves different based on imports and type signatures is somewhat a problem IMO)
-- cabal repl -- b/c this deps on Fmt

testBasic =
  let name = "Alice" :: String
   in "Meet " +| name |+ "!" :: String
testBasicText =
  let name = "Alice" :: Text
   in "Meet " +| name |+ "!" :: Text -- IIUC the desired type forces the builder to produce it, i.e. build a Text response (vs String above)