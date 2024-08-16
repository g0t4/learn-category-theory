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

runHCat = do
  Exception.catch happyPath (putStrLnRed . show @IOError) -- @IOError is a type hint to inference
 where
  sadPath = print @IOError
  happyPath =
    do
      -- ALSO, even if not chained w/ >>=... do block still ensures each top level do statement is evaluated (for side effects), hence this works to double the file with two diff styles:
      happy1single
      happy1split
      happy2single
      happy2split
      happy3mix
      happy4allIntermediate
      happy5combined
  happy5combined =
    do
      fileName <- parseArgs =<< getArgs
      TextIO.putStrLn =<< TextIO.readFile fileName
  happy4allIntermediate =
    do
      args <- getArgs
      fileName <- parseArgs args
      contents <- TextIO.readFile fileName
      TextIO.putStrLn contents
  happy3mix =
    do
      args <- getArgs
      parseArgs args
      >>= TextIO.readFile
      >>= TextIO.putStrLn
  happy1split =
    do
      getArgs
      >>= parseArgs
      >>= TextIO.readFile
      >>= TextIO.putStrLn
  happy1single =
    getArgs >>= parseArgs >>= TextIO.readFile >>= TextIO.putStrLn
  happy2single =
    do
      TextIO.putStrLn =<< TextIO.readFile =<< parseArgs =<< (getArgs :: IO [String])
  -- FYI `=<<` ~= `flip . >>=` for do blocks after `<-` ... USE this if NOT WANT intermediate variables for each step, cool... do blocks are flexible
  -- https://github.com/g0t4/learn-category-theory/blob/1eb2fdf6eee7161e56a98ca2da0ebb4bb15b68ed/haskell/pager/pager.hs#L33
  happy2split =
    do
      TextIO.putStrLn
        =<< TextIO.readFile
        =<< parseArgs
        =<< (getArgs :: IO [String])

resetColor = "\x1b[0m"
colorText color text = color ++ text ++ resetColor
redText = colorText "\x1b[31m"
putStrLnRed = putStrLn . redText

parseArgs :: [String] -> IO String
-- by rewriting parseArgs to use bind, we can now control returning the IO monad and thus we can throw an error (or return string) and don't need the Either type any longer!
parseArgs [] = Exception.throwIO . IOError.userError $ "No file provided"
parseArgs (head : _) = return head
