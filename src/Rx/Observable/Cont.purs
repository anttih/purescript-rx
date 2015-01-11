module Rx.Observable.Cont
  ( fromCont
  , fromErrCont
  )
  where

import Control.Monad.Eff
import Control.Monad.Trans
import Control.Monad.Cont.Trans
import Control.Monad.Error.Trans
import Rx.Observable

foreign import fromContImpl
  """
  function fromContImpl(cont) {
    return function() {
      return new Rx.AnonymousObservable(function (observer) {
        function callback(a) {
          return function() {
            observer.onNext(a);
            observer.onCompleted();
          };
        }
        cont(callback)();
      }).publishLast().refCount();
    };
  }
  """ :: forall eff a. ((a -> Eff eff Unit) -> Eff eff Unit) -> Eff eff (Observable a)

fromCont :: forall eff a. ContT Unit (Eff eff) a -> Eff eff (Observable a)
fromCont (ContT f) = fromContImpl f

fromErrCont :: forall eff e a. ErrorT e (ContT Unit (Eff eff)) a -> Eff eff (ErrorT e Observable a)
fromErrCont m = ErrorT <$> (fromCont $ runErrorT m)

