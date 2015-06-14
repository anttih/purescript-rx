'use strict';

var gulp = require('gulp');
var purescript = require('gulp-purescript');
var jsValidate = require('gulp-jsvalidate');
var plumber = require("gulp-plumber");
var source = require('vinyl-source-stream');
var browserify = require('browserify');

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

gulp.task('pscMake', function() {
  return gulp.src(sources)
    .pipe(plumber())
    .pipe(purescript.pscMake({
      output: 'output/node_modules',
      ffi: foreigns
    }))
});

gulp.task('browserify', ['pscMake'], function() {
  var b = browserify({
    entries: './main.js',
    debug: false
  });

  return b.bundle()
    .pipe(source('bundle.js'))
    .pipe(gulp.dest('./output/'));
});

gulp.task('pscDocs', function() {
  return gulp.src(sources)
    .pipe(plumber())
    .pipe(purescript.pscDocs({
      docgen: {
        'Rx.Observable': 'docs/Rx.Observable',
      }
    }))
})

gulp.task('dotPsci', function() {
  return gulp.src(sources)
    .pipe(plumber())
    .pipe(purescript.dotPsci())
})

gulp.task('make', ['jsvalidate', 'pscMake', 'dotPsci', 'pscDocs']);
gulp.task('test', ['jsvalidate', 'browserify', 'pscDocs']);
gulp.task('default', ['make']);
