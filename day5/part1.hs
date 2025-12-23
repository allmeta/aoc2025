import Data.List
import qualified Data.IntMap.Strict as M
import Data.Char
import Data.List.Split
import Debug.Trace

main :: IO()
main = do
  file <- readFile "input"
  let [fresh, available] = map lines $ splitOn "\n\n" file
  putStrLn $ show $ solve fresh available

solve fresh available = length $ filter (isFresh fresh . read) available

isFresh :: [String] -> Int -> Bool
isFresh [] _ = False
isFresh (f:fs) y = if (y >= a && y <= b) then True else isFresh fs y
  where [a,b] = map read $ splitOn "-" f
