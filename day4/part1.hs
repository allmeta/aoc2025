import Data.List
import qualified Data.Map.Lazy as M
import Data.Char
import Data.List.Split
import Debug.Trace

main :: IO()
main = do
  file <- readFile "input"
  let grid = mkGrid $ lines file
  let gridMap = M.fromList grid
  putStrLn $ show $ solve gridMap $ filter (\(_,v)->v=='@') grid

  
-- go through keys, count neighboards < 4. sum
solve gridMap [] = 0
solve gridMap (g:gs) = p + (solve gridMap gs)
  where 
    v = length $ filter (canAccess g gridMap) ns
    p = if v < 4 then 1 else 0

canAccess ((x,y),_) gridMap (nx,ny) = 
  case gridMap M.!? (x+nx,y+ny) of
  Just '@' -> True
  _        -> False
  

mkGrid :: [String] -> [((Int,Int),Char)]
mkGrid = concatMap grid . zip [0..]
  where grid (y,ws) = map (\(x,v) -> ((x,y),v)) $ zip [0..] ws

ns = [(1, 0), (-1, 0), (0, 1), (0, -1),
      (1, 1), (1, -1), (-1, 1), (-1, -1)]
