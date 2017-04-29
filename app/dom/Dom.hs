import qualified GHCJS.DOM                     as D
import qualified GHCJS.DOM.EventM              as D
import qualified GHCJS.DOM.Document            as D
import qualified GHCJS.DOM.Element             as D
import qualified GHCJS.DOM.Node                as D
import qualified GHCJS.DOM.GlobalEventHandlers as D

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
  return ()
