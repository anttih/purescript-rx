# Module Documentation

## Module Rx.JQuery

#### `liveAsObservable`

``` purescript
liveAsObservable :: forall eff a. String -> String -> JQuery -> Eff (dom :: DOM | eff) (Observable JQueryEvent)
```


#### `onAsObservable`

``` purescript
onAsObservable :: forall eff a. String -> JQuery -> Eff (dom :: DOM | eff) (Observable JQueryEvent)
```



## Module Rx.Notification

#### `Notification`

``` purescript
data Notification a
  = OnError Error
  | OnNext a
  | OnCompleted 
```



## Module Rx.Observable

#### `Observable`

``` purescript
data Observable :: * -> *
```

A type which represents streams of discrete events. Please see
[RxJS API documentation](https://github.com/Reactive-Extensions/RxJS/tree/master/doc)
for more more examples.

#### `functorObservable`

``` purescript
instance functorObservable :: Functor Observable
```


#### `applyObservable`

``` purescript
instance applyObservable :: Apply Observable
```


#### `applicativeObservable`

``` purescript
instance applicativeObservable :: Applicative Observable
```


#### `observableBind`

``` purescript
instance observableBind :: Bind Observable
```


#### `monadObservable`

``` purescript
instance monadObservable :: Monad Observable
```


#### `semigroupObservable`

``` purescript
instance semigroupObservable :: Semigroup (Observable a)
```


#### `altObservable`

``` purescript
instance altObservable :: Alt Observable
```


#### `plusObservable`

``` purescript
instance plusObservable :: Plus Observable
```


#### `alternativeObservable`

``` purescript
instance alternativeObservable :: Alternative Observable
```


#### `monadPlusObservable`

``` purescript
instance monadPlusObservable :: MonadPlus Observable
```


#### `monadErrorObservable`

``` purescript
instance monadErrorObservable :: MonadError Error Observable
```


#### `fromArray`

``` purescript
fromArray :: forall a. [a] -> Observable a
```


#### `generate`

``` purescript
generate :: forall a b. a -> (a -> Boolean) -> (a -> a) -> (a -> b) -> Observable b
```


#### `subscribe'`

``` purescript
subscribe' :: forall eff a. Observable a -> (a -> Eff eff Unit) -> (Error -> Eff eff Unit) -> (Unit -> Eff eff Unit) -> Eff eff Unit
```


#### `subscribe`

``` purescript
subscribe :: forall eff a. Observable a -> (a -> Eff eff Unit) -> Eff eff Unit
```


#### `subscribeOnCompleted`

``` purescript
subscribeOnCompleted :: forall eff a. Observable a -> (Unit -> Eff eff Unit) -> Eff eff Unit
```


#### `subscribeOnError`

``` purescript
subscribeOnError :: forall eff a. Observable a -> (Error -> Eff eff Unit) -> Eff eff Unit
```


#### `merge`

``` purescript
merge :: forall a. Observable a -> Observable a -> Observable a
```


#### `combineLatest`

``` purescript
combineLatest :: forall a b c. (a -> b -> c) -> Observable a -> Observable b -> Observable c
```


#### `concat`

``` purescript
concat :: forall a. Observable a -> Observable a -> Observable a
```


#### `take`

``` purescript
take :: forall a. Number -> Observable a -> Observable a
```


#### `takeUntil`

``` purescript
takeUntil :: forall a b. Observable b -> Observable a -> Observable a
```


#### `flatMap`

``` purescript
flatMap :: forall a b. Observable a -> (a -> Observable b) -> Observable b
```


#### `flatMapLatest`

``` purescript
flatMapLatest :: forall a b. Observable a -> (a -> Observable b) -> Observable b
```


#### `scan`

``` purescript
scan :: forall a b. (a -> b -> b) -> b -> Observable a -> Observable b
```


#### `unwrap`

``` purescript
unwrap :: forall eff a. Observable (Eff eff a) -> Eff eff (Observable a)
```


#### `runObservable`

``` purescript
runObservable :: forall eff. Observable (Eff eff Unit) -> Eff eff Unit
```


#### `switchLatest`

``` purescript
switchLatest :: forall a. Observable (Observable a) -> Observable a
```


#### `debounce`

``` purescript
debounce :: forall a. Number -> Observable a -> Observable a
```


#### `zip`

``` purescript
zip :: forall a b c. (a -> b -> c) -> Observable a -> Observable b -> Observable c
```


#### `range`

``` purescript
range :: Number -> Number -> Observable Number
```


#### `reduce`

``` purescript
reduce :: forall a b. (a -> b -> b) -> b -> Observable a -> Observable b
```


#### `delay`

``` purescript
delay :: forall a. Number -> Observable a -> Observable a
```


#### `dematerialize`

``` purescript
dematerialize :: forall a. Observable (Notification a) -> Observable a
```


#### `distinct`

``` purescript
distinct :: forall a. Observable a -> Observable a
```


#### `distinctUntilChanged`

``` purescript
distinctUntilChanged :: forall a. Observable a -> Observable a
```


#### `filter`

``` purescript
filter :: forall a. (a -> Boolean) -> Observable a -> Observable a
```


#### `withLatestFrom`

``` purescript
withLatestFrom :: forall a b c. (a -> b -> c) -> Observable a -> Observable b -> Observable c
```



## Module Rx.Observable.Aff

#### `liftAff`

``` purescript
liftAff :: forall eff err a. Aff eff a -> Eff eff (Observable a)
```



## Module Rx.Observable.Cont

#### `liftCont`

``` purescript
liftCont :: forall eff a. ContT Unit (Eff eff) (Notification a) -> Eff eff (Observable a)
```