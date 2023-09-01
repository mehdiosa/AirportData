
#!/bin/bash

set -eo pipefail

xcodebuild -workspace AirportDataApp.xcworkspace \
            -scheme AirportData\
            -destination platform=iOS\ Simulator,OS=16.2,name=iPhone\ 14 \
            clean test
            