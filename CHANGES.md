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


