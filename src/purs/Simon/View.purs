module Simon.View
  ( view
  ) where

import Prelude hiding (div)

import Text.Smolder.Markup (Markup, text)
import Text.Smolder.HTML (div)

view :: forall e. String -> Markup e
view txt = div $ text txt
