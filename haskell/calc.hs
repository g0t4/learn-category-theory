-- credit: from Effective Haskell book
-- https://learning.oreilly.com/library/view/effective-haskell/9798888650400/f_0045.xhtml#d24e21490

data Expr
  = Lit Int
  | Sub Expr Expr
  | Add Expr Expr
  | Mul Expr Expr
  | Div Expr Expr

eval expr =
  case expr of
    Lit num -> num
    Add a b -> eval (a) + eval (b)

testIt = do
  print $ eval (Lit 1)
  print $ eval (Add (Lit 2) (Lit 3))
  print $ eval (Add (Add (Lit 2) (Lit 2)) (Lit 3))