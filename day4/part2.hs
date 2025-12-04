import Data.List
import qualified Data.Map.Strict as M
import Data.Char
import Data.List.Split
import Debug.Trace

type Grid = M.Map GridK GridV
type GridV = Char
type GridK = (Int, Int)

ns :: [GridK]
ns = [(1, 0), (-1, 0), (0, 1), (0, -1),
      (1, 1), (1, -1), (-1, 1), (-1, -1)]

main :: IO()
main = do
  file <- readFile "input"
  let grid = mkGrid $ lines file
  let (n, _) = part2 0 grid
  putStrLn $ show n

part2 :: Int -> Grid -> (Int, Grid)
part2 m grid = if n == 0 then (m,grid) else part2 (m+n) newGrid
 where
  rolls = M.toList $ M.filter (== '@') grid
  (n, newGrid) = foldl solve (0,grid) rolls

-- go through keys, count neighboards < 4. sum
solve :: (Int, Grid) -> (GridK, GridV) -> (Int, Grid)
solve (n, grid) g = if v < 4 then (n+1, M.insert (fst g) '.' grid) else (n,grid)
  where 
    v = length $ filter (canAccess g grid) ns

canAccess :: (GridK, GridV) -> Grid -> GridK -> Bool
canAccess ((x,y),_) grid (nx,ny) = 
  Just '@' == grid M.!? (x+nx,y+ny)

mkGrid :: [[Char]] -> Grid
mkGrid ys = 
  M.fromList
    [ ((x, y), val) 
    | (y, row) <- zip [0..] ys
    , (x, val) <- zip [0..] row
    ]
