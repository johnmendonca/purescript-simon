module Main where

import Prelude
import Simon.Colors (randomColors)
import Simon.View (view)

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Random (RANDOM)
import DOM (DOM)
import DOM.HTML (window)
import DOM.HTML.Types (htmlDocumentToParentNode)
import DOM.HTML.Window (document)
import DOM.Node.ParentNode (querySelector)
import Data.Foldable (for_)
import Data.Newtype (wrap)
import Text.Smolder.Renderer.DOM (render)

main :: ∀ t29. Eff ( dom ∷ DOM , random ∷ RANDOM | t29 ) Unit
main = do
  document <- document =<< window
  element <- querySelector (wrap "#simon-app") (htmlDocumentToParentNode document)
  colors <- randomColors 20
  for_ element (flip render (view (show colors)))

