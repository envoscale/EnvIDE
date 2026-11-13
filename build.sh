#!/bin/sh
# Builds and tests Envo Studio with EnvoScale at the commit in envoscale.ref.
#
#   ./build.sh build   build/studio (build/studio.exe on Windows)
#   ./build.sh test    the tests in tests/
#   ./build.sh run     build, then open Studio on this folder
#
# EnvoScale comes from $ENVOSCALE if set (a checkout you work on, used as it is), else
# ./envoscale, cloned and built at envoscale.ref on first use.
set -eu

ROOT=$(cd "$(dirname "$0")" && pwd)
say() { printf '%s\n' "$*"; }
fail() { printf 'error: %s\n' "$*" >&2; exit 1; }

case "$(uname -s)" in MINGW*|MSYS*|CYGWIN*) EXE=.exe ;; *) EXE= ;; esac

toolchain() {
    if [ -n "${ENVOSCALE:-}" ]; then
        ES=$(cd "$ENVOSCALE" && pwd)
        [ -x "$ES/build/envo/envo$EXE" ] || (cd "$ES" && ./build.sh build) || fail 'building EnvoScale failed'
    else
        ES="$ROOT/envoscale"
        ref=$(tr -d '\r\n ' < "$ROOT/envoscale.ref")
        if [ ! -d "$ES/.git" ]; then
            say "clone     https://github.com/envoscale/EnvoScale -> envoscale/"
            git clone -q https://github.com/envoscale/EnvoScale "$ES" || fail 'cloning EnvoScale failed'
        fi
        if [ "$(git -C "$ES" rev-parse HEAD)" != "$ref" ]; then
            git -C "$ES" fetch -q origin || true
            git -C "$ES" -c advice.detachedHead=false checkout -q "$ref" || fail "envoscale/: cannot check out $ref"
            rm -f "$ES/build/envo/envo$EXE"
        fi
        [ -x "$ES/build/envo/envo$EXE" ] || (cd "$ES" && ./build.sh build) || fail 'building EnvoScale failed'
    fi
    ENVO="$ES/build/envo/envo$EXE"
}

case "${1:-help}" in
    build) toolchain; (cd "$ROOT" && "$ENVO" build) ;;
    test)  toolchain; (cd "$ROOT" && "$ENVO" test) ;;
    run)   toolchain; (cd "$ROOT" && "$ENVO" build) && "$ROOT/build/studio$EXE" ;;
    *)
        say 'usage: ./build.sh <build|test|run>'
        [ "${1:-help}" = help ] || exit 2 ;;
esac
