import GHC.Base

testConditionalPrint = do
  when True (print "when true")
  when False (print "when false")

-- Functor, (think Functee?), like Employer/Employee?
-- Functor is a thing that can apply a function to a context? IOTW it wouldn't have the function, nor the instance... so it would take both of those as parameters (i.e. bind, fmap)
--

class MyFunbags f where
  fmapMy :: (a -> b) -> f a -> f b
  (<$) :: a -> f b -> f a
  (<$) a fb = fmapMy (const a) fb -- IOTW use fmapMy to take `a` and return `f a`, that is all that we are doing here, reusing fmapMy, ignore any b value passed... SO this is `return`/`pure` (think "wrap")?

  -- alias fmap to <$>
  infixl 4 <$>
  (<$>) :: (Functor f) => (a -> b) -> f a -> f b
  (<$>) = fmapMy

data MyThisOrThat a = MyThis a | MyThat a -- must have a type parameter to use it as a functor (which requires a type parameter)
  deriving (Show, Eq)

instance MyFunbags MyThisOrThat where
  fmapMy func (MyThis a) = MyThis (func a) -- destructuring is how you unwrap
  fmapMy func (MyThat a) = MyThat (func a) -- destructuring is how you unwrap

-- use a list as a "container"... and only allow first item to be a thing
instance MyFunbags [] where
  fmapMy func [] = []
  fmapMy func (head : _) = [func head] -- destructure to get the first item (only one allowed in this "container" I defined)

data MyBox a = MyBox a
  deriving (Show, Eq)

instance MyFunbags MyBox where
  fmapMy func (MyBox a) = MyBox (func a) -- destructuring == unwrap

testMyFunctorThisThat = do
  let first = MyThis 1
  let second = MyThat 2

  -- print $ fmapMy id first
  print $ fmapMy (* 8) first
  print $ fmapMy (* 8) second

  let wrappedInt = [1]
  -- print $ fmapMy id wrappedInt
  print $ fmapMy (/ 2) wrappedInt
  print $ fmapMy (/ 2) [10]
  print $ (/ 2) `fmapMy` [10]

testMyBox = do
  let box1 = MyBox 1
      box2 = MyBox "foo"
  print $ fmapMy (<> "bar") box2
  print $ fmapMy (+ 10) box1

  -- change type of contents ... Int => Tuple(Int,Int)
  print $ fmapMy (\a -> (a, a + 1)) box1

-- MyFunctor is a wrapper that provides the methods that can be chained to manipulate the contents.. and always stay in the paradigm of the wrapper and fmap means you can pass functions in terms of  the type of the contents and never need to worry about unwrap (destructure) and wrap (return) before nor after the operation.
-- in many ways you can think of these containers as mixins that extend the behavior of a type without touching the type itself...

-- TODO depend on and use Functor's fmapMy
class MyNads m where
  -- instances have to define wrapping (data type ctor)
  wrap :: a -> m a -- aka return

  -- instances have to define unwrapping (i.e. w/ destruct pattern matching)
  bind :: m a -> (a -> m b) -> m b

instance MyNads MyBox where
  wrap a = MyBox a

  bind (MyBox a) func = func a

testMyNads = do
  let surprise = MyBox "backdoor"
  let tellMe = fmapMy ("likes it in the " <>) surprise
  print tellMe

testMyNads2 = do
  let surprise = wrap "otherdoor" :: MyBox String
  let tellMe = bind surprise (wrap . ("likes it in the " <>))
  let tellMe2 = surprise `bind` (wrap . ("likes it in the " <>))
  -- b/c show is impl'd on the type param I can use bind in place of fmap and pass to print and have no difference
  print tellMe

testChains :: IO ()
testChains = do
  print "duck face"

testNadChains :: MyBox String
testNadChains = do
  MyBox "duck face"

-- *** wire up MyNads/MyFunctor impls to actual Monad/Functor/Applicative types for do block  (UNLESS, can I use my own Monad type with a do block?)

-- USING my IMPLs of everything instead of re-impling (i.e. MyFunctor.fmapMy, MyNads.wrap - EXCEPT for liftA2 as I don't have a MyApplicative yet)
instance Monad MyBox where
  (>>=) = bind -- MyNads

instance Functor MyBox where
  fmap = fmapMy -- from MyFunbags

instance Applicative MyBox where
  pure = wrap -- from MyNads
  liftA2 = myliftA2 -- from MyApphole

testNadChains2 :: MyBox String
testNadChains2 = do
  unwrapped1 <- MyBox "bull" `bind` (\unwrapd -> wrap (unwrapd <> "spit")) -- explicit lambda to make clear what is happening

  -- unwrapped 3
  unwrapped3 <- MyBox "bull" `bind` (\unwrapd -> wrap (unwrapd <> "spit"))

  -- unwrapped2
  unwrapped2 <- MyBox "fudge"
  let foo2 = unwrapped2 <> "pole" -- string ops!

  -- return wrapped
  wrap (unwrapped1 <> "  |  " <> foo2 <> "  |  " <> unwrapped3)

class (MyNads f) => MyApphole f where
  -- hold your tongue and say My Apple

  -- TODO what is the hieararchy of Monad/Applicative/Functor?
  pure :: a -> f a
  pure = wrap

  -- leave up to impls ... -- TODO review what I make instances impl and see if I can simplify anything without obscuring things
  myliftA2 :: (a -> b -> c) -> f a -> f b -> f c

instance MyApphole MyBox where
  myliftA2 func (MyBox a) (MyBox b) = wrap (func a b)
