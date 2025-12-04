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
  let (n,finalGrid) = part2 0 gridMap
  putStrLn $ show n


part2 m gridMap = if n == 0 then (m,gridMap) else part2 (m+n) newgridMap
 where
  rolls = M.toList $ M.filter (== '@') gridMap
  (n, newgridMap) = solve gridMap 0 rolls
  
-- go through keys, count neighboards < 4. sum
solve gridMap n [] = (n,gridMap)
solve gridMap n (g:gs) = (solve newgridMap n' gs)
  where 
    v = length $ filter (canAccess g gridMap) ns
    (n', newgridMap) = if v < 4 then (n+1, M.insert (fst g) '.' gridMap) else (n,gridMap)

canAccess ((x,y),_) gridMap (nx,ny) = 
  case gridMap M.!? (x+nx,y+ny) of
  Just '@' -> True
  _        -> False
  

mkGrid :: [String] -> [((Int,Int),Char)]
mkGrid = concatMap grid . zip [0..]
  where grid (y,ws) = map (\(x,v) -> ((x,y),v)) $ zip [0..] ws

ns = [(1, 0), (-1, 0), (0, 1), (0, -1),
      (1, 1), (1, -1), (-1, 1), (-1, -1)]
