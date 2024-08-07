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


-- data
data Doo = Foo | Bar | Baz
dooToInt Foo = 1
dooToInt Bar = 2
dooToInt Baz = 3

