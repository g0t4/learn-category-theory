remainder = rem

fizzBuzzFor num
  | num `remainder` 15 == 0 = "fizzbuzz"
  | num `remainder` 5 == 0 = "buzz"
  | num `remainder` 3 == 0 = "fizz"
  | otherwise = show num

main = do
  let numbers = [1 .. 15]
  let fors = map fizzBuzzFor numbers
  print fors
  let combined = foldl (\a b -> a ++ " " ++ b) "" fors -- extra leading " "
  print combined

test2 = do
  let fizzBuzz upTo
        | upTo > 1 = fizzBuzz (upTo - 1) ++ " " ++ fizzBuzzFor (upTo)
        | upTo == 1 = fizzBuzzFor (upTo)
        | otherwise = ""

  let result = fizzBuzz 10
  print result