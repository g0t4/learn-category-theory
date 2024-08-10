positiveIntegers =
  let rest n = n : rest (n + 1)
   in 0 : (rest 0)

testLazyLoad = do
  print $ positiveIntegers !! 4 -- only need to evaluate first 4 elements of list and thus infinite list is not created