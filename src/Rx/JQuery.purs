module Rx.JQuery where

import DOM
import Control.Monad.Eff
import Data.Foreign
import Control.Monad.JQuery (JQuery(), JQueryEvent())
import Rx.Observable

foreign import liveAsObservable
  """
  function liveAsObservable(evt) {
    return function(sel) {
      return function(ob) {
        return function() {
          return ob.onAsObservable(evt, sel);
        }
      }
    }
  }
  """ :: forall eff a. String -> String -> JQuery -> Eff (dom :: DOM | eff) (Observable JQueryEvent)

foreign import onAsObservable
  """
  function onAsObservable(evt) {
    return function(ob) {
      return function() {
        return ob.onAsObservable(evt);
      }
    }
  }
  """ :: forall eff a. String -> JQuery -> Eff (dom :: DOM | eff) (Observable JQueryEvent)
