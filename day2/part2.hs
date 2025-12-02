import Data.List
import Data.Char
import Debug.Trace
import Data.List.Split

main :: IO()
main = do
  file <- readFile "input"
  putStrLn $ part1 file

part1 =
  show
  . solve
  . splitOn "," . head . lines

solve s = sum $ filter (\f-> isInvalid 1 $ show $ f) $ concat $ map ((\[a,b]-> [read a..read b] :: [Int]) . splitOn "-") $ s

isInvalid d n 
  | length n == d = False
  | otherwise = all ((==) c) cs || isInvalid (d+1) n
    where (c:cs) = chunksOf d n
