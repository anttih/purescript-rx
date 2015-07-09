'use strict';

var gulp = require('gulp');
var purescript = require('gulp-purescript');
var jsValidate = require('gulp-jsvalidate');
var plumber = require("gulp-plumber");

var sources = [
  'src/**/*.purs',
  'examples/Examples.purs',
  'bower_components/purescript-*/src/**/*.purs'
];

var foreigns = [
  'src/**/*.js',
  'bower_components/purescript-*/src/**/*.js'
];

gulp.task('jsvalidate', function () {
  return gulp.src(foreigns)
    .pipe(plumber())
    .pipe(jsValidate());
});

gulp.task('psc', function() {
  return purescript.psc({
    src: sources,
    ffi: foreigns,
    output: 'output/node_modules'
  })
});

gulp.task('pscBundle', ['psc'], function() {
  return purescript.pscBundle({
    src: "output/node_modules/**/*.js",
    output: "output/bundle.js",
    main: 'Examples'
  })
});

gulp.task('pscDocs', function() {
  return purescript.pscDocs({
      src: sources,
      docgen: {
        'Rx.Observable': 'docs/Rx.Observable.md',
        'Rx.Observable.Aff': 'docs/Rx.Observable.Aff.md',
        'Rx.Observable.Cont': 'docs/Rx.Observable.Cont.md',
        'Rx.Notification': 'docs/Rx.Notification.md'
      }
    })
})

gulp.task('ctags', function() {
  return purescript.pscDocs({
      src: sources,
      format: 'ctags',
      docgen: [
        'Rx.Observable',
        'Rx.Observable.Aff',
        'Rx.Observable.Cont',
        'Rx.Notification'
      ]
    })
    .pipe(gulp.dest('tags'))
})

gulp.task('dotPsci', function() {
  return purescript.psci({
      src: sources
    })
})

gulp.task('make', ['jsvalidate', 'psc', 'dotPsci', 'pscDocs', 'ctags']);
gulp.task('test', ['jsvalidate', 'pscBundle', 'pscDocs']);
gulp.task('default', ['make']);
