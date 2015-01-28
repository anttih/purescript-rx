module Rx.Observable.Plus where

import Control.Alt
import Control.Plus
import Control.MonadPlus
import Control.Alternative
import qualified Rx.Observable as Observable

instance altObservable :: Alt Observable.Observable where
  (<|>) = Observable.merge

instance plusObservable :: Plus Observable.Observable where
  empty = Observable.empty

instance alternativeObservable :: Alternative Observable.Observable

instance monadPlusObservable :: MonadPlus Observable.Observable where


