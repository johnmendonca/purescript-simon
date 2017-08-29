module Simon.Update
  ( State
  , Event(..)
  , AppEffects
  , foldp
  , initialState
  ) where

import Prelude

import Control.Monad.Aff (delay)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (CONSOLE)
import Control.Monad.Eff.Random (RANDOM)
import Data.Array (length, range, snoc, zipWith)
import Data.Foldable (notElem)
import Data.Int (toNumber)
import Data.Maybe (Maybe(Just, Nothing))
import Data.Time.Duration (Milliseconds(..))
import Pux (EffModel, noEffects, onlyEffects)
import Simon.Colors (Color, randomColors)

type AppEffects = (console :: CONSOLE, random :: RANDOM)

type State =
  { currentColor :: Maybe Color
  , sequence :: Array Color
  , count :: Int
  , userClicks :: Array Color
  }

initialState :: State
initialState =
  { currentColor: Nothing
  , sequence: []
  , count: 0
  , userClicks: []
  }

data Event
  = UserClick Color
  | ResetColor
  | StartGame
  | NextSequence (Array Color)
  | AnimateColor Color
  | PlaySequence

foldp :: Event -> State -> EffModel State Event AppEffects
foldp (UserClick color) state =
  let
    newClicks = snoc state.userClicks color
    winning   = notElem false (zipWith (==) newClicks state.sequence)
    fullMove  = length newClicks == state.count
    finished  = length newClicks == length state.sequence
  in
    if fullMove && winning && finished then
      onlyEffects state
        [ pure $ Just $ AnimateColor color
        , pure $ Just StartGame
        ]
    else if fullMove && winning then
      { state: state { count = state.count + 1, userClicks = [] }
      , effects:
        [ pure $ Just $ AnimateColor color
        , pure $ Just PlaySequence
        ]
      }
    else if winning then
      { state: state { userClicks = newClicks }
      , effects: [ pure $ Just $ AnimateColor color ]
      }
    else
      onlyEffects state
        [ pure $ Just $ AnimateColor color
        , pure $ Just StartGame
        ]

foldp ResetColor state = noEffects state
  { currentColor = Nothing }

foldp StartGame state = onlyEffects state
  [ do
      colors <- liftEff $ randomColors 20
      pure $ Just $ NextSequence colors
  ]

foldp (NextSequence colors) state =
  { state: state { sequence = colors, count = 1, userClicks = [] }
  , effects:
    [ pure $ Just PlaySequence ]
  }

foldp (AnimateColor color) state =
  { state: state { currentColor = Just color }
  , effects:
    [ delay (Milliseconds 300.0) $> Just ResetColor ]
  }

foldp PlaySequence state = onlyEffects state $
  zipWith fn (range 1 state.count) state.sequence
  where
    fn index color = do
      delay $ Milliseconds (toNumber index * 1000.0)
      pure $ Just $ AnimateColor color

