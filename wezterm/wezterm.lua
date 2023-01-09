local wezterm = require 'wezterm'
local mux = wezterm.mux

wezterm.on("gui-startup", function()
  local tab, pane, window = mux.spawn_window{}
  window:gui_window():maximize()
end)

return {
 font_size = 14.0,
 line_height = 1.25,
 color_scheme = "One dark (base16)",
 enable_tab_bar = false,
 audible_bell = "Disabled",
}
