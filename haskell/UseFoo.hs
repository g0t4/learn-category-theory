import Foo

main :: IO ()
main = do
  putStrLn ("3 + 4 = " ++ show (Foo.addit 3 4))
  putStrLn $ "3 + 4 = " ++ show (Foo.addit 3 4) -- \$ to reduce parens()
  putStrLn ""

  print (show (Foo.addit 3 4))
  print $ show (Foo.addit 3 4)
  print $ show $ Foo.addit 3 4
  putStrLn ""

  let multiplied = Foo.multit 2 2
  -- $ = function application operator (very low precedence) == apply function (to left) to the right hand side (which will be evaluated due to precedence, before $ is applied) = TLDR sometimes can get rid of parens that would otherwise be needed to dictate order of operations
  putStrLn $ "2 * 2 = " ++ show multiplied
  putStrLn $ "2 * 2 = " ++ Prelude.show multiplied
  putStrLn $ "2 * 2 = " <> show multiplied -- <> more general than ++ IIUC

-- can use {} but using spaces for scope is recommended
main2 :: IO ()
main2 = do {
  putStrLn "tests"
}