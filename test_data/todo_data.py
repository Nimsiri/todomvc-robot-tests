"""Test data, kept apart from test logic so it can change without touching any test."""

TODO_TITLES = ["Buy groceries", "Read a book", "Pay electricity bill"]

SINGLE_TODO = "Buy groceries"
EDITED_TODO = "Buy groceries and fruit"

# Input with spaces around it -> the app should trim it
PADDED_TODO = "   Walk the dog   "
TRIMMED_TODO = "Walk the dog"

WHITESPACE_ONLY = "     "

# Special input (data-driven test TC-ADD-07)
THAI_TODO = "ซื้อของเข้าบ้าน"
EMOJI_TODO = "Go jogging 🏃"
LONG_TODO = "Long todo " + "x" * 240  # 250 characters

# User input that looks like HTML must be shown as text, never rendered (TC-ADD-08)
HTML_TODO = "<b>not bold</b> & <i>not italic</i>"
