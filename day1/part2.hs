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

solve (v, p) (d:n) = (v', p+hits)
  where 
    dir = if d == 'R' then 1 else -1
    n' = read n
    hits = hitsFor v dir n'
    v' = (v + dir * n') `mod` 100

-- unified hits function
hitsFor :: Int -> Int -> Int -> Int
hitsFor v dir n =
  let r = ((-dir * v) `mod` 100)            -- 0..99
      first = if r == 0 then 100 else r     -- first positive k that hits zero
  in if first > n then 0 else 1 + (n - first) `div` 100
