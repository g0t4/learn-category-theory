-- while working through Haskell in Depth book (manning)
import Data.Char (isLetter, isSpace)
import Data.Text (dropAround, pack)

myTakeWhile :: (a -> Bool) -> [a] -> [a]
myTakeWhile _ [] = []
myTakeWhile func (head : rest)
  | func head = head : myTakeWhile func rest
  | otherwise = []

testTakeWhile = do
  print $ myTakeWhile isLetter "foo-the-bar"

myDropWhen :: (a -> Bool) -> [a] -> [a]
myDropWhen _ [] = []
myDropWhen func (head : rest)
  -- THis is more like drop when? dropAround behaves different (seems to keep until first match and then do the same from end foward until first match?)
  | func head = myDropWhen func rest -- drop if match predicate? IncoherentInstances
  | otherwise = head : myDropWhen func rest

testDropAround = do
  print $ myDropWhen isLetter "foo-the-bar"
  print $ myDropWhen (not . isLetter) "foo-the-bar"
  print $ dropAround isLetter (pack "foo-the-bar") -- => "-the-" dropAroundUntil is how this works
  -- dropAround is very much like a trim but with any char predicates
  let trim = dropAround isSpace
  print $ trim (pack "  foo the bar     ")
