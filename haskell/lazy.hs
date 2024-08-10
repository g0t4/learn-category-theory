positiveIntegers =
  -- cons operator affords a generator like effect with lazy evaluation
  let rest n = n : rest (n + 1)
   in rest 0 -- start at 0

testLazyEvaluate = do
  print $ positiveIntegers !! 4 -- only need to evaluate first 4 elements of list and thus infinite list is not created