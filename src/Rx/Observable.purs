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
  , flatMapLatest
  , fromArray
  , generate
  , merge
  , reduce
  , range
  , runObservable
  , scan
  , subscribe
  , subscribeOnCompleted
  , subscribeOnError
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
import Control.Monad.Eff.Exception (Error())
import Control.Monad.Error.Class
import Control.Alternative
import Control.Monad.Eff
import Data.Function(Fn2(), runFn2)
import DOM

-- | A type which represents streams of discrete events. Please see
-- | [RxJS API documentation](https://github.com/Reactive-Extensions/RxJS/tree/master/doc)
-- | for more more examples.

foreign import data Observable :: * -> *

instance functorObservable :: Functor Observable where
  (<$>) = map

instance applyObservable :: Apply Observable where
  (<*>) = combineLatest id

instance applicativeObservable :: Applicative Observable where
  pure = just

instance observableBind :: Bind Observable where
  (>>=) = flatMap

instance monadObservable :: Monad Observable

instance semigroupObservable :: Semigroup (Observable a) where
  (<>) = concat

instance altObservable :: Alt Observable where
  (<|>) = merge

instance plusObservable :: Plus Observable where
  empty = _empty

instance alternativeObservable :: Alternative Observable

instance monadPlusObservable :: MonadPlus Observable

instance monadErrorObservable :: MonadError Error Observable where
  catchError = runFn2 _catchError
  throwError = _throwError


foreign import just
  """
  function just(x) {
    var Rx = require('rx');
    return Rx.Observable.just(x);
  }
  """ :: forall a. a -> Observable a

foreign import fromArray
  """
  function fromArray(xs) {
    var Rx = require('rx');
    return Rx.Observable.fromArray(xs);
  }
  """ :: forall a. [a] -> Observable a

foreign import _empty
  """
  var Rx = require('rx');
  var _empty = Rx.Observable.empty();
  """ :: forall a. Observable a

foreign import generate
  """
  function generate(initial) {
    return function (condition) {
      return function (step) {
        return function (selector) {
          var Rx = require('rx');
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

foreign import subscribeOnError
  """
  function subscribeOnError(ob) {
    return function(f) {
      return function() {
        return ob.subscribeOnError(function(err) {
          f(err)();
        });
      };
    };
  }
  """ :: forall eff a. Observable a -> (Error -> Eff eff Unit) -> Eff eff Unit

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
      var Rx = require('rx');
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

foreign import _throwError
  """
  function _throwError(e) {
    var Rx = require('rx');
    return Rx.Observable.throw(e)
  }
  """ :: forall a. Error -> Observable a

foreign import _catchError
  """
  function _catchError(ob, f) {
    return ob.catch(f);
  }
  """ :: forall a. Fn2 (Observable a) (Error -> Observable a) (Observable a)
