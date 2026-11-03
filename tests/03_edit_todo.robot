*** Settings ***
Documentation       Edit todo: double-click to edit, save with Enter or blur, cancel with Escape.
...                 Spec: https://github.com/tastejs/todomvc/blob/master/app-spec.md#editing
Resource            ../resources/common.resource
Suite Setup         Start Browser Session
Suite Teardown      End Browser Session
Test Setup          Open Fresh TodoMVC Page
Test Teardown       Close Test Page
Test Tags           edit


*** Test Cases ***
TC-EDT-01 Double-click enters edit mode with the current text
    [Tags]    smoke    P1
    Add Todo    ${SINGLE_TODO}
    Start Editing Todo    0
    Edit Input Should Contain    ${SINGLE_TODO}
    Toggle Of Todo Should Be Hidden    0

TC-EDT-02 Pressing Enter saves the edit without changing other todos
    [Tags]    smoke    P1
    Add Todos    @{TODO_TITLES}
    Edit Todo    1    ${EDITED_TODO}
    Todo Should Not Be In Edit Mode
    Todo Titles Should Be    ${TODO_TITLES}[0]    ${EDITED_TODO}    ${TODO_TITLES}[2]

TC-EDT-03 Clicking outside the field saves the edit
    [Tags]    P1
    Add Todo    ${SINGLE_TODO}
    Start Editing Todo    0
    Type In Edit Input    ${EDITED_TODO}
    Click Outside Todo List
    Todo Should Not Be In Edit Mode
    Todo Titles Should Be    ${EDITED_TODO}

TC-EDT-04 Leading and trailing spaces are trimmed on edit
    [Tags]    P2
    Add Todo    ${SINGLE_TODO}
    Edit Todo    0    ${PADDED_TODO}
    Todo Titles Should Be    ${TRIMMED_TODO}

TC-EDT-05 Saving an empty edit deletes the todo
    [Tags]    negative    P2
    Add Todos    ${TODO_TITLES}[0]    ${TODO_TITLES}[1]
    Edit Todo    0    ${EMPTY}
    Todo Titles Should Be    ${TODO_TITLES}[1]
    Items Left Counter Should Be    1 item left!

TC-EDT-06 Esc cancels the edit and restores the original text
    [Documentation]    Spec: Escape must leave edit mode and discard the change.
    ...    KNOWN ISSUE BUG-01: the React app has no Escape handler, so the todo stays
    ...    in edit mode. Reported as SKIP (see --skiponfailure in robot.args).
    [Tags]    known-issue    P2
    Add Todo    ${SINGLE_TODO}
    Start Editing Todo    0
    Type In Edit Input    ${EDITED_TODO}
    Keyboard Key    press    Escape
    Todo Should Not Be In Edit Mode
    Todo Titles Should Be    ${SINGLE_TODO}
