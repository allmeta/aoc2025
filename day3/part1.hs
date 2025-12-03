import Data.List
import Data.Char
import Data.List.Split
import Debug.Trace

main :: IO()
main = do
  file <- readFile "input"
  putStrLn $ part1 file

part1 =
  show
  . sum
  . map getBiggestPair
  . lines

getBiggestPair :: String -> Int
getBiggestPair vs = read [a,b]
  where
    a = maximum $ init vs
    b = maximum $ tail $ dropWhile (/=a) vs
