import Foo

main :: IO ()
main = do
  putStrLn ("3 + 4 = " ++ show (Foo.addit 3 4))
  putStrLn $ "3 + 4 = " ++ show (Foo.addit 3 4) -- \$ to reduce parens()
  let multiplied = Foo.multit 2 2
  putStrLn $ "2 * 2 = " ++ show multiplied
  putStrLn $ "2 * 2 = " ++ Prelude.show multiplied