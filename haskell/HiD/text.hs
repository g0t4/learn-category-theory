-- while working through Haskell in Depth book (manning)
import Data.Char (isLetter)

myTakeWhile :: (a -> Bool) -> [a] -> [a]
myTakeWhile _ [] = []
myTakeWhile func (head : rest)
  | func head = head : myTakeWhile func rest
  | otherwise = []

testTakeWhile = do
  print $ myTakeWhile isLetter "foo-the-bar"

myDropAround :: (a -> Bool) -> [a] -> [a]
myDropAround _ [] = []
myDropAround func (head : rest)
  | func head = myDropAround func rest -- drop if match predicate? IncoherentInstances
  | otherwise = head : myDropAround func rest

testDropAround = do
  print $ myDropAround isLetter "foo-the-bar"
  print $ myDropAround (not . isLetter) "foo-the-bar"
