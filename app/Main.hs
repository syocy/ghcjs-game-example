{-# LANGUAGE RankNTypes #-}

module Main where

import GHCJS.Types (JSVal, JSString)
import qualified Data.JSString as JSS
import Language.Javascript.JSaddle
import Control.Lens
import qualified Data.Text as T

foreign import javascript unsafe "console.log($1)" consoleLog :: JSString -> IO ()

consoleLog2 arr = jsg ("console" :: String) >>= \c -> c ^. jsf ("log" :: String) arr

consoleLog3 str = jsgf ("console.log" :: String) [str]

main :: IO ()
main = do
  putStrLn "hellob"
  consoleLog $ JSS.pack "hello2"
  runJSaddle () $ do
    consoleLog2 ["hello", "hello", "hello"]
    consoleLog2 ()
    consoleLog2 (1::Int,"aa")
    -- consoleLog3 "hello2"
    consoleLog $ JSS.pack "2111"
  return ()

