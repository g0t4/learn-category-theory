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

  putStrLn mempty >> putStrLn mempty >> putStr "type a character: "
  a_char <- getChar
  putStrLn mempty >> putStrLn "you typed: " >> putChar a_char >> putStrLn mempty