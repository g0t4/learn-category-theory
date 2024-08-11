module Calculator where

import Text.Read (readEither)

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
    Sub a b -> eval (a) - eval (b)
    Mul a b -> eval (a) * eval (b)
    Div a b -> eval (a) `div` eval (b)

-- toExpr :: String -> Expr
-- toExpr token
--   | "+"

parseInput :: String -> [Expr]
parseInput "" = []
parseInput line =
  let tokens = words line
   in [Lit 1]

testIt = do
  print $ eval (Lit 1)
  print $ eval (Add (Lit 2) (Lit 3))
  print $ eval (Add (Add (Lit 2) (Lit 2)) (Lit 3))

  let test_input = "- 1 + 1 5"
  print $ run test_input

  input <- getLine
  print input

parse :: String -> Either String Expr
parse str =
  case parse' (words str) of
    Left err -> Left err
    Right (e, []) -> Right e
    Right (_, rest) -> Left $ "Found extra tokens: " <> (unwords rest)

parse' :: [String] -> Either String (Expr, [String])
parse' [] = Left "unexpected end of expression"
parse' (token : rest) =
  case token of
    "+" -> parseBinary Add rest
    "*" -> parseBinary Mul rest
    "-" -> parseBinary Sub rest
    "/" -> parseBinary Div rest
    lit ->
      case readEither lit of
        Left err -> Left err
        Right lit' -> Right (Lit lit', rest)

parseBinary ::
  (Expr -> Expr -> Expr) ->
  [String] ->
  Either String (Expr, [String])
parseBinary exprConstructor args =
  case parse' args of
    Left err -> Left err
    Right (firstArg, rest') ->
      case parse' rest' of
        Left err -> Left err
        Right (secondArg, rest'') ->
          Right $ (exprConstructor firstArg secondArg, rest'')

run :: String -> String
run expr =
  case parse expr of
    Left err -> "Error: " <> err
    Right expr' ->
      let answer = show $ eval expr'
       in "The answer is: " <> answer