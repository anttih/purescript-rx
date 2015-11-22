/* global exports */
"use strict";

// module Rx.Observable

var Rx = require('rx');

exports.just = Rx.Observable.just;

exports.fromArray = Rx.Observable.fromArray;

exports._empty = Rx.Observable.empty();

exports.generate = function (initial) {
  return function (condition) {
    return function (step) {
      return function (selector) {
        return Rx.Observable.generate(initial, condition, step, selector);
      };
    };
  };
}

exports["subscribe'"] = function (ob) {
  return function(onNext) {
    return function(onError) {
      return function(onCompleted) {
        return function() {
          return ob.subscribe(
            function(value) { onNext(value)(); },
            function(err) { onError(err)(); },
            function() { onCompleted()(); }
          );
        };
      };
    };
  };
}

exports.subscribe = function (ob) {
  return function(f) {
    return function() {
      return ob.subscribe(function(value) {
        f(value)();
      });
    };
  };
}

exports.subscribeOnCompleted = function (ob) {
  return function(f) {
    return function() {
      return ob.subscribeOnCompleted(function(value) {
        f(value)();
      });
    };
  };
}

exports.subscribeOnError = function (ob) {
  return function(f) {
    return function() {
      return ob.subscribeOnError(function(err) {
        f(err)();
      });
    };
  };
}

exports.merge = function (ob) {
  return function(other) {
    return ob.merge(other);
  };
}

exports.combineLatest = function (f) {
  return function(ob1) {
    return function(ob2) {
      return ob1.combineLatest(ob2, function (x, y) {
        return f(x)(y);
      });
    };
  };
}

exports.concat = function (x) {
  return function(y) {
    return x.concat(y);
  };
}

exports.take = function (n) {
  return function(ob) {
    return ob.take(n);
  };
}

exports.takeUntil = function (other) {
  return function(ob) {
    return ob.takeUntil(other);
  };
}

exports._map = function (f) {
  return function(ob) {
    return ob.map(f);
  };
}

exports.flatMap = function (ob) {
  return function(f) {
    return ob.flatMap(f);
  };
}

exports.flatMapLatest = function (ob) {
  return function(f) {
    return ob.flatMapLatest(f);
  };
}

exports.scan = function scan(f) {
  return function(seed) {
    return function(ob) {
      return ob.scan(function(acc, value) {
        return f(value)(acc);
      }, seed);
    };
  };
}

exports.unwrap = function (ob) {
  return function() {
    return ob.map(function(eff) {
      return eff();
    });
  };
}

exports.runObservable = function (ob) {
  return function() {
    ob.subscribe(function(eff) {
      eff();
    });
  };
}

exports.switchLatest = function (ob) {
  return ob.switchLatest();
}

exports.debounce = function (ms) {
  return function(ob) {
    return ob.debounce(ms);
  };
}

exports.zip = function (f){
  return function(ob1){
    return function(ob2){
      return ob1.zip(ob2, function (x, y) {
        return f(x)(y);
      });
    };
  };
}

exports.range = function (begin) {
  return function (end) {
    return Rx.Observable.range(begin, end);
  };
}

exports.reduce = function (f){
  return function(seed){
    return function(ob){
      return ob.reduce(function (x, y) {
        return f(x)(y);
      }, seed);
    };
  };
}

exports.delay = function (ms){
  return function(ob){
    return ob.delay(ms);
  };
}

exports._materialize = function (ob, onNext, onError, onCompleted) {
  return ob.materialize().map(function(x) {
    switch (x.kind) {
      case 'N': return onNext(x.value);
      case 'E': return onError(x.exception);
      case 'C': return onCompleted;
    }
  });
}

exports.dematerialize = function (ob) {
  return ob.map(function(a) {
    switch (a.constructor.name) {
      case "OnNext": return Rx.Notification.createOnNext(a.value0);
      case "OnError": return Rx.Notification.createOnError(a.value0);
      case "OnCompleted": return Rx.Notification.createOnCompleted();
    }
  }).dematerialize();
}

exports.distinct = function (ob){
  return ob.distinct();
}

exports.distinctUntilChanged = function (ob){
  return ob.distinctUntilChanged();
}

exports.filter = function (p){
  return function(ob){
    return ob.filter(p);
  };
}

exports.withLatestFrom = function (f) {
  return function (ob1) {
    return function (ob2) {
      return ob1.withLatestFrom(ob2, function(x, y) {
        return f(x)(y);
      })
    };
  };
}

exports._throwError = Rx.Observable.throw;

exports._catchError = function (ob, f) {
  return ob.catch(f);
}
