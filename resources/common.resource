*** Settings ***
Documentation       Shared setup and teardown used by every test suite.
Library             Browser
Variables           ../config/env.py
Variables           ../test_data/todo_data.py
Resource            pages/todo_page.resource


*** Keywords ***
Start Browser Session
    [Documentation]    Runs once per suite: one browser per suite keeps the run fast.
    ...    Chromium uses the full browser build: the default headless build
    ...    (chrome-headless-shell) crashes on macOS with "GPU process isn't usable".
    IF    $BROWSER == "chromium"
        New Browser    ${BROWSER}    headless=${HEADLESS}    slowMo=${SLOW_MO}    channel=chromium
    ELSE
        New Browser    ${BROWSER}    headless=${HEADLESS}    slowMo=${SLOW_MO}
    END
    Set Browser Timeout    ${TIMEOUT}

Open Fresh TodoMVC Page
    [Documentation]    Runs before every test. A new browser context means a clean state
    ...    (no shared storage or cookies), so no test depends on another test.
    New Context
    Open TodoMVC App

Close Test Page
    Close Context

End Browser Session
    Close Browser    ALL
