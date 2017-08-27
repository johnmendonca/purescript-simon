module Simon.Update
  ( State
  , Event(..)
  , AppEffects
  , foldp
  , initialState
  ) where

import Prelude

import Simon.Colors (Color)

import Control.Monad.Aff (delay)
import Control.Monad.Eff.Console (CONSOLE)
import Data.Maybe (Maybe(..))
import Data.Time.Duration (Milliseconds(..))
import Pux (EffModel, noEffects)

type AppEffects = (console :: CONSOLE)

type State =
  { currentColor :: Maybe Color
  }

initialState :: State
initialState = { currentColor: Nothing }

data Event = UserClick Color | ResetColor

foldp :: Event -> State -> EffModel State Event AppEffects
foldp (UserClick color) state =
  { state: state { currentColor = Just color }
  , effects:
    [ delay (Milliseconds 300.0) $> Just ResetColor ]
  }

foldp ResetColor state = noEffects state { currentColor = Nothing }
