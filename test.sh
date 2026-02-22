#!/usr/bin/env bash
set -euo pipefail

echo "Running OutputTracking tests..."
swift test

echo "Running ExampleApp tests..."
cd ExampleApp
swift test

echo "All tests passed!"
