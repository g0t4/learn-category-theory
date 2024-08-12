test1 = putStrLn "foo" >> putStrLn "bar"

test2 = do
  let foo = putStr "foo"
  let bar = putStr "bar"
  let nl = putStrLn mempty

  let both = nl >> foo >> nl >> bar >> nl

  bar >> foo >> nl
  bar >> foo >> nl
  both
  both

testReadLine = do
  putStrLn "type a line and hit return when done: "
  user_input <- getLine
  putStr "you typed: " >> putStr user_input

  -- Monad has >> operator which essentially sequences two operations and discards the result of the first, for reasons of side effects, the final result is the result of the right operation
  putStrLn mempty >> putStrLn mempty >> putStr "type a character: "
  a_char <- getChar
  putStrLn mempty >> putStrLn "you typed: " >> putChar a_char >> putStrLn mempty

data MyMaybe a = MyNothing | MyJust a
  deriving (Show)
  
testMaybeMonad = do
  let wesAge = "5"
  let paxAge = "10"
  let otherAge = ""

  let j5 = MyJust 5
  print j5
