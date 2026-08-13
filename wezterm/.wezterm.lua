local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.canonicalize_pasted_newlines = "LineFeed"
config.audible_bell = "Disabled"
config.check_for_updates = false
config.max_fps = 60

-- ========================================
-- CORES IDENTICAS AO GNOME TERMINAL
-- ========================================
config.colors = {
    foreground = '#AAAAAA',
    background = '#000000',

    cursor_bg = '#AAAAAA',
    cursor_fg = '#000000',
    cursor_border = '#AAAAAA',

    selection_fg = '#000000',
    selection_bg = '#AAAAAA',

    scrollbar_thumb = '#666666',

    -- Cores ANSI iguais ao GNOME Terminal (Gray on Black)
    ansi = {
        '#2E3436', -- Preto (mais suave)
        '#CC0000', -- Vermelho
        '#4E9A06', -- Verde
        '#C4A000', -- Amarelo (AJUSTADO - menos forte)
        '#3465A4', -- Azul
        '#75507B', -- Magenta
        '#06989A', -- Ciano
        '#D3D7CF', -- Branco
    },
    brights = {
        '#555753', -- Preto brilhante
        '#EF2929', -- Vermelho brilhante
        '#8AE234', -- Verde brilhante
        '#FCE94F', -- Amarelo brilhante (AJUSTADO)
        '#729FCF', -- Azul brilhante
        '#AD7FA8', -- Magenta brilhante
        '#34E2E2', -- Ciano brilhante
        '#EEEEEC', -- Branco brilhante
    },
}

config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_rate = 600
config.cursor_blink_ease_in = 'EaseIn'
config.cursor_blink_ease_out = 'EaseOut'

config.force_reverse_video_cursor = false

config.font = wezterm.font('JetBrains Mono', { weight = 'Light' })
config.font_size = 16.0
config.line_height = 0.90

-- Tab bar
config.enable_tab_bar = true
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.tab_max_width = 999

wezterm.on('format-tab-title', function(tab)
    local title = tab.active_pane.title
    return ' ' .. title .. ' '
end)

-- Decoracoes da janela
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.integrated_title_button_alignment = "Right"
config.integrated_title_buttons = { "Hide", "Maximize", "Close" }

-- Bordas
config.window_frame = {
    border_left_width    = '0.0cell',
    border_right_width   = '0.0cell',
    border_bottom_height = '0.0cell',
    border_top_height    = '0.0cell',
    border_left_color    = '#505050',
    border_right_color   = '#505050',
    border_bottom_color  = '#505050',
    border_top_color     = '#505050',
    font_size            = 14.0, -- Tamanho da fonte da tab bar
}

-- Padding interno
config.window_padding = {
    left   = 3,
    right  = 3,
    top    = 3,
    bottom = 3,
}

-- Scrollbar
config.enable_scroll_bar = false

config.window_background_opacity = 0.95
config.scrollback_lines = 7000

config.keys = {
    -- TABS
    { key = 't',        mods = 'CTRL|SHIFT', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
    { key = 'w',        mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentTab { confirm = true } },
    { key = 'PageDown', mods = 'CTRL',       action = wezterm.action.ActivateTabRelative(1) },
    { key = 'PageUp',   mods = 'CTRL',       action = wezterm.action.ActivateTabRelative(-1) },

    -- Alt+numero para tabs
    { key = '1',        mods = 'ALT',        action = wezterm.action.ActivateTab(0) },
    { key = '2',        mods = 'ALT',        action = wezterm.action.ActivateTab(1) },
    { key = '3',        mods = 'ALT',        action = wezterm.action.ActivateTab(2) },
    { key = '4',        mods = 'ALT',        action = wezterm.action.ActivateTab(3) },
    { key = '5',        mods = 'ALT',        action = wezterm.action.ActivateTab(4) },
    { key = '6',        mods = 'ALT',        action = wezterm.action.ActivateTab(5) },
    { key = '7',        mods = 'ALT',        action = wezterm.action.ActivateTab(6) },
    { key = '8',        mods = 'ALT',        action = wezterm.action.ActivateTab(7) },
    { key = '9',        mods = 'ALT',        action = wezterm.action.ActivateTab(8) },
    { key = '0',        mods = 'ALT',        action = wezterm.action.ActivateTab(9) },

    -- COPIAR/COLAR
    { key = 'c',        mods = 'CTRL|SHIFT', action = wezterm.action.CopyTo 'Clipboard' },
    { key = 'v',        mods = 'CTRL|SHIFT', action = wezterm.action.PasteFrom 'Clipboard' },

    -- BUSCA
    { key = 'f',        mods = 'CTRL|SHIFT', action = wezterm.action.Search 'CurrentSelectionOrEmptyString' },

    -- ZOOM
    { key = '+',        mods = 'CTRL',       action = wezterm.action.IncreaseFontSize },
    { key = '-',        mods = 'CTRL',       action = wezterm.action.DecreaseFontSize },
    { key = '0',        mods = 'CTRL',       action = wezterm.action.ResetFontSize },

    -- FULLSCREEN
    { key = 'F11',      mods = 'NONE',       action = wezterm.action.ToggleFullScreen },

    -- NOVA JANELA
    { key = 'n',        mods = 'CTRL|SHIFT', action = wezterm.action.SpawnWindow },

    -- SPLITS
    { key = 'd',        mods = 'CTRL|SHIFT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = 'e',        mods = 'CTRL|SHIFT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },

    -- Navegar splits
    { key = 'h',        mods = 'CTRL|ALT',   action = wezterm.action.ActivatePaneDirection 'Left' },
    { key = 'l',        mods = 'CTRL|ALT',   action = wezterm.action.ActivatePaneDirection 'Right' },
    { key = 'k',        mods = 'CTRL|ALT',   action = wezterm.action.ActivatePaneDirection 'Up' },
    { key = 'j',        mods = 'CTRL|ALT',   action = wezterm.action.ActivatePaneDirection 'Down' },

    -- Fechar split
    { key = 'x',        mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentPane { confirm = true } },

    -- Reload config
    { key = 'r',        mods = 'CTRL|SHIFT', action = wezterm.action.ReloadConfiguration },
}

config.mouse_bindings = {
    -- Selecionar e copiar automaticamente
    {
        event = { Up = { streak = 1, button = 'Left' } },
        mods = 'NONE',
        action = wezterm.action.CompleteSelectionOrOpenLinkAtMouseCursor 'Clipboard',
    },
    -- Colar com botao direito
    {
        event = { Down = { streak = 1, button = 'Right' } },
        mods = 'NONE',
        action = wezterm.action.PasteFrom 'Clipboard',
    },
    -- Colar com botao do meio
    {
        event = { Down = { streak = 1, button = 'Middle' } },
        mods = 'NONE',
        action = wezterm.action.PasteFrom 'Clipboard',
    },
    -- Super+arrastar para mover janela no Wayland/GNOME
    {
        event = { Drag = { streak = 1, button = 'Left' } },
        mods = 'SUPER',
        action = wezterm.action.StartWindowDrag,
    },
}

config.selection_word_boundary = " \t\n{}[]()\"'`"

return config
