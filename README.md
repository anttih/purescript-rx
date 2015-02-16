# Module Documentation

## Module Rx.JQuery

### Values

#### `liveAsObservable`

    liveAsObservable :: forall eff a. String -> String -> JQuery -> Eff (dom :: DOM | eff) (Observable JQueryEvent)

#### `onAsObservable`

    onAsObservable :: forall eff a. String -> JQuery -> Eff (dom :: DOM | eff) (Observable JQueryEvent)


## Module Rx.Observable

### Types

#### `Observable`

    data Observable :: * -> *


### Type Class Instances

#### `altObservable`

    instance altObservable :: Alt Observable

#### `alternativeObservable`

    instance alternativeObservable :: Alternative Observable

#### `applicativeObservable`

    instance applicativeObservable :: Applicative Observable

#### `applyObservable`

    instance applyObservable :: Apply Observable

#### `functorObservable`

    instance functorObservable :: Functor Observable

#### `monadObservable`

    instance monadObservable :: Monad Observable

#### `monadPlusObservable`

    instance monadPlusObservable :: MonadPlus Observable

#### `observableBind`

    instance observableBind :: Bind Observable

#### `plusObservable`

    instance plusObservable :: Plus Observable

#### `semigroupObservable`

    instance semigroupObservable :: Semigroup (Observable a)


### Values

#### `combineLatest`

    combineLatest :: forall a b c. (a -> b -> c) -> Observable a -> Observable b -> Observable c

#### `concat`

    concat :: forall a. Observable a -> Observable a -> Observable a

#### `debounce`

    debounce :: forall a. Number -> Observable a -> Observable a

#### `delay`

    delay :: forall a. Number -> Observable a -> Observable a

#### `distinct`

    distinct :: forall a. Observable a -> Observable a

#### `distinctUntilChanged`

    distinctUntilChanged :: forall a. Observable a -> Observable a

#### `filter`

    filter :: forall a. (a -> Boolean) -> Observable a -> Observable a

#### `flatMap`

    flatMap :: forall a b. Observable a -> (a -> Observable b) -> Observable b

#### `flatMapLatest`

    flatMapLatest :: forall a b. Observable a -> (a -> Observable b) -> Observable b

#### `fromArray`

    fromArray :: forall a. [a] -> Observable a

#### `merge`

    merge :: forall a. Observable a -> Observable a -> Observable a

#### `reduce`

    reduce :: forall a b. (a -> b -> b) -> b -> Observable a -> Observable b

#### `scan`

    scan :: forall a b. Observable a -> (a -> b -> b) -> b -> Observable b

#### `subscribe`

    subscribe :: forall eff a. Observable a -> (a -> Eff eff Unit) -> Eff eff Unit

#### `subscribeOnCompleted`

    subscribeOnCompleted :: forall eff a. Observable a -> (Unit -> Eff eff Unit) -> Eff eff Unit

#### `switchLatest`

    switchLatest :: forall a. Observable (Observable a) -> Observable a

#### `take`

    take :: forall a. Number -> Observable a -> Observable a

#### `takeUntil`

    takeUntil :: forall a b. Observable b -> Observable a -> Observable a

#### `unwrap`

    unwrap :: forall eff a. Observable (Eff eff a) -> Eff eff (Observable a)

#### `zip`

    zip :: forall a b c. (a -> b -> c) -> Observable a -> Observable b -> Observable c


## Module Rx.Observable.Cont

### Types

#### `Event`

    data Event err a
      = OnError err
      | OnNext a
      | OnCompleted 


### Values

#### `fromCont`

    fromCont :: forall eff e a. (Error e) => ContT Unit (Eff eff) (Event e a) -> Eff eff (ErrorT e Observable a)

#### `fromErrCont`

    fromErrCont :: forall eff e a. (Error e) => ErrorT e (ContT Unit (Eff eff)) a -> Eff eff (ErrorT e Observable a)



