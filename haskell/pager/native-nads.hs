import GHC.Base (when)

-- USE native monad/applicative/functor classes and instances
-- mostly to avoid my custom impls (i.e. Prelude.<$ vs Main.<$ in mynads.hs)

testFunctorInterface = do
  let a = Just 3
      s1 = "Foo"
      b = Just 5
      c = fmap (+ 2) a
      d = True <$ c -- replace 3 in c with True
      -- in print c *> print d -- *> sequence actions (IIUC evaluate both sides), discard value of LHS
      -- in print c <* print d -- sequence actions, discard value of RHS (IIUC)
  print "foo"

testListFmap = do
  let names = ["boo", "baz", "dan"]
  print (fmap (++ "foo") names) -- applied to each item

testConstAndId = do
  -- always return first arg, ignores second arg
  -- IMPL:
  -- const a _ = a
  --
  print $ const 1 2 -- 1
  print (const "foo" 2) -- "foo"

  -- id a = a
  -- https://github.com/ghc/ghc/blob/6d779c0fab30c39475aef50d39064ed67ce839d7/libraries/ghc-internal/src/GHC/Internal/Base.hs#L2018-L2020
  print (id 1)
  print $ id "foo"
  -- use id predicate to count bool True values
  print $ length (filter id [True, False, True])
  print $ length $ filter id [True, False, True] -- alternate use $ operator (infixr 0 $) b/c it applies Right to Left... and is lowest precedence so all other ops are completed first and then it takes right most value and passes it to LHS arg... and in this case that result is then the RHS value for the LHS print ... often used to elide parenthesis... which I dunno, I kinda prefer parens but I get the thought process of $ and similarish ops like <$>
  -- ($) :: (a -> b) -> a -> b   -- literally is take a func (LHS) and then the func's single arg a and evaluate it!

testWrappingPureReturn = do
  print (pure 1 :: Maybe Int) -- have to give type hint
  print (pure 1 :: [Int])
  print (pure "foo" :: Maybe String)
  print (Just "foo") -- same thing
  print (return "foo" :: Maybe String)

  let pureMaybe = (pure :: x -> Maybe x) -- lock the container type while leaving contents type alone
  print (pureMaybe 1)
  print (pureMaybe "oof")

testList = do
  let a = [(+ 1), (+ 2), (+ 3)]
  let b = [1, 10, 100]
  print $ a <*> b -- product of each function f (each b) uses list comprehension

testSequenceOps = do
  -- id <$ print 2
  -- (print 1) >> (print 2)
  (print 1) *> (print 2) -- sequence actions, discard value of first
  (print 1) <* (print 2) -- sequence actions, discard value of second

testWhen =
  when True (print "foo")
testWhenFalse =
  when False (print "bar")