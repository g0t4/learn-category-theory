import Control.Exception qualified as Exception
import Data.ByteString qualified as ByteString
import Data.Text qualified as Text
import Data.Text.IO qualified as TextIO
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
    >> putStrLn "press any key to terminate..."
    >> getChar
    >> print "done"

runHCat = do
  Exception.catch happyPath (putStrLnRed . show @IOError) -- @IOError is a type hint to inference
 where
  happyPath =
    do
      args <- getArgs -- FYI `<-` unwraps IO [String] into just [String], just like the actual bind function does, so that means cannot use bind >>= on the result
      parseArgs args
      >>= TextIO.readFile
      >>= TextIO.putStrLn
  sadPath = print @IOError

resetColor = "\x1b[0m"
colorText color text = color ++ text ++ resetColor
redText = colorText "\x1b[31m"
putStrLnRed = putStrLn . redText

parseArgs :: [String] -> IO String
-- by rewriting parseArgs to use bind, we can now control returning the IO monad and thus we can throw an error (or return string) and don't need the Either type any longer!
parseArgs [] = Exception.throwIO . IOError.userError $ "No file provided"
parseArgs (head : _) = return head
