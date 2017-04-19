module Main where

import GHCJS.Types (JSVal, jsval)
import qualified Data.JSString as JSS
import qualified JavaScript.Array as JSA
import Language.Javascript.JSaddle (runJSaddle, MakeArgs, jsg, jsf)
import Control.Lens ((^.))

foreign import javascript unsafe "console.log($1)" consoleLogF :: JSVal -> IO ()

consoleLogJ :: (MakeArgs args) => args -> IO ()
consoleLogJ x = do
  c <- jsg "console"
  _ <- c ^. jsf "log" x
  return ()

main :: IO ()
main = do
  let val1 = "Hello, world!"
  let val2 = ["Hello, ", "world!"]
  consoleLogF $ jsval $ JSS.pack val1
  consoleLogF $ jsval $ JSA.fromList $ map (jsval . JSS.pack) val2
  runJSaddle () $ do
    consoleLogJ val1
    consoleLogJ val2
