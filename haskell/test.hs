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
doubleanyinferred :: Num a => a -> a
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
fooDefinedWithMultiline = "foo \
\the bar"
fooWithoutMultiline = "foo the bar"

expectSame :: String -> Bool
expectSame "foo the bar" = True
expectSame _ = False -- anything else doesn't match
-- comment out second pattern (of function expectSame _ ...)  and call expectSame w/ "foo" and it will Exception w/ "Non-exhaustive patterns in function expectSame"

result = expectSame fooDefinedWithMultiline
