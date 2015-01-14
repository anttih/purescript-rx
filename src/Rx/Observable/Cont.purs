module Rx.Observable.Cont
  ( fromCont
  , fromErrCont
  , Event(..)
  )
  where

import Control.Monad.Eff
import Control.Monad.Trans
import Control.Monad.Error
import Control.Monad.Cont.Trans
import Control.Monad.Error.Trans
import Data.Either
import Rx.Observable

data Event err a = OnError err | OnNext a | OnCompleted

foreign import fromContImpl
  """
  function fromContImpl(cont) {
    return function (left) {
      return function (right) {
        return function() {
          return new Rx.AnonymousObservable(function (observer) {
            function callback(a) {
              return function() {
                switch (a.constructor.name) {
                  case "OnNext": observer.onNext(right(a.value0)); break;
                  case "OnError": observer.onNext(left(a.value0)); break;
                }
                observer.onCompleted();
              };
            }
            cont(callback)();
          }).publishLast().refCount();
        };
      };
    };
  }
  """ :: forall eff e a. (((Event e a) -> Eff eff Unit) -> Eff eff Unit)
                      -> (e -> Either e a)
                      -> (a -> Either e a)
                      -> Eff eff (Observable (Either e a))

fromCont :: forall eff e a. (Error e) => ContT Unit (Eff eff) (Event e a) -> Eff eff (ErrorT e Observable a)
fromCont (ContT f) = ErrorT <$> fromContImpl f Left Right

fromErrCont :: forall eff e a. (Error e) => ErrorT e (ContT Unit (Eff eff)) a -> Eff eff (ErrorT e Observable a)
fromErrCont c = fromCont $ toEvent <$> (runErrorT c) where
  toEvent (Right v) = OnNext v
  toEvent (Left err) = OnError err
