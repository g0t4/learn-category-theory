import Data.Char
import Data.List (intercalate, intersperse)

remainder = rem

fizzBuzzFor num
  | num `remainder` 15 == 0 = "fizzbuzz"
  | num `remainder` 5 == 0 = "buzz"
  | num `remainder` 3 == 0 = "fizz"
  | otherwise = show num

testWithLists = do
  let numbers = [1 .. 15]
  let fors = map fizzBuzzFor numbers
  print fors
  let combined = foldl (\a b -> a ++ " " ++ b) "" fors -- extra leading " "
  print combined

  -- intercalate definition: https://github.com/g0t4/learn-category-theory/blob/f3ab0cb21f108449fc7edf28c1290ba70b2795b6/haskell/loops.hs#L17
  let combined2 = intercalate " " fors -- no extra leading " "
  print combined2

  let forsWithSeparators = intersperse " " fors
  print forsWithSeparators
  let joined = concat forsWithSeparators
  print $ "joined:  " ++ joined

testWithListsSimplified = do
  -- definitely concise, but IMO somewhat difficult to read
  let result = intercalate " " (map fizzBuzzFor [1 .. 15])
  print result

testInfixMap = do
  let myMap = flip map
  let result = intercalate " " ([1 .. 15] `myMap` fizzBuzzFor)
  print result

testWithRecursive = do
  let fizzBuzz upTo
        | upTo > 1 = fizzBuzz (upTo - 1) ++ " " ++ fizzBuzzFor (upTo)
        | upTo == 1 = fizzBuzzFor (upTo)
        | otherwise = ""

  let result = fizzBuzz 10
  print result

asideTrim = do
  -- prompted to trim by example in haskell book leaving undesired trailing spaces, or above in my foldl when I have undesired leading " " (would need trimStart)
  let trimEnd = reverse . dropWhile isSpace . reverse
  print $ trimEnd " foo "
  let trimStart = dropWhile isSpace
  print $ trimStart " bar "