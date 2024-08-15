import System.Directory.Internal.Prelude (getArgs)

-- based on Effective Haskell book example, with my own improv along the way

-- args = getArgs

myPrintArgs [] = putStrLn ""
myPrintArgs (head : rest) = putStrLn head >> myPrintArgs rest

-- runhaskell pager.hs --foo bar
main =
  getArgs >>= \args ->
    foldl (\accum current -> accum >> putStrLn current) (putStrLn "") args

--  myPrintArgs args
