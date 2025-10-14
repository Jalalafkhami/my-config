local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- =========================================
-- فونت و ظاهر
-- =========================================
-- JetBrains Mono که از قبل نصب است
config.font = wezterm.font('JetBrains Mono', { weight = 'Medium' })
config.font_size = 12.5

-- تم زیبای Catppuccin
-- config.color_scheme = 'Rosé Pine Moon'
config.color_scheme = 'Catppuccin Mocha'
-- config.color_scheme = 'Batman'
-- config.color_scheme = 'Kanagawa (Gogh)'
-- config.color_scheme = 'Dracula'
-- config.color_scheme = 'Nord'
-- config.color_scheme = 'Gruvbox Dark (Gogh)'

config.window_background_opacity = 0.92
-- =========================================
-- عکس پس‌زمینه
-- =========================================
-- مسیر مطلق به عکس
config.window_background_image = os.getenv("HOME") .. '/Pics/pexels-sebastiaan9977-3022001.jpg'

-- تنظیمات رنگی عکس
config.window_background_image_hsb = {
	brightness = 0.1, -- تاریک کردن عکس برای خوانایی متن
	hue = 1.0,
	saturation = 1.0,
}

-- شفافیت کلی پنجره (اختیاری)
config.window_background_opacity = 0.95

-- شفافیت متن پس‌زمینه برای خوانایی بهتر
config.text_background_opacity = 0.9


-- Padding بیشتر برای زیبایی
config.window_padding = {
	left = 15,
	right = 15,
	top = 15,
	bottom = 15,
}

-- =========================================
-- تب بار سفارشی
-- =========================================
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = true

-- رنگ‌های Catppuccin Mocha برای تب‌ها
config.colors = {
	tab_bar = {
		background = '#11111b',
		active_tab = {
			bg_color = '#cba6f7',
			fg_color = '#11111b',
			intensity = 'Bold',
		},
		inactive_tab = {
			bg_color = '#313244',
			fg_color = '#6c7086',
		},
		inactive_tab_hover = {
			bg_color = '#45475a',
			fg_color = '#cdd6f4',
		},
		new_tab = {
			bg_color = '#11111b',
			fg_color = '#cba6f7',
		},
	},
}

-- =========================================
-- کیبایندینگ‌ها
-- =========================================
config.keys = {
	-- تب جدید
	{ key = 't',          mods = 'CTRL|SHIFT',     action = wezterm.action.SpawnTab 'CurrentPaneDomain' },

	-- بستن تب
	{ key = 'w',          mods = 'CTRL|SHIFT',     action = wezterm.action.CloseCurrentTab { confirm = true } },

	-- جابجایی بین تب‌ها
	{ key = 'Tab',        mods = 'CTRL',           action = wezterm.action.ActivateTabRelative(1) },
	{ key = 'Tab',        mods = 'CTRL|SHIFT',     action = wezterm.action.ActivateTabRelative(-1) },

	-- تقسیم پنجره
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
-- پرفورمنس (رفع مشکل i3)
-- =========================================
config.front_end = "OpenGL" -- به جای WebGpu
config.max_fps = 120
config.animation_fps = 60

-- =========================================
-- ظاهر پنجره
-- =========================================
config.window_decorations = "RESIZE"

return config
