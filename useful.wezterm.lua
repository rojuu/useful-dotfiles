local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- config.color_scheme = "Catppuccin Mocha"

config.colors = {
	-- background = "#000000",
	-- background = "#1b1b1b",
	background = "#090909",
}

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- config.default_prog = { "cmd.exe", "/k", "C:\\Users\\roju2\\p\\x64_powershell.bat" }
config.default_prog = { "wsl.exe", "--cd", "~/" }

config.audible_bell = "Disabled"

config.font = wezterm.font_with_fallback({
	"GohuFont uni14 Nerd Font",
	"Fira Code",
})

config.font_size = 14

config.keys = {
	{
		key = "w",
		mods = "CTRL|ALT",
		action = wezterm.action.CloseCurrentTab({ confirm = true }),
	},
	{
		key = "w",
		mods = "CTRL|SHIFT",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		key = "v",
		mods = "CTRL|ALT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "s",
		mods = "CTRL|ALT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "h",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "k",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		key = "F11",
		action = wezterm.action.ToggleFullScreen,
	},

}

for i = 1, 8 do
	-- CTRL+ALT + number to activate that tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "CTRL|ALT",
		action = wezterm.action.ActivateTab(i - 1),
	})
	-- F1 through F8 to activate that tab
	table.insert(config.keys, {
		key = "F" .. tostring(i),
		action = wezterm.action.ActivateTab(i - 1),
	})
end

return config
