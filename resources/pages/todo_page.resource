*** Settings ***
Documentation       Page Object for the TodoMVC React app.
...                 Every locator and every UI action for the page lives in this file.
...                 When the UI changes, update this file only; the tests stay the same.
Library             Browser


*** Variables ***
${NEW_TODO_INPUT}           css=input.new-todo
${TODO_ITEMS}               css=[data-testid="todo-list"] > li
${TODO_LABELS}              css=[data-testid="todo-item-label"]
${TODO_TOGGLE}              css=[data-testid="todo-item-toggle"]
${TODO_DELETE_BUTTON}       css=[data-testid="todo-item-button"]
${EDIT_INPUT}               css=li.editing input.edit
${TOGGLE_ALL}               id=toggle-all
${ITEMS_LEFT_COUNTER}       css=.todo-count
${FILTERS}                  css=[data-testid="footer-navigation"]
${CLEAR_COMPLETED}          css=button.clear-completed
${MAIN_SECTION}             css=[data-testid="main"]
${FOOTER}                   css=[data-testid="footer"]
${APP_TITLE}                css=.header h1


*** Keywords ***
# ============================== Navigation ==============================

Open TodoMVC App
    [Documentation]    Open the app and wait until the new-todo input is ready to use.
    New Page    ${BASE_URL}
    Wait For Elements State    ${NEW_TODO_INPUT}    visible

Open Filter URL Directly
    [Documentation]    Type a filter URL into the address bar, e.g. ``#/completed``.
    [Arguments]    ${hash}
    Go To    ${BASE_URL}${hash}

# ============================== Locator helpers ==============================

Todo Item At
    [Documentation]    Locator of the todo at ``index`` in the visible list (0 = first, -1 = last).
    [Arguments]    ${index}
    RETURN    ${TODO_ITEMS} >> nth=${index}

# ============================== Actions ==============================

Add Todo
    [Documentation]    Type a title into the main input and press Enter.
    [Arguments]    ${title}
    Fill Text    ${NEW_TODO_INPUT}    ${title}
    Keyboard Key    press    Enter

Add Todos
    [Arguments]    @{titles}
    FOR    ${title}    IN    @{titles}
        Add Todo    ${title}
    END

Toggle Todo
    [Documentation]    Click the checkbox of one todo (active <-> completed).
    [Arguments]    ${index}
    ${item}=    Todo Item At    ${index}
    Click    ${item} >> ${TODO_TOGGLE}

Toggle All Todos
    Click    ${TOGGLE_ALL}

Start Editing Todo
    [Documentation]    Double-click the todo text to switch it to edit mode.
    [Arguments]    ${index}
    ${item}=    Todo Item At    ${index}
    Click With Options    ${item} >> ${TODO_LABELS}    clickCount=2
    Wait For Elements State    ${EDIT_INPUT}    visible

Type In Edit Input
    [Documentation]    Replace the text in the open edit box (without confirming).
    [Arguments]    ${new_title}
    Fill Text    ${EDIT_INPUT}    ${new_title}

Edit Todo
    [Documentation]    Double-click a todo, replace its text and confirm with Enter.
    [Arguments]    ${index}    ${new_title}
    Start Editing Todo    ${index}
    Type In Edit Input    ${new_title}
    Keyboard Key    press    Enter

Click Outside Todo List
    [Documentation]    Click somewhere neutral so the focused input loses focus (blur).
    Click    ${APP_TITLE}

Delete Todo
    [Documentation]    The × button only appears on hover, so hover first like a real user.
    [Arguments]    ${index}
    ${item}=    Todo Item At    ${index}
    Hover    ${item}
    Click    ${item} >> ${TODO_DELETE_BUTTON}

Clear Completed Todos
    Click    ${CLEAR_COMPLETED}

Select Filter
    [Documentation]    Click a filter link in the footer: All, Active or Completed.
    [Arguments]    ${filter_name}
    Click    ${FILTERS} >> text="${filter_name}"

