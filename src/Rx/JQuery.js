/* global exports */
"use strict";

// module Rx.JQuery

exports.liveAsObservable = function (evt) {
  return function(sel) {
    return function(ob) {
      return function() {
        return ob.onAsObservable(evt, sel);
      };
    };
  };
}

exports.onAsObservable = function (evt) {
  return function(ob) {
    return function() {
      return ob.onAsObservable(evt);
    };
  };
}
