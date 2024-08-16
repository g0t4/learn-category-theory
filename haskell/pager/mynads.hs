import GHC.Base

testConditionalPrint = do
  when True (print "when true")
  when False (print "when false")

-- Functor, (think Functee?), like Employer/Employee?
-- Functor is a thing that can apply a function to a context? IOTW it wouldn't have the function, nor the instance... so it would take both of those as parameters (i.e. bind, fmap)
--

class MyFunctor f where
  fmapMy :: (a -> b) -> f a -> f b
  (<$) :: a -> f b -> f a
  (<$) a fb = fmapMy (const a) fb -- IOTW use fmapMy to take `a` and return `f a`, that is all that we are doing here, reusing fmapMy, ignore any b value passed... SO this is `return`/`pure` (think "wrap")?

  -- alias fmap to <$>
  infixl 4 <$>
  (<$>) :: (Functor f) => (a -> b) -> f a -> f b
  (<$>) = fmapMy

data MyThisOrThat a = MyThis a | MyThat a -- must have a type parameter to use it as a functor (which requires a type parameter)
  deriving (Show, Eq)

instance MyFunctor MyThisOrThat where
  fmapMy func (MyThis a) = MyThis (func a)
  fmapMy func (MyThat a) = MyThat (func a)

-- use a list as a container? and only allow first item to be a thing
instance MyFunctor [] where
  fmapMy func [] = []
  fmapMy func (head : _) = [func head]

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
