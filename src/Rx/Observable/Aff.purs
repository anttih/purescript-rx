module Rx.Observable.Aff where

import Control.Monad.Eff (Eff)
import Control.Monad.Aff (Aff)

import Rx.Observable (Observable)

foreign import liftAff :: forall eff a. Aff eff a -> Eff eff (Observable a)
