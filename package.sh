#!/usr/bin/env bash
# Baut dist/Mahonemotes-<Version>.zip mit nur den Addon-Dateien.
set -euo pipefail
cd "$(dirname "$0")"
version=$(sed -n 's/^## Version: *//p' Mahonemotes.toc | tr -d '\r')
lua5.1 tests/spiral_test.lua
stage=$(mktemp -d)
trap 'rm -rf "$stage"' EXIT
mkdir "$stage/Mahonemotes"
cp Mahonemotes.toc Bindings.xml *.lua LICENSE "$stage/Mahonemotes/"
mkdir -p dist
rm -f "dist/Mahonemotes-$version.zip"
(cd "$stage" && zip -qr - Mahonemotes) > "dist/Mahonemotes-$version.zip"
echo "dist/Mahonemotes-$version.zip"
