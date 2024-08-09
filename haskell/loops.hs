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

