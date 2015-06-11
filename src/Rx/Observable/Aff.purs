module Rx.Observable.Aff where

import Control.Monad.Eff
import Control.Monad.Aff
import Data.Either

import Rx.Observable

foreign import liftAff :: forall eff a. Aff eff a -> Eff eff (Observable a)
