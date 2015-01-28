module Main where

import Debug.Trace
import Data.Tuple (Tuple(..))
import Data.Maybe
import Rx.Observable
import Rx.Observable.Plus
import Control.MonadPlus.Partial

main = do
  (Tuple smaller bigger) <- return $ mpartition ((>) 5) (fromArray [2,3,4,5,6,8,9,10,100])

  trace "smaller:"
  subscribe smaller $ trace <<< show

  trace "bigger:"
  subscribe bigger $ trace <<< show

  subscribe (mcatMaybes $ fromArray [Just 1, Just 2, Nothing, Just 4]) $ trace <<< show
