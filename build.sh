#!/bin/sh
# Builds and tests EnvIDE with EnvoScale at the commit in envolang.ref.
#
#   ./build.sh build   build/envide (build/envide.exe on Windows)
#   ./build.sh test    the tests in tests/
#   ./build.sh run     build, then open EnvIDE on this folder
#
# EnvoScale comes from $ENVOLANG if set (a checkout you work on, used as it is), else
# ./envolang, cloned and built at envolang.ref on first use.
set -eu

ROOT=$(cd "$(dirname "$0")" && pwd)
say() { printf '%s\n' "$*"; }
fail() { printf 'error: %s\n' "$*" >&2; exit 1; }

case "$(uname -s)" in MINGW*|MSYS*|CYGWIN*) EXE=.exe ;; *) EXE= ;; esac

toolchain() {
    if [ -n "${ENVOLANG:-}" ]; then
        ES=$(cd "$ENVOLANG" && pwd)
        [ -x "$ES/build/envo/envo$EXE" ] || (cd "$ES" && ./build.sh build) || fail 'building EnvoLang failed'
    else
        ES="$ROOT/envolang"
        ref=$(tr -d '\r\n ' < "$ROOT/envolang.ref")
        if [ ! -d "$ES/.git" ]; then
            say "clone     https://github.com/envoscale/EnvoLang -> envolang/"
            git clone -q https://github.com/envoscale/EnvoLang "$ES" || fail 'cloning EnvoLang failed'
        fi
        if [ "$(git -C "$ES" rev-parse HEAD)" != "$ref" ]; then
            git -C "$ES" fetch -q origin || true
            git -C "$ES" -c advice.detachedHead=false checkout -q "$ref" || fail "envolang/: cannot check out $ref"
            rm -f "$ES/build/envo/envo$EXE"
        fi
        [ -x "$ES/build/envo/envo$EXE" ] || (cd "$ES" && ./build.sh build) || fail 'building EnvoLang failed'
    fi
    ENVO="$ES/build/envo/envo$EXE"
}

case "${1:-help}" in
    build) toolchain; (cd "$ROOT" && "$ENVO" build) ;;
    test)  toolchain; (cd "$ROOT" && "$ENVO" test) ;;
    run)   toolchain; (cd "$ROOT" && "$ENVO" build) && "$ROOT/build/envide$EXE" ;;
    *)
        say 'usage: ./build.sh <build|test|run>'
        [ "${1:-help}" = help ] || exit 2 ;;
esac