# ============================== Checks ==============================

Todo Titles Should Be
    [Documentation]    The visible todo titles, in order, must equal the expected titles.
    ...    No arguments = the list must be empty.
    [Arguments]    @{expected_titles}
    ${expected_count}=    Get Length    ${expected_titles}
    Get Element Count    ${TODO_ITEMS}    ==    ${expected_count}
    IF    ${expected_count} > 0
        Get Text    ${TODO_LABELS}    ==    ${expected_titles}    text_type=allInnerTexts
    END

Last Todo Title Should Be
    [Arguments]    ${expected_title}
    Get Text    ${TODO_LABELS} >> nth=-1    ==    ${expected_title}

Todo Should Be Completed
    [Documentation]    Checks both the checkbox and the ``completed`` style (strikethrough).
    [Arguments]    ${index}
    ${item}=    Todo Item At    ${index}
    Get Checkbox State    ${item} >> ${TODO_TOGGLE}    ==    checked
    Get Classes    ${item}    contains    completed

Todo Should Be Active
    [Arguments]    ${index}
    ${item}=    Todo Item At    ${index}
    Get Checkbox State    ${item} >> ${TODO_TOGGLE}    ==    unchecked
    Get Classes    ${item}    validate    "completed" not in value

Completed Todo Count Should Be
    [Arguments]    ${expected_count}
    Get Element Count    ${TODO_ITEMS}.completed    ==    ${expected_count}

Items Left Counter Should Be
    [Arguments]    ${expected_text}
    Get Text    ${ITEMS_LEFT_COUNTER}    ==    ${expected_text}

Toggle All Should Be Checked
    Get Checkbox State    ${TOGGLE_ALL}    ==    checked

Toggle All Should Be Unchecked
    Get Checkbox State    ${TOGGLE_ALL}    ==    unchecked

New Todo Input Should Be Empty
    Get Text    ${NEW_TODO_INPUT}    ==    ${EMPTY}

New Todo Input Should Be Focused
    Get Element States    ${NEW_TODO_INPUT}    contains    focused

Edit Input Should Contain
    [Arguments]    ${expected_text}
    Get Text    ${EDIT_INPUT}    ==    ${expected_text}

Todo Should Not Be In Edit Mode
    Get Element Count    ${EDIT_INPUT}    ==    0

Toggle Of Todo Should Be Hidden
    [Arguments]    ${index}
    ${item}=    Todo Item At    ${index}
    Wait For Elements State    ${item} >> ${TODO_TOGGLE}    hidden

Delete Button Of Todo Should Be Hidden
    [Arguments]    ${index}
    ${item}=    Todo Item At    ${index}
    Wait For Elements State    ${item} >> ${TODO_DELETE_BUTTON}    hidden

Delete Button Of Todo Should Be Visible
    [Arguments]    ${index}
    ${item}=    Todo Item At    ${index}
    Wait For Elements State    ${item} >> ${TODO_DELETE_BUTTON}    visible

Hover Over Todo
    [Arguments]    ${index}
    ${item}=    Todo Item At    ${index}
    Hover    ${item}

Todo List And Footer Should Be Hidden
    Wait For Elements State    ${MAIN_SECTION}    hidden
    Wait For Elements State    ${FOOTER}    hidden

Todo List And Footer Should Be Visible
    Wait For Elements State    ${MAIN_SECTION}    visible
    Wait For Elements State    ${FOOTER}    visible

Clear Completed Button Should Be Hidden
    Wait For Elements State    ${CLEAR_COMPLETED}    hidden

Clear Completed Button Should Be Visible
    Wait For Elements State    ${CLEAR_COMPLETED}    visible

Filter Should Be Selected
    [Documentation]    The chosen filter is highlighted and the URL ends with its route.
    [Arguments]    ${filter_name}    ${url_hash}
    Get Classes    ${FILTERS} >> text="${filter_name}"    contains    selected
    Get Url    $=    ${url_hash}
