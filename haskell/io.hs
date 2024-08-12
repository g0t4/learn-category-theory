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
  deriving (Show, Eq)

instance Functor (MyMaybe) where
  fmap :: (a -> b) -> MyMaybe a -> MyMaybe b
  fmap _ MyNothing = MyNothing
  fmap f (MyJust a) = MyJust (f a)

instance Applicative (MyMaybe) where
  pure :: a -> MyMaybe a
  -- FYI Monad's return = pure (https://github.com/ghc/ghc/blob/a1e42e7ac6121404afb2a42e11d0c778ce0fe483/libraries/ghc-internal/src/GHC/Internal/Base.hs#L1370-L1372)
  pure a = MyJust a

  liftA2 :: (a -> b -> c) -> MyMaybe a -> MyMaybe b -> MyMaybe c
  liftA2 f fa fb = MyNothing -- TODO impl this

instance Monad (MyMaybe) where
  (>>=) :: MyMaybe a -> (a -> MyMaybe b) -> MyMaybe b
  MyNothing >>= _ = MyNothing
  MyJust x >>= f = f x

-- instance (Show a) => Show (MyMaybe a) where
--   show MyNothing = "My Nothing"
--   show (MyJust x) = show x

testMaybeMonad = do
  let wesAge = "5"
  let paxAge = "10"
  let otherAge = ""

  let j5 = MyJust 5
  print j5

  let fmapJ5 = fmap id j5
  print (fmapJ5 == j5)
