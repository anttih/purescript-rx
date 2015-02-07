# Module Documentation

## Module Rx.JQuery

### Values


    liveAsObservable :: forall eff a. String -> String -> JQuery -> Eff (dom :: DOM | eff) (Observable JQueryEvent)


    onAsObservable :: forall eff a. String -> JQuery -> Eff (dom :: DOM | eff) (Observable JQueryEvent)


## Module Rx.Observable

### Types


    data Observable :: * -> *


### Type Class Instances


    instance altObservable :: Alt Observable


    instance alternativeObservable :: Alternative Observable


    instance applicativeObservable :: Applicative Observable


    instance applyObservable :: Apply Observable


    instance functorObservable :: Functor Observable


    instance monadObservable :: Monad Observable


    instance monadPlusObservable :: MonadPlus Observable


    instance observableBind :: Bind Observable


    instance plusObservable :: Plus Observable


    instance semigroupObservable :: Semigroup (Observable a)


### Values


    combineLatest :: forall a b c. (a -> b -> c) -> Observable a -> Observable b -> Observable c


    concat :: forall a. Observable a -> Observable a -> Observable a


    debounce :: forall a. Number -> Observable a -> Observable a


    delay :: forall a. Number -> Observable a -> Observable a


    flatMap :: forall a b. Observable a -> (a -> Observable b) -> Observable b


    flatMapLatest :: forall a b. Observable a -> (a -> Observable b) -> Observable b


    fromArray :: forall a. [a] -> Observable a


    merge :: forall a. Observable a -> Observable a -> Observable a


    reduce :: forall a b. (a -> b -> b) -> b -> Observable a -> Observable b


    scan :: forall a b. Observable a -> (a -> b -> b) -> b -> Observable b


    subscribe :: forall eff a. Observable a -> (a -> Eff eff Unit) -> Eff eff Unit


    subscribeOnCompleted :: forall eff a. Observable a -> (Unit -> Eff eff Unit) -> Eff eff Unit


    switchLatest :: forall a. Observable (Observable a) -> Observable a


    take :: forall a. Number -> Observable a -> Observable a


    takeUntil :: forall a b. Observable b -> Observable a -> Observable a


    unwrap :: forall eff a. Observable (Eff eff a) -> Eff eff (Observable a)


    zip :: forall a b c. (a -> b -> c) -> Observable a -> Observable b -> Observable c


## Module Rx.Observable.Cont

### Types


    data Event err a where
      OnError :: err -> Event err a
      OnNext :: a -> Event err a
      OnCompleted :: Event err a


### Values


    fromCont :: forall eff e a. (Error e) => ContT Unit (Eff eff) (Event e a) -> Eff eff (ErrorT e Observable a)


    fromErrCont :: forall eff e a. (Error e) => ErrorT e (ContT Unit (Eff eff)) a -> Eff eff (ErrorT e Observable a)



