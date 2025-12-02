import Data.List
import Data.Char
import Data.List.Split

main :: IO()
main = do
  file <- readFile "input"
  putStrLn $ part1 file

part1 =
  show
  . solve
  . splitOn "," . head . lines

solve s = sum $ filter (isInvalid . show) $ concat $ map ((\[a,b]-> [read a..read b] :: [Int]) . splitOn "-") $ s

isInvalid n = a == b
  where (a,b) = splitAt (length n `div` 2) n
