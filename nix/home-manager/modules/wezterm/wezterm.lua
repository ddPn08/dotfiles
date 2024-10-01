local wezterm = require 'wezterm'

local user = os.getenv("USER")

local config = wezterm.config_builder()
config.automatically_reload_config = true

config.font_size = 12.0
config.font = wezterm.font("CaskaydiaCove Nerd Font", {
    weight = "Regular",
    stretch = "Normal",
    style = "Normal"
})

config.use_ime = true

config.window_background_opacity = 0.70
config.macos_window_background_blur = 20

config.window_decorations = "RESIZE"
config.window_frame = {
    inactive_titlebar_bg = "none",
    active_titlebar_bg = "none"
}
config.window_background_gradient = {
    colors = {"#000000"}
}
config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false -- only nightly build
config.colors = {
    tab_bar = {
        inactive_tab_edge = "none"
    }
}

config.keys = { -- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
{
    key = "LeftArrow",
    mods = "OPT",
    action = wezterm.action {
        SendString = "\x1bb"
    }
}, -- Make Option-Right equivalent to Alt-f; forward-word
{
    key = "RightArrow",
    mods = "OPT",
    action = wezterm.action {
        SendString = "\x1bf"
    }
}}

local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local background = "#4c7b57"
    local foreground = "#eeeeee"
    local edge_background = "none"
    if tab.is_active then
        background = "#b5fff9"
        foreground = "#4c7b57"
    end
    local edge_foreground = background
    local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "
    return {{
        Background = {
            Color = edge_background
        }
    }, {
        Foreground = {
            Color = edge_foreground
        }
    }, {
        Text = SOLID_LEFT_ARROW
    }, {
        Background = {
            Color = background
        }
    }, {
        Foreground = {
            Color = foreground
        }
    }, {
        Text = title
    }, {
        Background = {
            Color = edge_background
        }
    }, {
        Foreground = {
            Color = edge_foreground
        }
    }, {
        Text = SOLID_RIGHT_ARROW
    }}
end)

-- and finally, return the configuration to wezterm
return config
