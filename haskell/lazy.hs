positiveIntegers =
  -- cons operator affords a generator like effect with lazy evaluation
  let rest n = n : rest (n + 1)
   in rest 0 -- start at 0

testLazyEvaluate = do
  print $ positiveIntegers !! 4 -- only need to evaluate first 4 elements of list and thus infinite list is not created

myCycle [] = []
myCycle list =
  myCycle' list
  where
    myCycle' [] = myCycle' list -- restart when done with each cycle
    myCycle' (head : rest) =
      head : myCycle' rest

-- FYI `myCycle [0..1] !! 4` == 4 `mod` 2

-- much more succinct!
myCycle2 [] = []
myCycle2 list = list <> myCycle2 list

firstFive = filter (< 5) positiveIntegers

testFilter = do
  print $ firstFive

findFirst predicate =
  foldr findHelper []
  where
    findHelper listElement maybeFound
      | predicate listElement = [listElement]
      | otherwise = maybeFound

-- lazy eval + foldr impl:
-- b/c of how findFirst is defined, it can stop at the first matching element that satisifes the predicate and thus due to lazy eval we stop at that point and can foldr across an infinite list (b/c if we are contingent only on current item and don't express the accumulated value as a combination of subsequent items too then we can stop at the current item that satisifes a given predicate... interesting)...
-- IF HOWEVER I Used my REVERSE impl of myFoldR then findFirst wouldn't work for an infinite list...