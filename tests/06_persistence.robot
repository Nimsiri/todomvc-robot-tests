*** Settings ***
Documentation       Persistence: todos should survive a page reload.
...                 Spec: https://github.com/tastejs/todomvc/blob/master/app-spec.md#persistence
Resource            ../resources/common.resource
Suite Setup         Start Browser Session
Suite Teardown      End Browser Session
Test Setup          Open Fresh TodoMVC Page
Test Teardown       Close Test Page
Test Tags           persistence


*** Test Cases ***
TC-PER-01 Todos and their status persist after page reload
    [Documentation]    Spec: the app must save todos to localStorage.
    ...    KNOWN ISSUE BUG-02: the React example keeps todos in memory only,
    ...    so a reload loses everything. Reported as SKIP (see --skiponfailure in robot.args).
    [Tags]    known-issue    P2
    Add Todos    @{TODO_TITLES}
    Toggle Todo    1
    Reload
    Todo Titles Should Be    @{TODO_TITLES}
    Todo Should Be Completed    1
