"""Default settings for a test run.

Any value can be overridden from the command line without editing this file:
    robot --argumentfile robot.args --variable BROWSER:firefox --variable HEADLESS:False tests
"""

# Application under test
BASE_URL = "https://todomvc.com/examples/react/dist/"

# Browser engine: chromium | firefox | webkit
BROWSER = "chromium"

# True = run without showing a browser window (used in CI).
# Set to False when you want to watch the test run.
HEADLESS = True

# Pause after every browser action so a headed run is easy to watch.
# "0s" = full speed. Example: --variable HEADLESS:False --variable SLOW_MO:0.5s
SLOW_MO = "0s"

# How long Browser library waits for an element or an assertion before failing.
TIMEOUT = "10s"
