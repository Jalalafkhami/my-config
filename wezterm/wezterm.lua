local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- =========================================
-- ظاهری و تم
-- =========================================
config.color_scheme = 'Tokyo Night'
config.font = wezterm.font('JetBrains Mono', { weight = 'Medium' })
config.font_size = 12.0

-- شفافیت پس‌زمینه
config.window_background_opacity = 0.95
config.macos_window_background_blur = 20

-- نوار عنوان
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true

-- =========================================
-- تب‌ها
-- =========================================
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.show_tab_index_in_tab_bar = false

-- استایل تب‌ها
config.colors = {
	tab_bar = {
		background = '#1a1b26',
		active_tab = {
			bg_color = '#7aa2f7',
			fg_color = '#1a1b26',
			intensity = 'Bold',
		},
		inactive_tab = {
			bg_color = '#292e42',
			fg_color = '#787c99',
		},
		inactive_tab_hover = {
			bg_color = '#3b4261',
			fg_color = '#c0caf5',
		},
		new_tab = {
			bg_color = '#1a1b26',
			fg_color = '#7aa2f7',
		},
	},
}

-- =========================================
-- کیبایندینگ‌ها (Keybindings)
-- =========================================
config.keys = {
	-- تب جدید
	{ key = 't',          mods = 'CTRL|SHIFT',     action = wezterm.action.SpawnTab 'CurrentPaneDomain' },

	-- بستن تب
	{ key = 'w',          mods = 'CTRL|SHIFT',     action = wezterm.action.CloseCurrentTab { confirm = true } },

	-- جابجایی بین تب‌ها
	{ key = 'Tab',        mods = 'CTRL',           action = wezterm.action.ActivateTabRelative(1) },
	{ key = 'Tab',        mods = 'CTRL|SHIFT',     action = wezterm.action.ActivateTabRelative(-1) },

	-- تقسیم پنجره (Split Panes)
	{ key = 'd',          mods = 'CTRL|SHIFT',     action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
	{ key = 'D',          mods = 'CTRL|SHIFT',     action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },

	-- جابجایی بین پنجره‌ها
	{ key = 'LeftArrow',  mods = 'CTRL|SHIFT',     action = wezterm.action.ActivatePaneDirection 'Left' },
	{ key = 'RightArrow', mods = 'CTRL|SHIFT',     action = wezterm.action.ActivatePaneDirection 'Right' },
	{ key = 'UpArrow',    mods = 'CTRL|SHIFT',     action = wezterm.action.ActivatePaneDirection 'Up' },
	{ key = 'DownArrow',  mods = 'CTRL|SHIFT',     action = wezterm.action.ActivatePaneDirection 'Down' },

	-- تغییر سایز پنجره‌ها
	{ key = 'LeftArrow',  mods = 'CTRL|SHIFT|ALT', action = wezterm.action.AdjustPaneSize { 'Left', 5 } },
	{ key = 'RightArrow', mods = 'CTRL|SHIFT|ALT', action = wezterm.action.AdjustPaneSize { 'Right', 5 } },
	{ key = 'UpArrow',    mods = 'CTRL|SHIFT|ALT', action = wezterm.action.AdjustPaneSize { 'Up', 5 } },
	{ key = 'DownArrow',  mods = 'CTRL|SHIFT|ALT', action = wezterm.action.AdjustPaneSize { 'Down', 5 } },

	-- کپی و پیست
	{ key = 'c',          mods = 'CTRL|SHIFT',     action = wezterm.action.CopyTo 'Clipboard' },
	{ key = 'v',          mods = 'CTRL|SHIFT',     action = wezterm.action.PasteFrom 'Clipboard' },

	-- جستجو
	{ key = 'f',          mods = 'CTRL|SHIFT',     action = wezterm.action.Search 'CurrentSelectionOrEmptyString' },

	-- پاک کردن صفحه
	{ key = 'k',          mods = 'CTRL|SHIFT',     action = wezterm.action.ClearScrollback 'ScrollbackAndViewport' },

	-- زوم
	{ key = '+',          mods = 'CTRL',           action = wezterm.action.IncreaseFontSize },
	{ key = '-',          mods = 'CTRL',           action = wezterm.action.DecreaseFontSize },
	{ key = '0',          mods = 'CTRL',           action = wezterm.action.ResetFontSize },
}

-- =========================================
-- تنظیمات عمومی
-- =========================================
config.automatically_reload_config = true
config.exit_behavior = 'Close'
config.window_close_confirmation = 'NeverPrompt'

-- اسکرول
config.scrollback_lines = 10000
config.enable_scroll_bar = false

-- ماوس
config.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = 'Left' } },
		mods = 'CTRL',
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
}

-- =========================================
-- پرفورمنس
-- =========================================
config.front_end = "WebGpu"
config.max_fps = 120
config.animation_fps = 60

-- =========================================
-- Padding
-- =========================================
config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 10,
}

return config
