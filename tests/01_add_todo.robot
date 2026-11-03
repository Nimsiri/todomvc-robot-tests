*** Settings ***
Documentation       Add todo: creating new items from the main input.
...                 Spec: https://github.com/tastejs/todomvc/blob/master/app-spec.md#new-todo
Resource            ../resources/common.resource
Suite Setup         Start Browser Session
Suite Teardown      End Browser Session
Test Setup          Open Fresh TodoMVC Page
Test Teardown       Close Test Page
Test Tags           add


*** Test Cases ***
TC-ADD-01 Add a single todo
    [Tags]    smoke    P1
    Add Todo    ${SINGLE_TODO}
    Todo Titles Should Be    ${SINGLE_TODO}
    Items Left Counter Should Be    1 item left!

TC-ADD-02 Multiple todos are listed in the order added
    [Tags]    P1
    Add Todos    @{TODO_TITLES}
    Todo Titles Should Be    @{TODO_TITLES}
    Items Left Counter Should Be    3 items left!

TC-ADD-03 Input field is cleared after adding a todo
    [Tags]    P2
    Add Todo    ${SINGLE_TODO}
    New Todo Input Should Be Empty

TC-ADD-04 Empty input does not add a todo
    [Tags]    negative    P1
    Add Todo    ${EMPTY}
    Todo Titles Should Be
    Todo List And Footer Should Be Hidden

TC-ADD-05 Whitespace-only input does not add a todo
    [Tags]    negative    P2
    Add Todo    ${WHITESPACE_ONLY}
    Todo Titles Should Be

TC-ADD-06 Leading and trailing spaces are trimmed
    [Tags]    P2
    Add Todo    ${PADDED_TODO}
    Todo Titles Should Be    ${TRIMMED_TODO}

TC-ADD-07 Thai text, emoji and long text are displayed as entered
    [Documentation]    Data-driven: each row adds one todo and checks it is shown exactly as typed.
    [Tags]    data-driven    P2
    [Template]    Added Todo Should Be Shown Exactly As Typed
    ${THAI_TODO}
    ${EMOJI_TODO}
    ${LONG_TODO}

TC-ADD-08 HTML input is displayed as plain text, not rendered
    [Documentation]    Basic XSS check: the title must appear as plain text and the page
    ...    must not contain a real <b> element created from user input.
    [Tags]    negative    security    P2
    Add Todo    ${HTML_TODO}
    Todo Titles Should Be    ${HTML_TODO}
    Get Element Count    ${TODO_LABELS} >> css=b    ==    0

TC-ADD-09 List and footer appear after the first todo is added
    [Tags]    smoke    P1
    Todo List And Footer Should Be Hidden
    Add Todo    ${SINGLE_TODO}
    Todo List And Footer Should Be Visible

TC-ADD-10 Input field is focused on page load
    [Tags]    P3
    New Todo Input Should Be Focused


*** Keywords ***
Added Todo Should Be Shown Exactly As Typed
    [Arguments]    ${title}
    Add Todo    ${title}
    Last Todo Title Should Be    ${title}
