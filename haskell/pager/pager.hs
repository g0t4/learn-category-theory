import Control.Exception qualified as Exception
import System.Environment (getArgs)
import System.IO.Error qualified as IOError

-- based on Effective Haskell book example, with my own improv along the way

-- args = getArgs

noop = return ()
myPrintArgs args = foldl (\accum current -> accum >> putStrLn ("  " <> current)) noop args

-- runhaskell pager.hs --foo bar
-- ghci => :load pager.hs =>  System.Environment.withArgs ["--foo", "--bar"] runHCat
main =
  runHCat >>= print

runHCat = do
  (getArgs :: IO [String])
    >>= parseArgs -- <$> (aka fmap) is needed to apply func w/o IO monad wrapper, think of this as the pure functional middle part, so <$> takes this out of the IO paradigm long enough to start parsing args

parseArgs :: [String] -> IO String
parseArgs [] = Exception.throwIO . IOError.userError $ "you forgot to pass args"
parseArgs (head : _) = return head