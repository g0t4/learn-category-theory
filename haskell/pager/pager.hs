import System.Environment (getArgs)

-- based on Effective Haskell book example, with my own improv along the way

-- args = getArgs

noop = return ()
myPrintArgs args = foldl (\accum current -> accum >> putStrLn current) noop args

-- runhaskell pager.hs --foo bar
main =
  runHCat

runHCat =
  getArgs >>= myPrintArgs
