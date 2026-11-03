# Test Cases: TodoMVC (React)

- **ระบบที่ทดสอบ:** https://todomvc.com/examples/react/dist/
- **Requirement:** [TodoMVC App Specification](https://github.com/tastejs/todomvc/blob/master/app-spec.md)
- **จำนวน:** 38 test cases ใน 6 suites (P1 16 / P2 18 / P3 4, smoke 9 cases)
- **Priority:** P1 = flow หลัก, P2 = รายละเอียดและ edge case, P3 = ความสวยงามและความสะดวก

## 1. Add todo (`tests/01_add_todo.robot`)

| ID | Test case | ขั้นตอน | ผลที่คาดหวัง | Priority |
|---|---|---|---|---|
| TC-ADD-01 | Add a single todo | พิมพ์ "Buy groceries" แล้วกด Enter | มี 1 รายการ, ตัวนับแสดง `1 item left!` | P1 smoke |
| TC-ADD-02 | Multiple todos are listed in the order added | เพิ่ม 3 รายการ | แสดงครบตามลำดับที่เพิ่ม, ตัวนับแสดง `3 items left!` | P1 |
| TC-ADD-03 | Input field is cleared after adding a todo | เพิ่ม 1 รายการ | ช่อง input ว่าง พร้อมพิมพ์รายการต่อไป | P2 |
| TC-ADD-04 | Empty input does not add a todo | กด Enter ตอนช่องว่าง | ไม่มีรายการ, list และ footer ยังซ่อนอยู่ | P1 negative |
| TC-ADD-05 | Whitespace-only input does not add a todo | พิมพ์ช่องว่างล้วนแล้วกด Enter | ไม่มีรายการ | P2 negative |
| TC-ADD-06 | Leading and trailing spaces are trimmed | พิมพ์ "␣␣␣Walk the dog␣␣␣" | บันทึกเป็น "Walk the dog" | P2 |
| TC-ADD-07 | Thai text, emoji and long text are displayed as entered | data-driven: ภาษาไทย / emoji / 250 ตัวอักษร | แสดงตรงตามที่พิมพ์ทุกตัวอักษร | P2 |
| TC-ADD-08 | HTML input is displayed as plain text, not rendered | พิมพ์ `<b>not bold</b> & <i>not italic</i>` | แสดงเป็นข้อความตามที่พิมพ์ ไม่มี element `<b>` เกิดขึ้น | P2 security |
| TC-ADD-09 | List and footer appear after the first todo is added | เปิดหน้าใหม่แล้วเพิ่ม 1 รายการ | ก่อนเพิ่มต้องซ่อน หลังเพิ่มต้องแสดง | P1 smoke |
| TC-ADD-10 | Input field is focused on page load | เปิดหน้า | ช่อง input ได้ focus ทันที | P3 |

## 2. Complete todo (`tests/02_complete_todo.robot`)

| ID | Test case | ขั้นตอน | ผลที่คาดหวัง | Priority |
|---|---|---|---|---|
| TC-CMP-01 | Mark a todo as completed | ติ๊ก checkbox | checkbox ถูกติ๊ก, มีขีดฆ่า (class `completed`), ตัวนับแสดง `0 items left!` | P1 smoke |
| TC-CMP-02 | Unchecking a completed todo returns it to active | ติ๊กแล้วเอาติ๊กออก | กลับเป็น active, ตัวนับแสดง `1 item left!` | P1 |
| TC-CMP-03 | Completing one todo does not affect the others | มี 3 รายการ ติ๊กรายการที่ 2 | เฉพาะรายการที่ 2 เปลี่ยนสถานะ | P1 |
| TC-CMP-04 | Item counter uses correct singular and plural forms | 2 → 1 → 0 รายการ active | `2 items left!` → `1 item left!` → `0 items left!` | P2 boundary |
| TC-CMP-05 | Toggle all marks every todo as completed | กด toggle all | ทุกรายการ completed, toggle all ถูกติ๊ก | P1 |
| TC-CMP-06 | Clicking toggle all twice reverts every todo to active | กด toggle all 2 ครั้ง | ทุกรายการกลับเป็น active | P2 |
| TC-CMP-07 | Completing every todo individually checks toggle all | ติ๊กทีละรายการจนครบ | toggle all ถูกติ๊กอัตโนมัติ | P3 |

## 3. Edit todo (`tests/03_edit_todo.robot`)

| ID | Test case | ขั้นตอน | ผลที่คาดหวัง | Priority |
|---|---|---|---|---|
| TC-EDT-01 | Double-click enters edit mode with the current text | ดับเบิลคลิกที่ข้อความ | ช่องแก้ไขมีข้อความเดิม, checkbox ถูกซ่อน | P1 smoke |
| TC-EDT-02 | Pressing Enter saves the edit without changing other todos | แก้รายการที่ 2 แล้วกด Enter | รายการที่ 2 เปลี่ยน, รายการอื่นไม่เปลี่ยน, ออกจากโหมดแก้ไข | P1 smoke |
| TC-EDT-03 | Clicking outside the field saves the edit | แก้แล้วคลิกที่อื่น (blur) | บันทึกข้อความใหม่ | P1 |
| TC-EDT-04 | Leading and trailing spaces are trimmed on edit | แก้เป็นข้อความที่มีช่องว่างหน้า-หลัง | บันทึกแบบตัดช่องว่างแล้ว | P2 |
| TC-EDT-05 | Saving an empty edit deletes the todo | ลบข้อความจนว่างแล้วกด Enter | รายการนั้นถูกลบ | P2 negative |
| TC-EDT-06 | Esc cancels the edit and restores the original text | แก้แล้วกด Esc | ออกจากโหมดแก้ไขและได้ข้อความเดิมกลับมา (**ไม่ผ่าน BUG-01:** กด Esc แล้วยังค้างในโหมดแก้ไข) | P2 known-issue |

## 4. Delete todo (`tests/04_delete_todo.robot`)

| ID | Test case | ขั้นตอน | ผลที่คาดหวัง | Priority |
|---|---|---|---|---|
| TC-DEL-01 | Delete a todo with the × button | hover รายการที่ 2 แล้วกด × | เหลือรายการที่ 1 และ 3, ตัวนับลดลง | P1 smoke |
| TC-DEL-02 | Delete (×) button is visible only on hover | ดูปุ่ม × ก่อนและหลัง hover | ซ่อนก่อน hover และแสดงเมื่อ hover | P3 |
| TC-DEL-03 | Deleting the last todo hides the list and footer | ลบรายการสุดท้าย | list และ footer ถูกซ่อน | P2 |
| TC-DEL-04 | Clear completed removes only completed todos | ติ๊ก 2 จาก 3 รายการแล้วกด Clear completed | เหลือเฉพาะรายการ active | P1 smoke |
| TC-DEL-05 | Clear completed button is shown only when completed todos exist | ติ๊กแล้วเอาติ๊กออก | ปุ่มแสดงเฉพาะตอนมีรายการ completed | P2 |

## 5. Filter (`tests/05_filter_todo.robot`)

Precondition: มี 3 รายการ โดยรายการที่ 2 completed แล้ว

| ID | Test case | ขั้นตอน | ผลที่คาดหวัง | Priority |
|---|---|---|---|---|
| TC-FLT-01 | Active filter shows only active todos | กด Active | เห็นรายการที่ 1 และ 3 | P1 smoke |
| TC-FLT-02 | Completed filter shows only completed todos | กด Completed | เห็นรายการที่ 2 | P1 smoke |
| TC-FLT-03 | Switching back to All shows every todo | กด Completed แล้วกด All | เห็นครบ 3 รายการ | P1 |
| TC-FLT-04 | Selected filter is highlighted and the URL updates | data-driven: Active / Completed / All | ลิงก์ที่เลือกถูกไฮไลต์ และ URL ลงท้ายด้วย `#/active`, `#/completed`, `#/` | P2 |
| TC-FLT-05 | Browser Back returns to the previous filter | Active → Completed → กด Back | กลับไป Active พร้อมรายการที่ถูกต้อง | P2 |
| TC-FLT-06 | Completing a todo on the Active filter removes it from view | อยู่หน้า Active แล้วติ๊กรายการ | รายการนั้นหายไปจากหน้า Active ทันที | P2 |
| TC-FLT-07 | Opening a filter URL directly selects that filter | เข้า URL `#/completed` ตรงๆ | filter Completed ถูกเลือก และแสดงรายการที่ถูกต้อง | P3 |
| TC-FLT-08 | Toggle all on the Active filter completes every todo | อยู่หน้า Active แล้วกด toggle all | รายการหายจากหน้า Active, `0 items left!`, หน้า All แสดงทุกรายการเป็น completed | P2 |
| TC-FLT-09 | Toggle all on the Active filter is checked and can be undone | อยู่หน้า Active กด toggle all แล้วกดซ้ำ | หลังกดครั้งแรก toggle all ถูกติ๊ก, กดซ้ำแล้วทุกรายการกลับเป็น active (**ไม่ผ่าน BUG-03:** toggle all ดูเฉพาะรายการที่มองเห็น จึงไม่ติ๊กและกดซ้ำไม่มีผล) | P2 known-issue |

## 6. Persistence (`tests/06_persistence.robot`)

| ID | Test case | ขั้นตอน | ผลที่คาดหวัง | Priority |
|---|---|---|---|---|
| TC-PER-01 | Todos and their status persist after page reload | เพิ่ม 3 รายการ ติ๊ก 1 รายการ แล้ว reload | ข้อมูลและสถานะยังอยู่ครบ (**ไม่ผ่าน BUG-02:** reload แล้วรายการหายหมด เพราะไม่ได้เก็บใน localStorage) | P2 known-issue |
