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
