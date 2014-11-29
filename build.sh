#!/bin/zsh

set -e

if [ "$#" -eq 0 ]; then cmd=help; else cmd=$1; fi

purs_files () {
  find -L bower_components src \
    -name "*.purs" \
    ! -path '*/examples/*' \
    ! -path '*/tests/*'
}

case "$cmd" in
  psc)
    purs_files | xargs psc -m Combinators --main Combinators \
      --output examples/combinators.js \
      examples/Combinators.purs
  ;;
  psc-make)
    purs_files | xargs psc-make
  ;;
  psc-docs)
    psc-docs src/Rx/Observable.purs src/Rx/JQuery.purs > README.md
  ;;
  dot-psci)
    purs_files | sed 's/^/:m /' > .psci
  ;;
  help)
    cat >&2 <<USAGE
Usage: ./build.sh <task>

Available tasks:

    psc-make         Compile .purs sources to CommonJS modules
    dot-psci         Add modules to .psci
    help             Show usage
USAGE
esac
