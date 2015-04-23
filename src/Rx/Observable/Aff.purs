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
      var subject = new Rx.AsyncSubject();
      aff(function(a) {
        subject.onNext(a);
        subject.onCompleted();
      }, function(e) {
        subject.onError(e);
      });
      return subject;
    };
  }
  """ :: forall eff err a. Aff eff a -> Eff eff (Observable a)
