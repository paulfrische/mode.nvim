# Mode.nvim
Group keybinds together and enable/disable them on the fly

## What?
This plugin allows you to easily build your own _modes_.
It is heavily inspired by [stackmap.nvim](https://github.com/tjdevries/stackmap.nvim).

## Why?
You could build a "debugging-mode" for example so you don't clutter your keymap
with keybinds you don't use when not debugging
```lua
require('mode').add('n', 'Debugging', {
  ['<leader>b'] = require'dap'.toggle_breakpoint,
  ['<leader>c'] = require'dap'.continue,
  ['<leader>so'] = require'dap'.step_over,
  ['<leader>si'] = require'dap'.step_into,
  ['<leader>ro'] = require'dap'.repl.open,
})
```
which could be dynamically activated and deactivated by using the `on` and `off`
functions:
```lua
-- activate
require('mode').on('Debugging')

-- deactivate when finish debugging
require('mode').on('Debugging')
```
This plugin is:
 - 🐒 easy to use
 - 🪨 small and stupid
 - 🚀 **BLAZINGLY FAST** (I think)

## Why Not?
I am very new to plugin development so there is a good chance that this plugin contains
some nasty bugs.

## Alternatives
Here are some alternatives:
 - [stackmap.nvim](https://github.com/tjdevries/stackmap.nvim)
 - [hydra.nvim](anuvyklack/hydra.nvim)
