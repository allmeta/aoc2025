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

solve fresh available = length $ filter (isFresh fresh) available

isFresh [] _ = False
isFresh (f:fs) y = if (x >= (read a :: Int) && x <= (read b :: Int)) then True else isFresh fs y
  where [a,b] = splitOn "-" f
        x = read y
