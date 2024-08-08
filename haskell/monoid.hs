-- from ctfp page 32 (renamed m_empty instead of mempty)
class MyMonoid m where
  m_empty :: m
  m_append :: m -> m -> m

-- my impl of a MyMonoid for type String (based on some of explaining classes in the haskell cheatsheet)
instance MyMonoid String where
  m_empty = ""

  m_append = (++) -- m_append a b = a ++ b

testMyMonoidString = m_append "foo" "bar"

instance MyMonoid Int where
  m_empty = 0
  m_append = (+) -- m_append a b = a + b

testMyMonoidInteger :: Int
testMyMonoidInteger = m_append 1 2

-- infix operator => two arg function (surround w/ parens)
concats = (++) -- function equality (point-free)
-- foo = concats "foo" "bar"

combined = (++) "foo" "bar"

combined2 = "foo" ++ "bar"

-- https://www.idris-lang.org/docs/current/prelude_doc/docs/Prelude.Foldable.html
-- Int type
sum1 = foldl (+) 0 [1 .. 5] -- use foldl to sum numbers, suggests sum

sum2 = sum [1 .. 5]

sum3 :: Int
sum3 = foldl m_append m_empty [1 .. 5] -- use MyMonoid

-- string type
alpha1 = foldl (++) "" ["a", "b", "c"] -- foldl suggests concat

alpha2 = concat ["a", "b", "c"]

alpha3 = foldl m_append m_empty ["a", "b", "c"]
