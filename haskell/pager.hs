import System.Directory.Internal.Prelude (getArgs)

-- based on Effective Haskell book example, with my own improv along the way

-- args = getArgs

noop = return ()
myPrintArgs = foldl (\accum current -> accum >> putStrLn current) noop

-- runhaskell pager.hs --foo bar
main =
  getArgs >>= myPrintArgs
