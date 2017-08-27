module Main where

import Prelude

import Simon.Update (foldp, AppEffects, initialState)
import Simon.View (view)

import Control.Monad.Eff (Eff)
import Pux (CoreEffects, start)
import Pux.Renderer.React (renderToDOM)

main :: Eff (CoreEffects AppEffects) Unit
main = do
  app <- start
    { initialState: initialState
    , view
    , foldp
    , inputs: []
    }
  renderToDOM "#simon-app" app.markup app.input

