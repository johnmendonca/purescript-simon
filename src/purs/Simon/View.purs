module Simon.View
  ( view
  ) where

import Prelude hiding (div)

import Simon.Colors (Color(..))
import Simon.Styles (styledButton)
import Simon.Update (State, Event(..))

import Data.Maybe (Maybe(..))
import Pux.DOM.Events (onClick)
import Pux.DOM.HTML (HTML)
import Text.Smolder.HTML (div, span)
import Text.Smolder.Markup (text, (!), (#!))

activeCheck :: Maybe Color -> Color -> Boolean
activeCheck currentColor =
  case currentColor of
    Nothing      -> const false
    Just current -> (==) current

view :: State -> HTML Event
view { currentColor } =
  div do
    simonButton Red
    simonButton Blue
    simonButton Green
    simonButton Yellow
  where
    simonButton color =
      span
        !  styledButton color (activeCheck currentColor color)
        #! onClick (const $ UserClick color)
        $  text ""

