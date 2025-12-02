import Data.List
import Data.Char
import Data.List.Split

main :: IO()
main = do
  file <- readFile "input"
  putStrLn $ part1 file

part1 =
  show
  . sum
  . filter (isInvalid . show) 
  . concatMap ((\[a,b]-> [read a .. read b] :: [Int]) . splitOn "-") 
  . splitOn "," . head . lines


isInvalid :: String -> Bool
isInvalid n = a == b
  where (a,b) = splitAt (length n `div` 2) n
