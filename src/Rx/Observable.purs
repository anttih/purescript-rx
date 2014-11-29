module Rx.Observable
  ( Observable()
  , Reactive()
  , just
  , empty
  , subscribe
  , merge
  , combineLatest
  , take
  , map
  , unwrap
  , scan
  , switchLatest
  ) where

import Prelude
import Control.Monad.Eff
import DOM

foreign import data Reactive :: !

foreign import data Observable :: * -> *

instance observableFunctor :: Functor Observable where
  (<$>) = map

instance applyObservable :: Apply Observable where
  (<*>) = combineLatest id

instance applicativeObservable :: Applicative Observable where
  pure = just

instance observableBind :: Bind Observable where
  (>>=) = flatMap

instance monadObservable :: Monad Observable

foreign import just
  """
  function just(x) {
    return Rx.Observable.just(x);
  }
  """ :: forall a. a -> Observable a

foreign import empty
  """
  var empty = (function () {
    if (!Rx) {
      return {};
    } else {
      return Rx.Observable.empty();
    }
  }());
  """ :: forall a. Observable a

foreign import subscribe
  """
  function subscribe(ob) {
    return function(f) {
      return function() {
        return ob.subscribe(function(value) {
          f(value)();
        });
      }
    };
  }
  """ :: forall eff a b. Observable a
                      -> (a -> Eff (dom :: DOM | eff) b)
                      -> Eff (dom :: DOM | eff) b

foreign import merge
  """
  function merge(ob) {
    return function(other) {
      return ob.merge(other);
    }
  }
  """ :: forall a. Observable a -> Observable a -> Observable a

foreign import combineLatest
  """
  function combineLatest(f) {
    return function(ob1) {
      return function(ob2) {
        return ob1.combineLatest(ob2, f);
      };
    };
  }
  """ :: forall a b c. (a -> b -> c) -> Observable a -> Observable b -> Observable c

foreign import take
  """
  function take(n) {
    return function(ob) {
      return ob.take(n);
    };
  }
  """ :: forall a. Number -> Observable a -> Observable a

foreign import map
  """
  function map(f) {
    return function(ob) {
      return ob.map(f);
    }
  }
  """ :: forall a b. (a -> b) -> Observable a -> Observable b

foreign import flatMap
  """
  function flatMap(ob) {
    return function(f) {
      return ob.flatMap(f);
    }
  }
  """ :: forall a b. Observable a -> (a -> Observable b) -> Observable b

foreign import scan
  """
  function scan(ob) {
    return function(f) {
      return function(seed) {
        return ob.scan(seed, function(acc, value) {
          return f(value)(acc);
        });
      }
    };
  }
  """ :: forall a b. Observable a -> (a -> b -> b) -> b -> Observable b

foreign import unwrap
  """
  function unwrap(ob) {
    return function() {
      return ob.map(function(eff) {
        return eff();
      });
    };
  }
  """ :: forall eff a. Observable (Eff eff a) -> Eff eff (Observable a)

foreign import switchLatest
  """
  function switchLatest(ob) {
    return ob.switchLatest();
  }
  """ :: forall a. Observable (Observable a) -> Observable a
