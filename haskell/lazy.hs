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

-- THAT SAID GOOD GOD WHY USE foldr to find the first item in a list! ... makes me wonder why the author even brought up foldr with this scenario other than an obscure example of lazy eval... yuck... the following is lazy eval for the same reason and is 1,000,000,000% easier to grok:

myFindFirst predicate (head : rest)
  | predicate head = [head]
  | otherwise = myFindFirst predicate rest
myFindFirst _ [] = [] -- ok to put this one last though might be best to put it first since it is a base case and it is not that intuitive to know that (head : rest) won't match an empty list

testMyFindFirst = do
  print $ myFindFirst (> 5) [1, 3 .. 10]
  print $ myFindFirst (> 9) [1, 3 .. 10]
  print $ myFindFirst (> 100) positiveIntegers
  print $ myFindFirst (> 50) [1 ..]

fibSequence =
  0 : 1 : fibs' 1 0
  where
    fibs' p2 p1 =
      let next = p1 + p2
       in next : fibs' next p2

testFibSequence = do
  print $ takeWhile (< 100) fibSequence
