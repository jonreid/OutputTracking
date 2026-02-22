#!/usr/bin/env bash
set -euo pipefail


TMP_OUTPUT=$(mktemp)

echo -n "Running OutputTracking tests… "
if script -q /dev/null swift test  > "$TMP_OUTPUT" 2>&1; then
  echo "passed."
else
  echo ""
  cat "$TMP_OUTPUT"
  echo "❌ OutputTracking tests failed."
  rm "$TMP_OUTPUT"
  exit 1
fi

echo -n "Running ExampleApp tests… "
if cd ExampleApp && script -q /dev/null swift test  > "$TMP_OUTPUT" 2>&1; then
  echo "passed."
else
  echo ""
  cat "$TMP_OUTPUT"
  echo "❌ ExampleApp tests failed."
  rm "$TMP_OUTPUT"
  exit 1
fi

rm "$TMP_OUTPUT"
echo "✅ All tests passed"
