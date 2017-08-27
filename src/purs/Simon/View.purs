module Simon.View
  ( view
  ) where

import Prelude hiding (div)

import Pux.DOM.Events (onClick)
import Pux.DOM.HTML (HTML)
import Text.Smolder.Markup (text, (#!))
import Text.Smolder.HTML (div, button)

import Simon.Update (State)
import Simon.Events (Event(..))

view :: State -> HTML Event
view state =
  div do
    button #! onClick (const Increment) $ text "Increment"
    div $ text $ "Count " <> show state
    button #! onClick (const Decrement) $ text "Decrement"

