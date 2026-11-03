# TodoMVC UI Automation: Robot Framework

Automated UI tests สำหรับ [React TodoMVC](https://todomvc.com/examples/react/dist/) เขียนด้วย Robot Framework และ Browser library

## Library ที่ต้องติดตั้ง

ต้องมี Python 3.11 ขึ้นไป

| Library | เวอร์ชัน | ใช้ทำอะไร |
|---|---|---|
| `robotframework` | 7.3 ขึ้นไป (ต่ำกว่า 8) | ตัวรัน test |
| `robotframework-browser[bb]` | 21.x | ขับ browser ผ่าน Playwright |
| `robotframework-browser-batteries` | 21.x | มี Node.js และ Playwright มาในตัว ไม่ต้องลง Node.js เอง |
| Chromium | - | browser ที่ใช้รัน test ติดตั้งผ่าน `rfbrowser` |

## ติดตั้ง

```bash
python3 -m venv .venv
source .venv/bin/activate        # Windows: .venv\Scripts\Activate.ps1
pip install -r requirements.txt
rfbrowser install chromium
```


## Run ทดสอบแบบไม่เปิด Browser
```
cd ~/Desktop/todomvc-robot-tests
source .venv/bin/activate
robot --argumentfile robot.args tests
```
## Run ทดสอบแบบเปิด Browser
```
robot --argumentfile robot.args --variable HEADLESS:False --variable SLOW_MO:0.5s tests
```
`SLOW_MO` หน่วงเวลาทุก action ให้ดูทัน ปรับได้ เช่น `1s` ถ้าใส่ `0s` จะรันเร็วปกติ

## ดูผลการรัน

ผลอยู่ในโฟลเดอร์ `results/`
- `report.html` สรุปผล pass/fail
- `log.html` รายละเอียดทีละ step

```bash
open results/report.html
```


