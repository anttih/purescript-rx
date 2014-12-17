# Module Documentation

## Module Rx.Observable

### Types

    data Observable :: * -> *


### Type Class Instances

    instance applicativeObservable :: Applicative Observable

    instance applyObservable :: Apply Observable

    instance monadObservable :: Monad Observable

    instance observableBind :: Bind Observable

    instance observableFunctor :: Functor Observable

    instance semigroupObservable :: Semigroup (Observable a)


### Values

    combineLatest :: forall a b c. (a -> b -> c) -> Observable a -> Observable b -> Observable c

    concat :: forall a. Observable a -> Observable a -> Observable a

    debounce :: forall a. Number -> Observable a -> Observable a

    empty :: forall a. Observable a

    flatMap :: forall a b. Observable a -> (a -> Observable b) -> Observable b

    fromArray :: forall a. [a] -> Observable a

    just :: forall a. a -> Observable a

    map :: forall a b. (a -> b) -> Observable a -> Observable b

    merge :: forall a. Observable a -> Observable a -> Observable a

    reduce :: forall a b. (a -> b -> b) -> b -> Observable a -> Observable b

    scan :: forall a b. Observable a -> (a -> b -> b) -> b -> Observable b

    subscribe :: forall eff a. Observable a -> (a -> Eff eff Unit) -> Eff eff Unit

    switchLatest :: forall a. Observable (Observable a) -> Observable a

    take :: forall a. Number -> Observable a -> Observable a

    takeUntil :: forall a b. Observable b -> Observable a -> Observable a

    unwrap :: forall eff a. Observable (Eff eff a) -> Eff eff (Observable a)

    zip :: forall a b c. (a -> b -> c) -> Observable a -> Observable b -> Observable c


## Module Rx.JQuery

### Types

    data Ajax :: !


### Values

    get :: forall props eff. String -> {  | props } -> Eff (ajax :: Ajax | eff) (Observable Foreign)

    liveAsObservable :: forall eff a. String -> String -> JQuery -> Eff (dom :: DOM | eff) (Observable JQueryEvent)

    onAsObservable :: forall eff a. String -> JQuery -> Eff (dom :: DOM | eff) (Observable JQueryEvent)



