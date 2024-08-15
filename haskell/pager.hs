import System.Directory.Internal.Prelude (getArgs)

-- based on Effective Haskell book example, with my own improv along the way

-- args = getArgs

myPrintArgs args = foldl (\accum current -> accum >> putStrLn current) (putStrLn "") args

-- runhaskell pager.hs --foo bar
main =
  getArgs >>= \args ->
    myPrintArgs args

--  myPrintArgs args
