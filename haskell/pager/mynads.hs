import GHC.Base

testConditionalPrint = do
  when True (print "when true")
  when False (print "when false")