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
    >>= parseArgs

parseArgs :: [String] -> IO String
-- by rewriting parseArgs to use bind, we can now control returning the IO monad and thus we can throw an error (or return string) and don't need the Either type any longer!
parseArgs [] = Exception.throwIO . IOError.userError $ "you forgot to pass args"
parseArgs (head : _) = return head