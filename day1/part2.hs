import Data.List

main :: IO()
main = do
  file <- readFile "./input"
  putStrLn $ part2 file

part2 =
  show
  . snd
  . foldl solve (50, 0)
  . lines

solve (v, p) (d:n) = (v', p')
  where 
    dir = if d == 'R' then 1 else -1
    n' = read n
    hits = take n' $ repeat 1 
    (v', p', _) = foldl rotate (v, p, dir) hits

rotate (v, p, dir) h = (n, if n == 0 then p + 1 else p, dir)
  where n = (v+h*dir) `mod` 100
