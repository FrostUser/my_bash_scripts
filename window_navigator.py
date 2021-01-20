#!/usr/bin/env python

# NOTE: Mostly ideas here are stolen from Quicktile.

from Xlib import display, X
import subprocess

d = display.Display(); d.sync(); root = d.screen().root

# Xlib programming manual:
#   https://tronche.com/gui/x/xlib/
# Explanation of all event masks (like X.Mod1Mask):
#   https://tronche.com/gui/x/xlib/events/keyboard-pointer/keyboard-pointer.html
# Same, but for python-xlib
#   http://python-xlib.sourceforge.net/doc/html/python-xlib_12.html#SEC11
# Reference for Display class (pending_events() is an interesting method)
#   http://python-xlib.sourceforge.net/doc/html/python-xlib_16.html#SEC15

# Use `xev` to determine keycodes
keycodes = {
    'h': 43,
    'j': 44,
    'k': 45,
    'l': 46,
  }

print('Hotkeys: Win+H, Win+J, Win+K, Win+L')

# If you prefer Alt as modifier key, replace Mod4Mask with Mod1Mask
for code in keycodes.values():
  root.grab_key(code, X.Mod4Mask, 1, X.GrabModeAsync, X.GrabModeAsync)

while True:
  evt = d.next_event()
  # Unfortunately I wasn't able to mask key press events (I only need key releases),
  # so checking here manually.
  KEY_RELEASE = 3
  if evt.type != KEY_RELEASE: continue
  evt_key = evt.detail

  key = ''
  for k in keycodes:
    if keycodes[k] == evt_key:
      key = k
      break
  if k == '': continue

  if k == 'h': subprocess.call(['move', 'L'])
  if k == 'j': subprocess.call(['move', 'D'])
  if k == 'k': subprocess.call(['move', 'U'])
  if k == 'l': subprocess.call(['move', 'R'])


