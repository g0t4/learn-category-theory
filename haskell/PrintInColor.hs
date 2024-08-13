module PrintInColor where

resetColor = "\x1b[0m"

colorText color text = color ++ text ++ resetColor

redText = colorText "\x1b[31m"
greenText = colorText "\x1b[32m"
yellowText = colorText "\x1b[33m"
blueText = colorText "\x1b[34m"
magentaText = colorText "\x1b[35m"
cyanText = colorText "\x1b[36m"
whiteText = colorText "\x1b[37m"

putStrLnRed = putStrLn . redText
putStrLnGreen = putStrLn . greenText
putStrLnYellow = putStrLn . yellowText
putStrLnBlue = putStrLn . blueText
putStrLnMagenta = putStrLn . magentaText
putStrLnCyan = putStrLn . cyanText
putStrLnWhite = putStrLn . whiteText
