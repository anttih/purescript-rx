/* global exports */
"use strict";

// module Rx.Observable.Aff

var Rx = require('rxjs');

exports.liftAff = function (aff) {
  return function() {
    var subject = new Rx.AsyncSubject();
    aff(function(a) {
      subject.next(a);
      subject.complete();
    }, function(e) {
      subject.error(e);
    });
    return subject;
  };
}
