*** Settings ***
Documentation       Filters: All / Active / Completed links and their URLs.
...                 Every test starts with 3 todos where the 2nd one is completed.
...                 Spec: https://github.com/tastejs/todomvc/blob/master/app-spec.md#routing
Resource            ../resources/common.resource
Suite Setup         Start Browser Session
Suite Teardown      End Browser Session
Test Setup          Open Page With Active And Completed Todos
Test Teardown       Close Test Page
Test Tags           filter


*** Test Cases ***
TC-FLT-01 Active filter shows only active todos
    [Tags]    smoke    P1
    Select Filter    Active
    Todo Titles Should Be    ${TODO_TITLES}[0]    ${TODO_TITLES}[2]

TC-FLT-02 Completed filter shows only completed todos
    [Tags]    smoke    P1
    Select Filter    Completed
    Todo Titles Should Be    ${TODO_TITLES}[1]

TC-FLT-03 Switching back to All shows every todo
    [Tags]    P1
    Select Filter    Completed
    Select Filter    All
    Todo Titles Should Be    @{TODO_TITLES}

TC-FLT-04 Selected filter is highlighted and the URL updates
    [Documentation]    Data-driven: filter name -> expected URL ending.
    [Tags]    data-driven    P2
    [Template]    Selecting A Filter Should Highlight It And Update The URL
    Active       \#/active
    Completed    \#/completed
    All          \#/

TC-FLT-05 Browser Back returns to the previous filter
    [Tags]    P2
    Select Filter    Active
    Select Filter    Completed
    Go Back
    Filter Should Be Selected    Active    \#/active
    Todo Titles Should Be    ${TODO_TITLES}[0]    ${TODO_TITLES}[2]

TC-FLT-06 Completing a todo on the Active filter removes it from view
    [Tags]    P2
    Select Filter    Active
    Toggle Todo    0
    Todo Titles Should Be    ${TODO_TITLES}[2]
    Items Left Counter Should Be    1 item left!

TC-FLT-07 Opening a filter URL directly selects that filter
    [Tags]    P3
    Open Filter URL Directly    \#/completed
    Filter Should Be Selected    Completed    \#/completed
    Todo Titles Should Be    ${TODO_TITLES}[1]

TC-FLT-08 Toggle all on the Active filter completes every todo
    [Documentation]    Completed todos leave the Active view, so the list looks collapsed.
    ...    The All view must show every todo as completed.
    [Tags]    P2
    Select Filter    Active
    Toggle All Todos
    Todo Titles Should Be
    Items Left Counter Should Be    0 items left!
    Select Filter    All
    Completed Todo Count Should Be    3

TC-FLT-09 Toggle all on the Active filter is checked and can be undone
    [Documentation]    Spec: toggle all is checked when ALL todos are completed, whatever the filter.
    ...    KNOWN ISSUE BUG-03: the app checks only the visible todos, so after toggle all
    ...    the Active view shows it unchecked and a second click does nothing.
    ...    Reported as SKIP (see --skiponfailure in robot.args).
    [Tags]    known-issue    P2
    Select Filter    Active
    Toggle All Todos
    Toggle All Should Be Checked
    Toggle All Todos
    Todo Titles Should Be    @{TODO_TITLES}
    Items Left Counter Should Be    3 items left!


*** Keywords ***
Open Page With Active And Completed Todos
    Open Fresh TodoMVC Page
    Add Todos    @{TODO_TITLES}
    Toggle Todo    1

Selecting A Filter Should Highlight It And Update The URL
    [Arguments]    ${filter_name}    ${url_hash}
    Select Filter    ${filter_name}
    Filter Should Be Selected    ${filter_name}    ${url_hash}
