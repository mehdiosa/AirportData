
#!/bin/bash

set -eo pipefail

xcodebuild -workspace AirportDataApp.xcworkspace \
            -scheme "AirportData" \
            -destination generic/platform=iOS \
            clean test
