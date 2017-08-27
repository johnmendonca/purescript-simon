module Simon.Colors where

import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Random (RANDOM, random)
import Data.Unfoldable (replicateA)

data Color = Red | Blue | Green | Yellow

instance showColor :: Show Color where
  show Red    = "Red"
  show Blue   = "Blue"
  show Green  = "Green"
  show Yellow = "Yellow"

numberToColor :: Number → Color
numberToColor x
  | x < 0.25  = Red
  | x < 0.50  = Blue
  | x < 0.75  = Green
  | otherwise = Yellow

randomColors :: forall t13. Int -> Eff ( random :: RANDOM | t13 ) (Array Color)
randomColors n = do
  randoms :: Array Number <- replicateA n $ random
  pure $ map numberToColor randoms
  
