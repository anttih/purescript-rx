module Rx.Observable
  ( Observable()
  , combineLatest
  , concat
  , debounce
  , delay
  , dematerialize
  , distinct
  , distinctUntilChanged
  , filter
  , flatMap
  , flatMapLatest
  , fromArray
  , generate
  , materialize
  , merge
  , reduce
  , range
  , runObservable
  , scan
  , startWith
  , subscribe'
  , subscribe
  , subscribeComplete
  , subscribeError
  , switchLatest
  , take
  , takeUntil
  , unwrap
  , zip
  , withLatestFrom
  ) where

import Control.Alt (class Alt)
import Control.Plus (class Plus)
import Control.MonadPlus (class MonadPlus)
import Control.Monad.Eff.Exception (Error())
import Control.Monad.Error.Class (class MonadError)
import Control.Alternative (class Alternative)
import Control.MonadZero (class MonadZero)
import Control.Monad.Eff (Eff)
import Data.Function.Uncurried (Fn2, Fn4, runFn2, runFn4)
import Prelude (class Semigroup, class Monad, class Bind, class Applicative,
               class Apply, class Functor, Unit, id)

import Rx.Notification (Notification(Complete, Error, Next))

-- | A type which represents streams of discrete events. Please see
-- | [RxJS API documentation](https://github.com/Reactive-Extensions/RxJS/tree/master/doc)
-- | for more more examples.

foreign import data Observable :: * -> *

instance functorObservable :: Functor Observable where
  map = _map

instance applyObservable :: Apply Observable where
  apply = combineLatest id

instance applicativeObservable :: Applicative Observable where
  pure = _of

instance observableBind :: Bind Observable where
  bind = flatMap

instance monadObservable :: Monad Observable

instance semigroupObservable :: Semigroup (Observable a) where
  append = concat

instance altObservable :: Alt Observable where
  alt = merge

instance plusObservable :: Plus Observable where
  empty = _empty

instance alternativeObservable :: Alternative Observable

instance monadZero :: MonadZero Observable

instance monadPlusObservable :: MonadPlus Observable

instance monadErrorObservable :: MonadError Error Observable where
  catchError = runFn2 _catchError
  throwError = _throwError


foreign import _of :: forall a. a -> Observable a

foreign import fromArray :: forall a. Array a -> Observable a

foreign import _empty :: forall a. Observable a

foreign import generate
  :: forall a b. a -> (a -> Boolean) -> (a -> a) -> (a -> b) -> Observable b

foreign import subscribe'
  :: forall eff a. Observable a
  -> (a -> Eff eff Unit)
  -> (Error -> Eff eff Unit)
  -> (Unit -> Eff eff Unit)
  -> Eff eff Unit

foreign import subscribe :: forall eff a. Observable a -> (a -> Eff eff Unit) -> Eff eff Unit

foreign import subscribeComplete
  :: forall eff a. Observable a -> (Unit -> Eff eff Unit) -> Eff eff Unit

foreign import subscribeError
  :: forall eff a. Observable a -> (Error -> Eff eff Unit) -> Eff eff Unit

foreign import merge :: forall a. Observable a -> Observable a -> Observable a

foreign import combineLatest
  :: forall a b c. (a -> b -> c) -> Observable a -> Observable b -> Observable c

foreign import concat :: forall a. Observable a -> Observable a -> Observable a

foreign import take :: forall a. Int -> Observable a -> Observable a

foreign import takeUntil :: forall a b. Observable b -> Observable a -> Observable a

foreign import _map :: forall a b. (a -> b) -> Observable a -> Observable b

foreign import flatMap :: forall a b. Observable a -> (a -> Observable b) -> Observable b

foreign import flatMapLatest :: forall a b. Observable a -> (a -> Observable b) -> Observable b

foreign import scan :: forall a b. (a -> b -> b) -> b -> Observable a -> Observable b

foreign import startWith :: forall a. a -> Observable a -> Observable a

foreign import unwrap :: forall eff a. Observable (Eff eff a) -> Eff eff (Observable a)

foreign import runObservable :: forall eff. Observable (Eff eff Unit) -> Eff eff Unit

foreign import switchLatest :: forall a. Observable (Observable a) -> Observable a

foreign import debounce :: forall a. Int -> Observable a -> Observable a

foreign import zip :: forall a b c. (a -> b -> c) -> Observable a -> Observable b -> Observable c

foreign import range :: Int -> Int -> Observable Int

foreign import reduce :: forall a b. (a -> b -> b) -> b -> Observable a -> Observable b

foreign import delay :: forall a. Int -> Observable a -> Observable a

foreign import _materialize
  :: forall a.
     Fn4
     (Observable a)
     (a -> Notification a)
     (Error -> Notification a)
     (Notification a)
     (Observable (Notification a))

materialize :: forall a. Observable a -> Observable (Notification a)
materialize ob = runFn4 _materialize ob Next Error Complete

foreign import dematerialize :: forall a. Observable (Notification a) -> Observable a

foreign import distinct :: forall a. Observable a -> Observable a

foreign import distinctUntilChanged :: forall a. Observable a -> Observable a

foreign import filter :: forall a. (a -> Boolean) -> Observable a -> Observable a

foreign import withLatestFrom
  :: forall a b c. (a -> b -> c) -> Observable a -> Observable b -> Observable c

foreign import _throwError :: forall a. Error -> Observable a

foreign import _catchError :: forall a. Fn2 (Observable a) (Error -> Observable a) (Observable a)
