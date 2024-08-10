positiveIntegers =
  -- cons operator affords a generator like effect with lazy load
  let rest n = n : rest (n + 1)
   in rest 0 -- start at 0

testLazyLoad = do
  print $ positiveIntegers !! 4 -- only need to evaluate first 4 elements of list and thus infinite list is not created