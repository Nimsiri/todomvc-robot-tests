*** Settings ***
Documentation       Complete todo: marking items done / not done, one by one or all at once.
...                 Spec: https://github.com/tastejs/todomvc/blob/master/app-spec.md#mark-all-as-complete
Resource            ../resources/common.resource
Suite Setup         Start Browser Session
Suite Teardown      End Browser Session
Test Setup          Open Fresh TodoMVC Page
Test Teardown       Close Test Page
Test Tags           complete


*** Test Cases ***
TC-CMP-01 Mark a todo as completed
    [Tags]    smoke    P1
    Add Todo    ${SINGLE_TODO}
    Toggle Todo    0
    Todo Should Be Completed    0
    Items Left Counter Should Be    0 items left!

TC-CMP-02 Unchecking a completed todo returns it to active
    [Tags]    P1
    Add Todo    ${SINGLE_TODO}
    Toggle Todo    0
    Toggle Todo    0
    Todo Should Be Active    0
    Items Left Counter Should Be    1 item left!

TC-CMP-03 Completing one todo does not affect the others
    [Tags]    P1
    Add Todos    @{TODO_TITLES}
    Toggle Todo    1
    Todo Should Be Active    0
    Todo Should Be Completed    1
    Todo Should Be Active    2
    Items Left Counter Should Be    2 items left!

TC-CMP-04 Item counter uses correct singular and plural forms
    [Documentation]    Boundary values for the counter text: 2, 1 and 0 active todos.
    [Tags]    boundary    P2
    Add Todos    ${TODO_TITLES}[0]    ${TODO_TITLES}[1]
    Items Left Counter Should Be    2 items left!
    Toggle Todo    0
    Items Left Counter Should Be    1 item left!
    Toggle Todo    1
    Items Left Counter Should Be    0 items left!

TC-CMP-05 Toggle all marks every todo as completed
    [Tags]    P1
    Add Todos    @{TODO_TITLES}
    Toggle All Todos
    Completed Todo Count Should Be    3
    Toggle All Should Be Checked
    Items Left Counter Should Be    0 items left!

TC-CMP-06 Clicking toggle all twice reverts every todo to active
    [Tags]    P2
    Add Todos    @{TODO_TITLES}
    Toggle All Todos
    Toggle All Todos
    Completed Todo Count Should Be    0
    Toggle All Should Be Unchecked
    Items Left Counter Should Be    3 items left!

TC-CMP-07 Completing every todo individually checks toggle all
    [Tags]    P3
    Add Todos    ${TODO_TITLES}[0]    ${TODO_TITLES}[1]
    Toggle Todo    0
    Toggle All Should Be Unchecked
    Toggle Todo    1
    Toggle All Should Be Checked
