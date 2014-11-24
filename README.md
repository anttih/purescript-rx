# Module Documentation

## Module Rx.Observable

### Types

    data Observable a

    data Reactive :: !


### Type Class Instances

    instance applicativeObservable :: Applicative Observable

    instance applyObservable :: Apply Observable

    instance monadObservable :: Monad Observable

    instance observableBind :: Bind Observable

    instance observableFunctor :: Functor Observable


### Values

    combineLatest :: forall a b c. (a -> b -> c) -> Observable a -> Observable b -> Observable c

    empty :: forall a. Observable a

    just :: forall a. a -> Observable a

    map :: forall a b. (a -> b) -> Observable a -> Observable b

    merge :: forall a. Observable a -> Observable a -> Observable a

    scan :: forall a b. Observable a -> (a -> b -> b) -> b -> Observable b

    subscribe :: forall eff a b. Observable a -> (a -> Eff (dom :: DOM | eff) b) -> Eff (dom :: DOM | eff) b

    switchLatest :: forall a. Observable (Observable a) -> Observable a

    take :: forall a. Number -> Observable a -> Observable a

    unwrap :: forall eff a. Observable (Eff eff a) -> Eff eff (Observable a)


## Module Rx.JQuery

### Types

    data Ajax :: !


### Values

    get :: forall props eff. String -> {  | props } -> Eff (ajax :: Ajax | eff) (Observable Foreign)

    liveAsObservable :: forall eff a. String -> String -> JQuery -> Eff (dom :: DOM | eff) (Observable JQueryEvent)

    onAsObservable :: forall eff a. String -> JQuery -> Eff (dom :: DOM | eff) (Observable JQueryEvent)



