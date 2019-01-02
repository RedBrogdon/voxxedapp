set -e

echo "== Testing voxxedapp on Flutter's $FLUTTER_VERSION channel =="

# Run the analyzer to find any static analysis issues.
flutter/bin/flutter analyze

# Run the formatter on all the dart files to make sure everything's linted.
find . | grep "\.dart$" | xargs flutter/bin/flutter format -n

# Run the actual tests.
flutter/bin/flutter test

echo "-- Success --"
