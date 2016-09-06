/* global exports */
"use strict";

// module Rx.Observable.Cont

var Rx = require('rxjs');

exports._liftCont = function (cont) {
  return function() {
    return new Rx.Observable.create(function (observer) {
      function callback(a) {
        return function() {
          switch (a.constructor.name) {
            case "Next": observer.next(a.value0); break;
            case "Error": observer.error(a.value0); break;
          }
          observer.complete();
        };
      }
      cont(callback)();
    }).publishLast().refCount();
  };
}
