module Main where

(><) :: String -> String -> String
a >< b = a ++ "x" ++ b

main :: IO ()
main = do
  putStrLn $ "GHC" >< "JS"
