module PrintColor where

resetColor = "\x1b[0m"

colorText color text = color ++ text ++ resetColor

redText = colorText "\x1b[31m"
greenText = colorText "\x1b[32m"
yellowText = colorText "\x1b[33m"
blueText = colorText "\x1b[34m"
magentaText = colorText "\x1b[35m"
cyanText = colorText "\x1b[36m"
whiteText = colorText "\x1b[37m"

printRed = print . redText
printGreen = print . greenText
printYellow = print . yellowText
printBlue = print . blueText
printMagenta = print . magentaText
printCyan = print . cyanText
printWhite = print . whiteText
