import Data.List
import qualified Data.IntMap.Strict as M
import Data.Char
import Data.List.Split
import Debug.Trace

main :: IO()
main = do
  file <- readFile "input"
  let cords = map ((\[x,y]->(x,y)) . map read . splitOn ",") $ lines file :: [(Int,Int)]
  putStrLn $ show $ solve cords


solve cs = foldl (\a c-> max a $ maximum $ map (square c) cs ) 0 cs


square a b = ((+1) $ abs $ fst a - fst b) * ((+1) $ abs $ snd a - snd b)
