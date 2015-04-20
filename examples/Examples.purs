module Examples where

import Debug.Trace

import Rx.Observable
import Rx.Observable.Aff

main = do
  a <- return $ fromArray [1,2,3]
  b <- return $ fromArray [4,5,6]

  subscribe (a <> b) $ trace <<< show

  subscribe (combineLatest (+) a b) $ trace <<< show

  subscribe (zip (+) a b) (\n -> trace $ "zip: " ++ show n)

  subscribe (reduce (+) 0 (zip (+) a b)) $ trace <<< show

  subscribe (delay 1000 a) $ trace <<< show
