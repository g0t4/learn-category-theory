-- combine type annotation/signature with the expression (= 1)
age = 1 :: Int

-- split type annotation/signature from expression
age2 :: Int
age2 = 2

addInt = (+) :: Int -> Int -> Int -- monomorphic

testAdds = do
  print $ addInt 2 2
  print $ addFloat 2 2
  print $ addFloat 2.0 2.1

addFloat = (+) :: Float -> Float -> Float -- monomorphic (morphism)

-- polymorphic (parametric)
myIdentity :: a -> a
myIdentity x = x

-- FYI funcs w/ params need sep line for type signature =>
--    myIdentity x = x :: a -> a -- INVALID

testIdentity = do
  print $ myIdentity 1 -- shows 1
  print $ myIdentity (1 :: Float) -- shows 1.0
  print $ myIdentity "foo"
  print $ myIdentity [1, 2, 3]

-- use undefined as placeholder to get type checking working w/o impl in this case
myFoo :: Int -> Int
myFoo x = undefined

testMyFoo = do
  myFoo 1

-- type holes (FYI vscode haskell extension shows inferred types in code lens -- far superior to using type holes w/ ghc/ghci to show type info inferred)
-- THAT said type holes might be helpful to explore when there is a mismatch (will show relevant bindings and valid hole fits in current code)
foo a b = a + b

-- test1 = foo 1 _

data MyPerson = MyPerson String String

showPerson (MyPerson first last) =
  print $ last <> ", " <> first

testPerson = do
  let wes = MyPerson "wes" "higbee"
  showPerson wes