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
  putStrLn $ "2 * 2 = " ++ show multiplied
  putStrLn $ "2 * 2 = " ++ Prelude.show multiplied