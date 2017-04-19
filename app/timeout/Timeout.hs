{-# LANGUAGE JavaScriptFFI #-}

import Data.JSString (JSString, unpack)
import System.Timeout (timeout)

foreign import javascript interruptible
  "setTimeout(function() { $c(\"finished\"); }, 1000*Math.random());"
  js_timeout :: IO JSString

main :: IO ()
main = do
  ret <- timeout (500*1000) js_timeout
  case ret of
    Nothing -> putStrLn "not finished"
    Just str -> putStrLn $ unpack str
