module Main where

import GHCJS.Types (JSVal, jsval)
import qualified Data.JSString as JSS
import qualified JavaScript.Array as JSA
import Language.Javascript.JSaddle (JSM, runJSaddle, MakeArgs, jsg, jsf, val)
import Control.Lens ((^.))

foreign import javascript unsafe "console.log($1)"
  consoleLogF :: JSVal -> IO ()

consoleLogJ :: (MakeArgs args) => args -> JSM ()
consoleLogJ x = do
  c <- jsg "console"
  _ <- c ^. jsf "log" x
  return ()

main :: IO ()
main = do
  let x1 = "Hello, world!"
  let x2 = ["Hello, ", "world!"]
  consoleLogF $ jsval $ JSS.pack x1
  consoleLogF $ jsval $ JSA.fromList $ map (jsval . JSS.pack) x2
  runJSaddle () $ do
    consoleLogJ $ val x1
    consoleLogJ $ val x2
