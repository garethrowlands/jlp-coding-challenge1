module Main where

-- import System
import FormatTime
import System.Environment

main :: IO ()
main = do
    (s:_) <- getArgs
    let n = read s
    putStrLn $ formatTime n


