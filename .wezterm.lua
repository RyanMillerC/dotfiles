-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration
local config = wezterm.config_builder()

-- Actual config
--config.alternate_buffer_wheel_scroll_speed = 1
config.color_scheme       = 'Solarized (dark) (terminal.sexy)'
-- config.font               = wezterm.font 'Hack'
config.font_size          = 14
config.front_end          = "WebGpu"
config.window_decorations = "NONE"


-- Keybindings
config.keys = {
  -- Split pane horizontally
  {
    key    = 's',
    mods   = 'ALT',
    action = wezterm.action.SplitPane {
      direction = "Down",
      size = { Percent = 50 },
    },
  },

  -- Split pane vertically
  {
    key    = 's',
    mods   = 'ALT|SHIFT',
    action = wezterm.action.SplitPane {
      direction = "Right",
      size = { Percent = 50 },
    },
  },

  -- Vim-like ALT+direction to focus panes
  {
    key    = 'h',
    mods   = 'ALT',
    action = wezterm.action.ActivatePaneDirection 'Left',
  },
  {
    key    = 'k',
    mods   = 'ALT',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },
  {
    key    = 'j',
    mods   = 'ALT',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },
  {
    key    = 'l',
    mods   = 'ALT',
    action = wezterm.action.ActivatePaneDirection 'Right',
  },

  -- ALT+arrow to resize panes
  {
    key    = 'LeftArrow',
    mods   = 'ALT',
    action = wezterm.action.AdjustPaneSize { 'Left', 5 },
  },
  {
    key    = 'DownArrow',
    mods   = 'ALT',
    action = wezterm.action.AdjustPaneSize { 'Down', 5 },
  },
  {
    key    = 'UpArrow',
    mods   = 'ALT',
    action = wezterm.action.AdjustPaneSize { 'Up', 5 },
  },
  {
    key    = 'RightArrow',
    mods   = 'ALT',
    action = wezterm.action.AdjustPaneSize { 'Right', 5 },
  },
}

config.mouse_bindings = {
  -- Slower scroll up/down (3 lines instead of Page Up/Down)
  {
    event = { Down = { streak = 1, button = { WheelUp = 1 } } },
    mods = 'NONE',
    action = wezterm.action.ScrollByLine(-3),
    alt_screen = false,
  },
  {
    event = { Down = { streak = 1, button = { WheelDown = 1 } } },
    mods = 'NONE',
    action = wezterm.action.ScrollByLine(3),
    alt_screen = false,
  },
}

config.max_fps      = 144

-- Finally, return the configuration to wezterm
return config
