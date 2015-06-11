module Rx.JQuery where

import DOM
import Control.Monad.Eff
import Data.Foreign
import Control.Monad.JQuery (JQuery(), JQueryEvent())
import Rx.Observable

foreign import liveAsObservable
  :: forall eff a. String -> String -> JQuery -> Eff (dom :: DOM | eff) (Observable JQueryEvent)

foreign import onAsObservable
  :: forall eff a. String -> JQuery -> Eff (dom :: DOM | eff) (Observable JQueryEvent)
