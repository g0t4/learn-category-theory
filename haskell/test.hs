-- https://www.haskell.org/ghcup/steps/

-- runghc test.hs

main = putStrLn "Hello, Haskell!"


-- repl: ghci
--  putStrLn "Hello, Haskell!"
--  :load test.hs
--  main
--  doubleit 2
--  doubleit (-1) -- put negative integer literals in parens (else IIUC appears indistinguishable from minus 1)

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


