module Main where

import Prelude

import Control.Monad.Eff (Eff)

import Simon.Update (foldp, AppEffects)
import Simon.View (view)

import Pux (CoreEffects, start)
import Pux.Renderer.React (renderToDOM)

main :: Eff (CoreEffects AppEffects) Unit
main = do
  app <- start
    { initialState: 0
    , view
    , foldp
    , inputs: []
    }
  renderToDOM "#simon-app" app.markup app.input

