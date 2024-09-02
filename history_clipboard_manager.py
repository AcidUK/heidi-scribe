from frontend import Gui
from clipboard_parser import get_split_sections
import pyperclip
import mouse
import time

def middle_mouse():

    clip = pyperclip.paste()
    sections = get_split_sections(clip)
    g = Gui(sections)
    g.remove_headings()
    print(g.show_gui())


mouse.on_button(callback=middle_mouse, buttons=(mouse.MIDDLE), types=(mouse.DOWN))

while 1:
    time.sleep(0.1)