#!/bin/sh
# Lists local <link href>/<script src> that are not root-absolute.
out=$(for f in index.html resume.html 404.html; do
  grep -noE '<(link|script)[^>]*(href|src)="[^"]*"' "$f" | grep -vE '(href|src)="(/[^/]|https?://|//)' | sed "s|^|$f:|"
done)
[ -n "$out" ] && { echo "$out"; echo FAIL; exit 1; }
echo OK
