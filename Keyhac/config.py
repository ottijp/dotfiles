import sys
import os
import datetime
import subprocess

from keyhac import *


def configure(keymap):

    # --------------------------------------------------------------------
    # Text editer setting for editting config.py file

    # Setting with program file path (Simple usage)
    if 1:
        #keymap.editor = "TextEdit"
        #keymap.editor = "Sublime Text 2"
        keymap.editor = "MacVim"

    # Setting with callable object (Advanced usage)
    if 0:
        def editor(path):
            subprocess.call([ "open", "-a", "TextEdit", path ])
        keymap.editor = editor


    # --------------------------------------------------------------------
    # Customizing the display

    # Font
    keymap.setFont( "Osaka-Mono", 16 )

    # Theme
    keymap.setTheme("black")


    # --------------------------------------------------------------------

    # Global Keymap
    keymap_global = keymap.defineWindowKeymap()
    keymap_global["Ctrl-M"] = "Return"
    keymap_global["Ctrl-G"] = "Escape"

    # Vim disable Kana on escaping insert mode
    keymap_vims = [
            keymap.defineWindowKeymap( app_name="org.vim.MacVim" )
            ]
    for keymap_vim in keymap_vims:
        keymap_vim[ "Esc" ] = "(102)", "Esc"
        keymap_vim[ "Ctrl-G" ] = "(102)", "Esc"
