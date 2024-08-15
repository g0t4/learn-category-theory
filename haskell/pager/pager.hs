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
  runHCat
    >>= putStrLn

runHCat = do
  Exception.catch happyPath (return . (show @IOError)) -- @IOError is a type hint to inference
 where
  happyPath =
    do
      (getArgs :: IO [String])
      >>= parseArgs
      >>= readFile

parseArgs :: [String] -> IO String
-- by rewriting parseArgs to use bind, we can now control returning the IO monad and thus we can throw an error (or return string) and don't need the Either type any longer!
parseArgs [] = Exception.throwIO . IOError.userError $ "Hey dumbhead, pass a filename next time, derp..."
parseArgs (head : _) = return head