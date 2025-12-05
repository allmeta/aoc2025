import Data.List
import Data.Char
import Data.List.Split
import Debug.Trace

main :: IO()
main = do
  file <- readFile "input"
  let fresh = lines $ head $ splitOn "\n\n" file
  let res = sumBy (\(a,b)-> b-a + 1) $ merge [] $ sortOn fst $ map toRange fresh
  putStrLn $ show res

sumBy :: (a -> Int) -> [a] -> Int
sumBy f [] = 0
sumBy f (x:xs) = f x + sumBy f xs

toRange :: String -> (Int, Int)
toRange f = (a, b)
  where [a,b] = map read $ splitOn "-" f

merge :: [(Int,Int)] -> [(Int,Int)] -> [(Int,Int)]
merge ss [] = ss
merge [] (f:fs) = merge [f] fs 
merge ((s1,s2):ss) ((f1,f2):fs) = 
  case (s2 >= f1, s2 >= f2) of
  (True, True)  -> merge ((s1,s2):ss) fs
  (True, False) -> merge ((s1,f2):ss) fs
  _             -> merge ((f1,f2):(s1,s2):ss) fs
