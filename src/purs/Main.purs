module Main where

import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, logShow)
import Control.Monad.Eff.Random (RANDOM, randomInt)
import Data.Unfoldable (replicateA)

main :: ∀ t1. Eff ( console :: CONSOLE, random :: RANDOM | t1 ) Unit
main = do
  randoms :: Array Int <- replicateA 20 $ randomInt 1 40
  logShow randoms
  pure unit

