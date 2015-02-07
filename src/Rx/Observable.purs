module Rx.Observable
  ( Observable()
  , combineLatest
  , concat
  , debounce
  , delay
  , flatMap
  , fromArray
  , flatMapLatest
  , merge
  , reduce
  , scan
  , subscribe
  , subscribeOnCompleted
  , switchLatest
  , take
  , takeUntil
  , unwrap
  , zip
  ) where

import Control.Alt
import Control.Plus
import Control.MonadPlus
import Control.Alternative
import Control.Monad.Eff
import DOM

foreign import data Observable :: * -> *

instance functorObservable :: Functor Observable where
  (<$>) = map

instance applyObservable :: Apply Observable where
  (<*>) = combineLatest id

instance applicativeObservable :: Applicative Observable where
  pure = just

instance observableBind :: Bind Observable where
  (>>=) = flatMapLatest

instance monadObservable :: Monad Observable

instance semigroupObservable :: Semigroup (Observable a) where
  (<>) = concat

instance altObservable :: Alt Observable where
  (<|>) = merge

instance plusObservable :: Plus Observable where
  empty = empty'

instance alternativeObservable :: Alternative Observable

instance monadPlusObservable :: MonadPlus Observable

foreign import just
  """
  function just(x) {
    return Rx.Observable.just(x);
  }
  """ :: forall a. a -> Observable a

foreign import fromArray
  """
  function fromArray(xs) {
    return Rx.Observable.fromArray(xs);
  }
  """ :: forall a. [a] -> Observable a

foreign import empty'
  """
  var empty$prime = (function () {
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
      };
    };
  }
  """ :: forall eff a. Observable a -> (a -> Eff eff Unit) -> Eff eff Unit

foreign import subscribeOnCompleted
  """
  function subscribeOnCompleted(ob) {
    return function(f) {
      return function() {
        return ob.subscribeOnCompleted(function(value) {
          f(value)();
        });
      };
    };
  }
  """ :: forall eff a. Observable a -> (Unit -> Eff eff Unit) -> Eff eff Unit

foreign import merge
  """
  function merge(ob) {
    return function(other) {
      return ob.merge(other);
    };
  }
  """ :: forall a. Observable a -> Observable a -> Observable a

foreign import combineLatest
  """
  function combineLatest(f) {
    return function(ob1) {
      return function(ob2) {
        return ob1.combineLatest(ob2, function (x, y) {
          return f(x)(y);
        });
      };
    };
  }
  """ :: forall a b c. (a -> b -> c) -> Observable a -> Observable b -> Observable c

foreign import concat
  """
  function concat(x) {
    return function(y) {
      return x.concat(y);
    };
  };
  """ :: forall a. Observable a -> Observable a -> Observable a

foreign import take
  """
  function take(n) {
    return function(ob) {
      return ob.take(n);
    };
  }
  """ :: forall a. Number -> Observable a -> Observable a

foreign import takeUntil
  """
  function takeUntil(other) {
    return function(ob) {
      return ob.takeUntil(other);
    };
  }
  """ :: forall a b. Observable b -> Observable a -> Observable a

foreign import map
  """
  function map(f) {
    return function(ob) {
      return ob.map(f);
    };
  }
  """ :: forall a b. (a -> b) -> Observable a -> Observable b

foreign import flatMap
  """
  function flatMap(ob) {
    return function(f) {
      return ob.flatMap(f);
    };
  }
  """ :: forall a b. Observable a -> (a -> Observable b) -> Observable b

foreign import flatMapLatest
  """
  function flatMapLatest(ob) {
    return function(f) {
      return ob.flatMapLatest(f);
    };
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
      };
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

foreign import debounce
  """
  function debounce(ms) {
    return function(ob) {
      return ob.debounce(ms);
    };
  }
  """ :: forall a. Number -> Observable a -> Observable a

foreign import zip
  """
  function zip(f){
    return function(ob1){
      return function(ob2){
        return ob1.zip(ob2, function (x, y) {
          return f(x)(y);
        });
      };
    };
  }
  """ :: forall a b c. (a -> b -> c) -> Observable a -> Observable b -> Observable c

foreign import reduce
  """
  function reduce(f){
    return function(seed){
      return function(ob){
        return ob.reduce(function (x, y) {
          return f(x)(y);
        }, seed);
      };
    };
  }
  """ :: forall a b. (a -> b -> b) -> b -> Observable a -> Observable b

foreign import delay
  """
  function delay(ms){
    return function(ob){
      return ob.delay(ms);
    };
  }
  """ :: forall a. Number -> Observable a -> Observable a
