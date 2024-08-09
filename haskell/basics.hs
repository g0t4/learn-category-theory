import Data.Char (GeneralCategory (UppercaseLetter))

-- https://www.haskell.org/ghcup/steps/

-- runghc test.hs

main = putStrLn "Hello, Haskell!"

-- repl: ghci
--  putStrLn "Hello, Haskell!"
--  :load test.hs
--  main
--  doubleit 2
--  doubleit (-1) -- put negative integer literals in parens (else IIUC appears indistinguishable from minus 1)

-- :type foo -- FYI

-- haskell has incredible type inference (rarely need type annotations), nonetheless a function (morphism) can specify/constrain types:
doubleit :: Int -> Int -- limit to integer type -- type annotation
doubleit x = x + x -- func defintion (name params = body)
-- doubleit 1 -- succeeds
-- doubleit 1.0 -- fails

-- see vscode code lens for inferred types
doubleanyinferred :: (Num a) => a -> a
doubleanyinferred x = x + x

-- addit :: Num a => a -> a -> a
addit a b = a + b

-- impl compose (instead of . [period])
composeit f g = f . g

addone a = a + 1

addtwo a = a + 2

-- addoneThenTwo :: Num a => a -> a -- specify can be any num type... otherwise the type is inferred to be Integer? why? and so I cannot call this with addOneThenTwo 2.0 w/ default type inferrence
addoneThenTwo = addone . addtwo

cOneThenTwo = composeit addone addtwo

cTwoThenOne = composeit addtwo addone

-- btw Int (finite, machine specific size) != Integer (infinite)

memoize :: (a -> b) -> (a -> b)
memoize what = what

addThree x = x + 3

-- functions are defined by pattern matching (first pattern wins, hence if I reverse the following it is no longer quirky for `quirky 3`)
quirky 3 = 10
quirky x = x + 4

-- Bool to Bool
fooDefinedWithMultiline =
  "foo \
  \the bar"

fooWithoutMultiline = "foo the bar"

expectSame :: String -> Bool
expectSame "foo the bar" = True
expectSame _ = False -- anything else doesn't match
-- comment out second pattern (of function expectSame _ ...)  and call expectSame w/ "foo" and it will Exception w/ "Non-exhaustive patterns in function expectSame"

result = expectSame fooDefinedWithMultiline

{-
btw I found a good cheat sheet that is more of an overview:
  https://jutge.org/doc/haskell-cheat-sheet.pdf
-}

addInts :: Int -> Int -> Int -- constrain to ints only
addInts a b = a + b

addFloats :: Float -> Float -> Float
addFloats a b = a + b

-- FYI both addInts and addFloats can be impl'd with `add` alone (w/ polymorphic func)

singleDigits = [0 .. 9] -- inclusive

backwards = [9, 8 .. 0] -- backwards (specify first two in range and then final)

negative = [-1, -2 .. -10] -- add space before -10

negativeToo = [-1, -2 .. (-10)] -- or () parens
-- negative == negativeToo

alphabet = ['a' .. 'z']

halves = [0, 0.5 .. 3] -- step by 0.5

upperAlphabet = ['A' .. 'Z']

generalCategoryValues = [UppercaseLetter ..] -- IIUC i.e. GeneralCategory.UppercaseLetter

square x =
  x ^ 2

power x exp = x ^ exp

square2 x =
  let x2 =
        x * x
   in x2

-- functions must start w/ lowercase or "_"
_square3 = square2

-- multi clause function definitions using pattern matching

-- alternate type annotations:
-- parseBool :: String -> Bool
-- parseBool :: [Char] -> Bool
parseBool "y" = True -- "y" only -- note this is redundant given last two rules
parseBool "n" = False -- "n" only -- note this is redundant too
parseBool ('y' : _) = True -- starts w/ y
parseBool _ = False -- all else false

-- data (TODO further explore)
data Doo = Foo | Bar | Baz

dooToInt Foo = 1
dooToInt Bar = 2
dooToInt Baz = 3

-- TODO revisit, does ghc not support n + k?
-- n + k patterns
-- isEven 0 = True
-- isEven 1 = False
-- isEven (n + 2) = isEven n -- IIUC a recursive impl of checking if a number > 1 is even... isEven 3 == isEven (n=1 + 2) -> isEven 1 -> 0

-- argument capture (in pattern match) => destructuring too
explainString list@(f : _) = "Line is '" ++ list ++ "' and starts with '" ++ [f] ++ "'"

explainString2 list@(f : _) = "Line is " ++ show list ++ " and starts with " ++ show f

-- PRN Void (empty) set, () unit (single element set), Bool (two element set)

personJon = ("Jon", "Doe", 45)

personJean = ("Jean", "Doe")

firstName = fst personJean

lastName = snd personJean

areSame = personJean == (firstName, lastName)

-- anonymous/lambda funcs
-- https://wiki.haskell.org/Anonymous_function
anonTest = foldl (\x y -> x + y) 0 [1 .. 3]

adder = (+)

addOne = adder 1 -- partial application (applied)

twoPlusOne = addOne 2 -- fully applied (saturated) args

halve = (/ 2) -- infix / => apply second arg o_RDONLY

halfOfTen = halve 10

myAdd a b = a + b

infixMyAddResult = 2 `myAdd` 3

-- use infix style to lock (partially apply) 2nd arg
myAddOne = (`myAdd` 1) -- lock in right

myAddTwoToOne = myAddOne 2

-- makes more sense to lock in denominator:
myDivide a b = a / b

myHalver = (`myDivide` 2)

myTenHalved = myHalver 10

-- or use flip func to lock second arg
flipHalve = flip myDivide 2

flippedTenHalved :: Double
flippedTenHalved = flipHalve 10

-- my own myFlipper
myTwoArgFlipper f a b = f b a

myFlipperHalve :: Double -> Double
myFlipperHalve = myTwoArgFlipper (/) 2 -- partially apply func and 2nd arg (b) but leave (a) free

myFlipperTenHalved = myFlipperHalve 10

-- $ function application operator (think implicit parenthesis)
-- foo $ bar 1 == foo(bar 1)

timesTwo = (* 2)

plusOne = (+ 1)

-- resultTwoPlusOneOnOne = timesTwo . plusOne 1 -- invalid
resultTwoPlusOneOnOne = (timesTwo . plusOne) 1 -- use parens to compose funcs b4 apply to 1

resultTwoPlusOneOnOne' = timesTwo . plusOne $ 1 -- use $ to specify that left hand side is a func (timesTwo . plusOne) that is applied to right hand side (1)
-- FYI ' (single quote) is often used for assignment (to a new variable) instead of using the same variable which is invalid

testTitler = do
  let titler first last = last <> ", " <> first -- wow type is correctly inferred here, I love it!
  let fullName = titler "Wes" "Higbee"
  let fullName' = "Wes" `titler` "Higbee" -- terrible readability using infix here :)
  let higbeeTitler = (`titler` "Higbee")
  let higbeeTitler' = flip titler "Higbee" -- first remains unbound (unapplied)
  print $ higbeeTitler "Wes"
  print $ higbeeTitler' "Jane"

testPrecedence = do
  let result = "2 shows as: " <> show 2
  let result' = "2 shows as: " <> (show 2) -- unnecessary parens b/c function application has higher binding precedence vs operator application
  print result
