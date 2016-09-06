/* global exports */
"use strict";

// module Rx.Observable

var Rx = require('rxjs');

exports._of = Rx.Observable.of;

exports.fromArray = Rx.Observable.from;

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
  return function(next) {
    return function(error) {
      return function(complete) {
        return function() {
          return ob.subscribe(
            function(value) { next(value)(); },
            function(err) { error(err)(); },
            function() { complete()(); }
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

exports.subscribeComplete = function (ob) {
  return function(f) {
    return function() {
      return ob.subscribe(null, null, function(value) {
        f(value)();
      });
    };
  };
}

exports.subscribeError = function (ob) {
  return function(f) {
    return function() {
      return ob.subscribe(null, function(err) {
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

exports.startWith = function (start) {
  return function(ob) {
    return ob.startWith(start);
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

exports._materialize = function (ob, next, error, complete) {
  return ob.materialize().map(function(x) {
    switch (x.kind) {
      case 'N': return next(x.value);
      case 'E': return error(x.exception);
      case 'C': return complete;
    }
  });
}

exports.dematerialize = function (ob) {
  return ob.map(function(a) {
    switch (a.constructor.name) {
      case "Next": return Rx.Notification.createNext(a.value0);
      case "Error": return Rx.Notification.createError(a.value0);
      case "Complete": return Rx.Notification.createComplete();
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
