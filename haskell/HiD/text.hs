-- while working through Haskell in Depth book (manning)
import Data.Char (isLetter)

myTakeWhile :: (a -> Bool) -> [a] -> [a]
myTakeWhile _ [] = []
myTakeWhile func (head : rest)
  | func (head) = head : myTakeWhile func rest
  | otherwise = []

testTakeWhile = do
  print $ takeWhile isLetter "foo-the-bar"