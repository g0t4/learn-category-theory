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

wes2 = MyPerson2 {firstName = "Wes", lastName = "Higbee", theAge = 80}

testPerson2b = do
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

-- *** type aliases:

type Meters = Double

type Seconds = Double

type MetersPerSecond = Double

velocity :: Meters -> Seconds -> MetersPerSecond
velocity meters seconds = meters / seconds

-- *** type classes and SHOW?

-- :info show
--      type Show :: * -> Constraint
--      class Show a where
--        ...
--        show :: a -> String
--        ...
--          -- Defined in ‘GHC.Internal.Show’

instance Show MyPerson2 where
  show person = "fooer " ++ firstName person

-- FYI use
--   :info MyPerson2 => shows:   instance Show MyPerson2 -- Defined at types.hs:122:10
--   :instances MyPerson2

testShowInstance = do
  -- friggin cool... once defined, the compiler can infer to use this when you call show wes2!!
  putStrLn $ show wes2
  print wes2 -- print calls show

-- FYI browsing ghc/ghc repo, search for "instance\s+show" is a great way to learn about many of the types avail, i.e. then take smth like Float.hs and peruse it specifically (search for "instance\s" and read each):
-- https://github.com/ghc/ghc/blob/a1e42e7ac6121404afb2a42e11d0c778ce0fe483/libraries/ghc-internal/src/GHC/Internal/Float.hs#L569-L570
-- type classes are like mixins that can be defined independent of a traditional class! I love it.. think duck typing + type inference
-- btw here is a fundamental type `Double` and it's definition (IIUC): https://github.com/ghc/ghc/blob/a1e42e7ac6121404afb2a42e11d0c778ce0fe483/libraries/ghc-prim/GHC/Types.hs#L530-L531
--   => from here look at other fundamental types
--   *** Frustrated that F12 doesn't work in vscode extension :( to jump from type usage (i.e. `instance Num Double<CURSOR>` => `data Double`)
--      here is `Num` type class that I've noticed in type signatures/annotations... ok so that was a constraint based on there being an instance class for a given type?!
-- btw here is `instance Eq Double`... https://github.com/ghc/ghc/blob/a1e42e7ac6121404afb2a42e11d0c778ce0fe483/libraries/ghc-prim/GHC/Classes.hs#L336-L338
-- `class Semigroup`! https://github.com/ghc/ghc/blob/a1e42e7ac6121404afb2a42e11d0c778ce0fe483/libraries/ghc-internal/src/GHC/Internal/Base.hs#L566-L567

-- kind is the type of a type
-- :kind Int
-- Int :: *
-- :kind Maybe
--
--    FYI data Maybe => https://github.com/ghc/ghc/blob/a1e42e7ac6121404afb2a42e11d0c778ce0fe483/libraries/ghc-internal/src/GHC/Internal/Maybe.hs#L29-L30
-- :set -XDataKinds  -- enable `:kind [DataType]` such as `:kind Nothing` or `:kind Just`
--     :unset -XDataKinds
-- :instances Maybe

firstOrDefault :: forall a. [a] -> Maybe a
firstOrDefault [] = Nothing
firstOrDefault (head : rest) = Just head

emptyTo = firstOrDefault ([] :: [Int])

testMaybe = do
  let numbers = [1 .. 10]

  print $ dropWhile (< 11) numbers
  print $ firstOrDefault $ dropWhile (< 11) numbers

firstOrFailure :: [a] -> Either String a
firstOrFailure [] = Prelude.Left "Cannot get first item in an empty list"
firstOrFailure (head : rest) = Prelude.Right head

testEither = do
  print $ firstOrFailure ([] :: [Int])
  print $ firstOrFailure [1, 2, 3]
  print $ firstOrFailure "foo"