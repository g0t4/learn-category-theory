import System.Environment (getEnv)

test1 = putStrLn "foo" >> putStrLn "bar"

test2 = do
  let foo = putStr "foo"
  let bar = putStr "bar"
  let nl = putStrLn mempty

  let both = nl >> foo >> nl >> bar >> nl

  bar >> foo >> nl
  bar >> foo >> nl
  both
  both

testReadLine = do
  putStrLn "type a line and hit return when done: "
  user_input <- getLine
  putStr "you typed: " >> putStr user_input

  -- Monad has >> operator which essentially sequences two operations and discards the result of the first, for reasons of side effects, the final result is the result of the right operation
  putStrLn mempty >> putStrLn mempty >> putStr "type a character: "
  a_char <- getChar
  putStrLn mempty >> putStrLn "you typed: " >> putChar a_char >> putStrLn mempty

-- *** MyMaybe (custom Maybe impl w/ Monad et al instances)

data MyMaybe a = MyNothing | MyJust a
  deriving (Show, Eq)

instance Functor MyMaybe where
  fmap :: (a -> b) -> MyMaybe a -> MyMaybe b
  fmap _ MyNothing = MyNothing
  fmap f (MyJust a) = MyJust (f a)

instance Applicative MyMaybe where
  pure :: a -> MyMaybe a
  -- FYI Monad's return = pure (https://github.com/ghc/ghc/blob/a1e42e7ac6121404afb2a42e11d0c778ce0fe483/libraries/ghc-internal/src/GHC/Internal/Base.hs#L1370-L1372)
  pure a = MyJust a

  liftA2 :: (a -> b -> c) -> MyMaybe a -> MyMaybe b -> MyMaybe c
  liftA2 _ _ MyNothing = MyNothing
  liftA2 _ MyNothing _ = MyNothing
  liftA2 f (MyJust a) (MyJust b) = MyJust (f a b) -- TODO is this correct?

instance Monad MyMaybe where
  -- return = pure -- default impl in `class Monad`
  (>>=) :: MyMaybe a -> (a -> MyMaybe b) -> MyMaybe b
  MyNothing >>= _ = MyNothing
  MyJust x >>= f = f x

-- instance (Show a) => Show (MyMaybe a) where
--   show MyNothing = "My Nothing"
--   show (MyJust x) = show x

testMaybeMonad = do
  let wesAge = "5"
  let paxAge = "10"
  let otherAge = ""

  let j5 = MyJust 5
  print j5

  let fmapJ5 = fmap id j5
  print (fmapJ5 == j5)

  let pure5 = pure 5 :: MyMaybe Int
  print pure5

  let return5 = return 5 :: MyMaybe Int
  print return5

  let jFoo = MyJust "Foo"
  let jBar = MyJust "Bar"
  let lifted = liftA2 (<>) jFoo jBar

  putStrLn $ "lifted: " <> show lifted

  let jDollar = MyJust 1.0
  let jBuck50 = MyJust 1.50
  let wallet = liftA2 (+) jDollar jBuck50
  putStrLn $ "wallet: " <> show wallet

-- *** thinking about `do` blocks

myDoOutputs =
  let jFoo = MyJust "Foo"
      jBar = MyJust "Bar"
      lifted = liftA2 (<>) jFoo jBar -- FYI liftA2 is like bind (>>=) but with a binary operation (unwrap two monads), bind is unary operation (unwrap one monad)... both return a new monad (wrapped result of unary/binary op)
      nl = putStrLn mempty
   in putStr "foo" >> putStrLn "bar" >> nl >> nl >> print lifted

myDoWithInput =
  -- NOW it makes 100% sense why we have >> and >>= ... the former handles case where we don't care about the output... the latter takes the output and passes it! cool...
  -- so, do blocks must translate into >> and >>= under the hood? and IO a (IO actions) is a monad (obviously)
  putStrLn "please type a line:" >> getLine >>= putStrLn >> putStrLn "next"

myDoWithInputToLambda =
  -- including second version to foster thinking a bit about how bind is working...
  -- parens just to group for readability on lambda/anon func
  putStrLn "please type a line:" >> getLine >>= (\x -> putStrLn x) >> putStrLn "next"

makeFileInDo = do
  --- save to ~/.foo using HOME env var
  home <- getEnv "HOME"
  let path = home <> "/.foo"
  writeFile path "make"
  appendFile path "FileInDo"

makeFileLetIn =
  let path = (getEnv "HOME")
   in path >>= \home -> writeFile (home <> "/.foo") "make" >> appendFile (home <> "/.foo") "FileLetIn"

makeFileOneLine =
  -- observation
  --  >>= is bind w/ passed arg (think "thenWith")
  --  >> is bind w/o passed arg (thin "then")
  getEnv "HOME" >>= \home -> writeFile (home <> "/.foo") "make" >> appendFile (home <> "/.foo") "FileOneLine"

makeFileOneLineSplit =
  getEnv "HOME"
    >>= \home ->
      writeFile (home <> "/.foo") "make"
        >> appendFile (home <> "/.foo") "FileOneLineSplit"

makeFileIncludePathVar =
  -- IIUC this is what a do block would look like once translated? lots of nesting for the various let bindings based on dependencies in do block
  getEnv "HOME"
    >>= \home ->
      return (home <> "/.foo")
        >>= \path ->
          writeFile (home <> "/.foo") "make"
            >> appendFile (home <> "/.foo") "FileIncludePathVar"

makeFileLazyProblemsInAnonDo =
  getEnv "HOME"
    >>= \home ->
      return (home <> "/.foo")
        >>= \path -> do
          let writeIt = writeFile (home <> "/.foo") "make"
          -- if we don't chain all IO actions with >> or >>= then they won't be executed b/c lazy eval
          -- IOTW we only call appendFile and not writeFile (drop the `let writeIt =` to include it in the nested do block of the anon func)
          appendFile (home <> "/.foo") "FileLazyProblemsInAnonDo"

makeFilePrefixStyleOneLine =
  -- infix style is used above with >> and >>=
  -- here is what prefix looks like (all on one line)
  -- all in one line is TERRIBLE vs infix one line above
  (>>=) (getEnv "HOME") (\home -> (>>=) (return (home <> "/.foo")) (\path -> (>>) (writeFile (home <> "/.foo") "make") (appendFile (home <> "/.foo") "FilePrefixStyleOneLine")))

makeFilePrefixStyleSplitLines =
  -- same as prior but across multiple lines
  -- SO, which do you prefer? which reads better
  -- IMO the infix style is perfect
  (>>=)
    (getEnv "HOME")
    ( \home ->
        (>>=)
          (return (home <> "/.foo"))
          ( \path ->
              (>>)
                (writeFile (home <> "/.foo") "make")
                (appendFile (home <> "/.foo") "FilePrefixStyleSplitLines")
          )
    )

{-

NEXT UP intuitions
- chaining >> and >>= calls is akin to JS chaining promises (>>=/>> are like .then)
  - there must be some sort of failure chain for error handling if prev IO action fails
    - ? catch? IIRC I saw a MonadFail type was that where it is at?
- do blocks are like async/await in JS
  - they are syntactic sugar for chaining IO actions
  - albeit chaining is sufficient to read, do blocks are more readable (looks like imperative code)
  - flip >>= and unroll nested lambdas!
  - IIUC `do` transforms <- into >>=, handles scope for let bindings, and for expressions joins them with >>... this is known as a Continuation-passing style (CPS) transformation
    - https://en.wikipedia.org/wiki/Continuation-passing_style

-}