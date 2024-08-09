testIndexingLists = do
  let numbers = ['a' .. 'z']
  print $ "0th letter: " <> show (numbers !! 0)
  let getNthElement list n = list !! n
  print $ "1st letter: " <> show (getNthElement numbers 1)
  let printNthElement list n =
        print $ show (n) <> "th letter: " <> show (getNthElement list n)
  printNthElement numbers 2