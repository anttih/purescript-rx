## Module Rx.Observable

#### `Observable`

``` purescript
data Observable :: * -> *
```

A type which represents streams of discrete events. Please see
[RxJS API documentation](https://github.com/Reactive-Extensions/RxJS/tree/master/doc)
for more more examples.

##### Instances
``` purescript
instance functorObservable :: Functor Observable
instance applyObservable :: Apply Observable
instance applicativeObservable :: Applicative Observable
instance observableBind :: Bind Observable
instance monadObservable :: Monad Observable
instance semigroupObservable :: Semigroup (Observable a)
instance altObservable :: Alt Observable
instance plusObservable :: Plus Observable
instance alternativeObservable :: Alternative Observable
instance monadPlusObservable :: MonadPlus Observable
instance monadErrorObservable :: MonadError Error Observable
```

#### `fromArray`

``` purescript
fromArray :: forall a. Array a -> Observable a
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
take :: forall a. Int -> Observable a -> Observable a
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
debounce :: forall a. Int -> Observable a -> Observable a
```

#### `zip`

``` purescript
zip :: forall a b c. (a -> b -> c) -> Observable a -> Observable b -> Observable c
```

#### `range`

``` purescript
range :: Int -> Int -> Observable Int
```

#### `reduce`

``` purescript
reduce :: forall a b. (a -> b -> b) -> b -> Observable a -> Observable b
```

#### `delay`

``` purescript
delay :: forall a. Int -> Observable a -> Observable a
```

#### `materialize`

``` purescript
materialize :: forall a. Observable a -> Observable (Notification a)
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


