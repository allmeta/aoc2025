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
  . map (read . traceShowId . largestNSeq 12)
  . lines

largestNSeq 0 _ = []
largestNSeq n s = a:largestNSeq (n-1) newS
  where 
    a = maximum $ take (length s - (n - 1)) s
    newS = tail $ dropWhile (/=a) s
