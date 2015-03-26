module Rx.Observable
  ( Observable()
  , combineLatest
  , concat
  , debounce
  , delay
  , distinct
  , distinctUntilChanged
  , filter
  , flatMap
  , fromArray
  , generate
  , merge
  , reduce
  , range
  , runObservable
  , scan
  , subscribe
  , subscribeOnCompleted
  , switchLatest
  , take
  , takeUntil
  , unwrap
  , zip
  , withLatestFrom
  ) where

import Control.Alt
import Control.Plus
import Control.MonadPlus
import Control.Alternative
import Control.Monad.Eff
import DOM

-- | A type which represents streams of discrete events. Please see
-- | [RxJs API documentation]() for more more examples.

foreign import data Observable :: * -> *

instance functorObservable :: Functor Observable where
  (<$>) = map

instance applyObservable :: Apply Observable where
  (<*>) = combineLatest id

instance applicativeObservable :: Applicative Observable where
  pure = just

-- | **Note** that we use `flatMapLatest` here instead of `flatMap`. In the browser
-- | environment this is usually what you want. You may use plain `flapMap`
-- | which is exported as well.
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
    var Rx = require('Rx');
    return Rx.Observable.just(x);
  }
  """ :: forall a. a -> Observable a

foreign import fromArray
  """
  function fromArray(xs) {
    var Rx = require('Rx');
    return Rx.Observable.fromArray(xs);
  }
  """ :: forall a. [a] -> Observable a

foreign import empty'
  """
  var Rx = require('Rx');
  var empty$prime = Rx.Observable.empty();
  """ :: forall a. Observable a

foreign import generate
  """
  function generate(initial) {
    return function (condition) {
      return function (step) {
        return function (selector) {
          var Rx = require('Rx');
          return Rx.Observable.generate(initial, condition, step, selector);
        };
      };
    };
  }
  """ :: forall a b. a -> (a -> Boolean) -> (a -> a) -> (a -> b) -> Observable b

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
  function scan(f) {
    return function(seed) {
      return function(ob) {
        return ob.scan(seed, function(acc, value) {
          return f(value)(acc);
        });
      };
    };
  }
  """ :: forall a b. (a -> b -> b) -> b -> Observable a -> Observable b

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

foreign import runObservable
  """
  function runObservable(ob) {
    return function() {
      ob.subscribe(function(eff) {
        eff();
      });
    };
  }
  """ :: forall eff. Observable (Eff eff Unit) -> Eff eff Unit

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

foreign import range
  """
  function range(begin) {
    return function (end) {
      var Rx = require('Rx');
      return Rx.Observable.range(begin, end);
    };
  }
  """ :: Number -> Number -> Observable Number

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

foreign import distinct
  """
  function distinct(ob){
    return ob.distinct();
  }
  """ :: forall a. Observable a -> Observable a

foreign import distinctUntilChanged
  """
  function distinctUntilChanged(ob){
    return ob.distinctUntilChanged();
  }
  """ :: forall a. Observable a -> Observable a

foreign import filter
  """
  function filter(p){
    return function(ob){
      return ob.filter(p);
    };
  }
  """ :: forall a. (a -> Boolean) -> Observable a -> Observable a

foreign import withLatestFrom
  """
  function withLatestFrom(f) {
    return function (ob1) {
      return function (ob2) {
        return ob1.withLatestFrom(ob2, function(x, y) {
          return f(x)(y);
        })
      };
    };
  }
  """ :: forall a b c. (a -> b -> c) -> Observable a -> Observable b -> Observable c
