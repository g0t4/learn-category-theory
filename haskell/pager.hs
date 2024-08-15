import System.Directory.Internal.Prelude (getArgs)

-- based on Effective Haskell book example, with my own improv along the way

-- args = getArgs

myPrintArgs [] = putStrLn ""
myPrintArgs (head : rest) = putStrLn head >> myPrintArgs rest

main = do
  -- runhaskell pager.hs --foo bar
  args <- getArgs
  foldl (\a c -> a >> putStrLn c) (putStrLn "") args

  --  myPrintArgs args
