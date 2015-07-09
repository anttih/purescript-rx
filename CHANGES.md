## 0.7.0

This version only works with version 0.7.x of the PureScript compiler.

### Breaking changes

* Removed jQuery bindings, they are being moved to a separate library


## 0.6.0

### Breaking changes

* Rename Event to Notification and move to own module

### New features

* Add materialize and dematerialize
* Add subscribe'
* Add subscribeOnError


## v0.5.0

### Breaking changes

* Changes in ContT support:
  * Rename `fromCont` to `liftCont`
  * Event type now has a fixed type for errors: a javascript error. This is now
    possible because `Observable` implements `MonadError`.
  * `liftCont` now passes OnError events as Observable errors
  * Removed `fromErrCont` to keep the API simple

### New features

* Add `MonadError` instance
* Add Aff support (`liftAff`)

### Other stuff

* Use grunt again and compile examples by default


## v0.4.0

### Breaking changes

* Change `Bind` implementation to use `flatMap` instead of `flatMapLatest`
* Change `scan` param order
* Use `require` for loading Rx (this means you'll need to use browserify in
  order to deploy to the browser)

### New features

* Add `distinct`, `distinctUntilChanged`, `filter` (Tom Crockett)
* Add `generate` and `range`
* Add `withLatestFrom`
* Add `runObservable`
