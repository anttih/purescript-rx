/* global exports */
"use strict";

// module Rx.Observable.Aff

var Rx = require('rx');

exports.liftAff = function (aff) {
  return function() {
    var subject = new Rx.AsyncSubject();
    aff(function(a) {
      subject.onNext(a);
      subject.onCompleted();
    }, function(e) {
      subject.onError(e);
    });
    return subject;
  };
}
