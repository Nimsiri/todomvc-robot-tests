*** Settings ***
Documentation       Delete todo: the × button and "Clear completed".
...                 Spec: https://github.com/tastejs/todomvc/blob/master/app-spec.md#clear-completed-button
Resource            ../resources/common.resource
Suite Setup         Start Browser Session
Suite Teardown      End Browser Session
Test Setup          Open Fresh TodoMVC Page
Test Teardown       Close Test Page
Test Tags           delete


*** Test Cases ***
TC-DEL-01 Delete a todo with the × button
    [Tags]    smoke    P1
    Add Todos    @{TODO_TITLES}
    Delete Todo    1
    Todo Titles Should Be    ${TODO_TITLES}[0]    ${TODO_TITLES}[2]
    Items Left Counter Should Be    2 items left!

TC-DEL-02 Delete (×) button is visible only on hover
    [Tags]    P3
    Add Todo    ${SINGLE_TODO}
    Delete Button Of Todo Should Be Hidden    0
    Hover Over Todo    0
    Delete Button Of Todo Should Be Visible    0

TC-DEL-03 Deleting the last todo hides the list and footer
    [Tags]    P2
    Add Todo    ${SINGLE_TODO}
    Delete Todo    0
    Todo Titles Should Be
    Todo List And Footer Should Be Hidden

TC-DEL-04 Clear completed removes only completed todos
    [Tags]    smoke    P1
    Add Todos    @{TODO_TITLES}
    Toggle Todo    0
    Toggle Todo    2
    Clear Completed Todos
    Todo Titles Should Be    ${TODO_TITLES}[1]
    Items Left Counter Should Be    1 item left!

TC-DEL-05 Clear completed button is shown only when completed todos exist
    [Tags]    P2
    Add Todo    ${SINGLE_TODO}
    Clear Completed Button Should Be Hidden
    Toggle Todo    0
    Clear Completed Button Should Be Visible
    Toggle Todo    0
    Clear Completed Button Should Be Hidden
