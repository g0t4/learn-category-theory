-- combine type annotation/signature with the expression (= 1)
{-# LANGUAGE RecordWildCards #-}

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

data MyPerson = MyPerson String String Int

showPerson (MyPerson first last _) =
  last <> ", " <> first

testPerson = do
  let wes = MyPerson "wes" "higbee" 100
  print $ showPerson wes

-- record syntax
data MyPerson2 = MyPerson2
  { firstName :: String,
    lastName :: String,
    theAge :: Int
  }

showPerson2 (MyPerson2 firstName lastName theAge) =
  lastName <> ", " <> firstName <> " " <> show (theAge)

testPerson2 = do
  let wes2 = MyPerson2 {firstName = "Wes", lastName = "Higbee", theAge = 80}
  print $ showPerson2 wes2
  print $ firstName wes2 -- auto field func
  print $ lastName wes2 -- auto field func
  --
  let resetAge person = person {theAge = 70}
  print $ "reset age: "
  print $ "  " <> showPerson2 (resetAge (wes2))

showPerson2b MyPerson2 {..} =
  -- think automatically destructure all fields into local variables
  firstName <> " " <> lastName <> " " <> show (theAge)

testPerson2b = do
  let wes2 = MyPerson2 {firstName = "Wes", lastName = "Higbee", theAge = 80}
  print $ showPerson2b wes2

personConstructor firstName lastName =
  let theAge = 1
   in MyPerson2 {..}

testFactory = do
  print $ showPerson2b $ personConstructor "wes" "higbee"

data Turn = Left | Right

data Power = On | Off

data SimpleColor = Red | Yellow | Orange | Green | Blue | Purple

-- see calc.hs for an example of sum types

-- FYI sum types / type sets (union set)
data LightFeature = LightPower Power | LightColor SimpleColor