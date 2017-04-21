import qualified GHCJS.DOM                     as D
import qualified GHCJS.DOM.EventM              as D
import qualified GHCJS.DOM.Document            as D
import qualified GHCJS.DOM.Element             as D
import qualified GHCJS.DOM.Node                as D
import qualified GHCJS.DOM.GlobalEventHandlers as D

import Language.Javascript.JSaddle ( fun, val, valToNumber
                                   , jsg, jsf, js, jss )
import Control.Lens ((^.))

-- consoleLogJ :: (MakeArgs args) => args -> IO ()
consoleLogJ x = do
  c <- jsg "console"
  _ <- c ^. jsf "log" x
  return ()

main :: IO ()
main = do

  Just doc <- D.currentDocument
  Just body <- D.getBody doc
  _ <- D.on doc D.click $ do
    (x, y) <- D.mouseClientXY
    newP <- D.createElement doc "p"
    D.setInnerHTML newP $ Just $ "Clicked: " ++ show (x, y)
    _ <- D.appendChild body newP
    return ()

  doc <- jsg "document"
  body <- doc ^. js "body"
  _ <- doc ^. jsf "addEventListener" (val "click", fun $ \_ _ [e] -> do
    x <- (e ^. js "clientX") >>= valToNumber
    y <- (e ^. js "clientY") >>= valToNumber
    newP <- doc ^. jsf "createElement" (val "p")
    _ <- newP ^. jss "innerHTML" (val $ "Clicked: " ++ show (x, y))
    _ <- body ^. jsf "appendChild" newP
    return ())

  return ()
