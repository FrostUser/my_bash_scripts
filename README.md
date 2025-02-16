# my_bash_scripts

`from_clipboard` scripts uses pyperclip library (BSD license):
https://pypi.python.org/pypi/pyperclip

## Quick tab search with rofi + brotab

The code itself is in [./select_window_or_tab.sh](./select_window_or_tab.sh).

I have set up rofi + brotab to quickly search through firefox/chrome tabs and gnome-terminal tabs. 

Example for setting this up with i3 (in ~/.config/i3/config):
```
bindsym $mod+i exec rofi -matching normal -show-icons -show tabs\
                         -modes "tabs:$HOME/.scripts/select_window_or_tab.sh"
```

Based on the ideas from:
https://adrianpopagh.blogspot.com/2020/12/quick-launcher-with-firefox-tabs-rofi.html

(brotab requires Firefox/Chromium extension, there are alternatives to that)
(as a very simple alternative, use get_firefox_tabs.py)

### Notes

After the system updates, it is likely that brotab will stop working and the 
list of tabs will not be displayed.
The error log can be seen when starting `bt_mediator`. See [here](https://github.com/balta2ar/brotab/issues/43#issuecomment-1886621323)

To fix this problem, basically run `pip uninstall werkzeug && pip install werkzeug==2` .

Last time, I had to run this command to recover brotab:
```bash
pip install --user --break-system-packages brotab
```

