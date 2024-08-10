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