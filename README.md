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

## ติดตั้ง (ทำครั้งแรกครั้งเดียว)

```bash
git clone https://github.com/Nimsiri/todomvc-robot-tests.git
cd todomvc-robot-tests
python3 -m venv .venv           
source .venv/bin/activate        # Windows: .venv\Scripts\Activate.ps1
pip install -r requirements.txt
rfbrowser install chromium
```

## Run ทดสอบแบบไม่เปิด Browser
```bash
source .venv/bin/activate        # ทำทุกครั้งที่เปิด terminal ใหม่
robot --argumentfile robot.args tests
```