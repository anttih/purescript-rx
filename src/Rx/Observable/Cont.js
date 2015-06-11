/* global exports */
"use strict";

// module Rx.Observable.Cont

var Rx = require('rx');

exports._liftCont = function (cont) {
  return function() {
    return new Rx.AnonymousObservable(function (observer) {
      function callback(a) {
        return function() {
          switch (a.constructor.name) {
            case "OnNext": observer.onNext(a.value0); break;
            case "OnError": observer.onError(a.value0); break;
          }
          observer.onCompleted();
        };
      }
      cont(callback)();
    }).publishLast().refCount();
  };
}
