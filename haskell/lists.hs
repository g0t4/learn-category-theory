testIndexingLists = do
  let numbers = ['a' .. 'z']
  print $ "0th letter: " <> show (numbers !! 0)
  let getNthElement list n = list !! n
  print $ "1st letter: " <> show (getNthElement numbers 1)
  let printNthElement list n =
        print $ show (n) <> "th letter: " <> show (getNthElement list n)
  printNthElement numbers 2

testCons = do
  print $ 1 : [2, 3] -- == [1,2,3]
  let cons = (:)
  print $ cons 1 [2, 3]
  print $ 1 `cons` [2, 3]

  print $ 'f' : 'o' : 'o' : "bar"

  -- aside, using <> to prepend
  print $ [1] <> [2, 3]

-- testHeadTails = do
--   let numbers = 1 : 2 : [3]
--   print $ "head: " <> show (head numbers)
--   print $ "tail: " <> show (tail numbers)

countDown n
  | n == 0 = []
  | otherwise = n : countDown (n - 1)

countTo = reverse . countDown

-- -- head/tail warnings, commented out this:
-- sumRecursive nums =
--   sumRecursive' nums
--   where
--     sumRecursive' nums
--       | nums == [] = 0
--       | otherwise = head (nums) + sumRecursive' (tail (nums))

sumRecursive1 :: (Num t) => [t] -> t
sumRecursive1 [] = 0
sumRecursive1 (head : rest) = head + sumRecursive1 (rest)

myFoldL :: (t1 -> t2 -> t1) -> t1 -> [t2] -> t1
myFoldL project accumulated [] = accumulated
myFoldL project accumulated (head : rest) = myFoldL project (project accumulated head) rest

summer = myFoldL (+) 0

-- summer' list = myFoldL (+) 0 list -- explicit list arg

-- countChars ["foo","the","b"] == 7
--   this is why accum and list type don't have to match
countChars :: [String] -> Int
countChars = myFoldL (\accum head -> accum + length (head)) 0
