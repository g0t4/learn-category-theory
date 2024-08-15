import System.Environment (getArgs)

-- based on Effective Haskell book example, with my own improv along the way

-- args = getArgs

noop = return ()
myPrintArgs args = foldl (\accum current -> accum >> putStrLn ("  " <> current)) noop args

-- runhaskell pager.hs --foo bar
-- ghci => :load pager.hs =>  System.Environment.withArgs ["--foo", "--bar"] runHCat
main =
  runHCat >>= print

runHCat = do
  (getArgs :: IO [String]) >>= parseArgs -- or use bind and require func to wrap (return) on its return... messier obviously (just a good mental exercise to practice using bind vs fmap)

parseArgs :: [a] -> IO (Either String a)
parseArgs [] = return (Left "you forgot to pass args")
parseArgs (head : _) = return (Right head)