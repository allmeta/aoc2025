import Data.List
import qualified Data.IntMap.Strict as M
import Data.Char
import Data.List.Split
import Debug.Trace

main :: IO()
main = do
  file <- readFile "input"
  let mapped = map reverse $ transpose $ map words $ lines file
  putStrLn $ show $ sum $ map solve mapped

solve (f:xs) = case f of
               "*" -> product $ map read xs
               "+" -> sum $ map read xs
