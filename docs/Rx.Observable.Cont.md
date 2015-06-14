## Module Rx.Observable.Cont

#### `liftCont`

``` purescript
liftCont :: forall eff a. ContT Unit (Eff eff) (Notification a) -> Eff eff (Observable a)
```


