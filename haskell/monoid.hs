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

concats = (++)
-- foo = concats "foo" "bar"
