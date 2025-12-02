import Data.List

main :: IO()
main = do
  file <- readFile "input"
  putStrLn $ part1 file

part1 =
  show
  . solve 50 0
  . lines

solve :: Int -> Int -> [String] -> Int
solve _ p [] = p
solve v p ((d:n):ns) = solve v' (p + p') ns
  where 
    n' = read n
    v' = (v + dir * n') `mod` 100
    p' = if v' == 0 then 1 else 0
    dir = if d == 'L' then (-1) else 1
