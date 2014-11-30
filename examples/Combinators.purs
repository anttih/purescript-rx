module Combinators where

import Debug.Trace
import Rx.Observable

main = do
  a <- return $ fromArray [1,2,3]
  b <- return $ fromArray [4,5,6]

  subscribe (a <> b) $ trace <<< show

  subscribe (combineLatest (+) a b) $ trace <<< show

