module Rx.Observable.Aff where

import Control.Monad.Eff
import Control.Monad.Aff
import Data.Either

import Rx.Observable

foreign import liftAff
  """
  function liftAff(aff) {
    return function() {
      var Rx = require('rx');
      return new Rx.AnonymousObservable(function (observer) {
        return aff(function(a) {
          observer.onNext(a);
          observer.onCompleted();
        }, function(e) {
          observer.onError(e);
        });
      }).publishLast().refCount();
    };
  }
  """ :: forall eff err a. Aff eff a -> Eff eff (Observable a)
