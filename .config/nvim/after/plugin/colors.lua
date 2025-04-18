require('mini.icons').setup()
require('nvim-web-devicons').setup()
require('rose-pine').setup({
  --- @usage 'auto'|'main'|'moon'|'dawn'
  variant = 'moon',
  --- @usage 'main'|'moon'|'dawn'
  dark_variant = 'main',
  dim_inactive_windows = true,
  bold_vert_split = false,
  dim_nc_background = false,
  disable_background = false,
  disable_float_background = false,
  disable_italics = true,

  enable = {
    terminal = true,
    legacy_highlights = true,     -- Improve compatibility for previous versions of Neovim
    migrations = true,            -- Handle deprecated options automatically
  },

  styles = {
    bold = false,
    italic = false,
    transparency = true,
  },

  --- @usage string hex value or named color from rosepinetheme.com/palette
  groups = {
    background = 'base',
    background_nc = '_experimental_nc',
    panel = 'surface',
    panel_nc = 'base',
    border = 'highlight_med',
    comment = 'muted',
    link = 'iris',
    punctuation = 'subtle',

    error = 'love',
    hint = 'iris',
    info = 'foam',
    warn = 'gold',

    headings = {
      h1 = 'iris',
      h2 = 'foam',
      h3 = 'rose',
      h4 = 'gold',
      h5 = 'pine',
      h6 = 'foam',
    }
    -- or set all headings at once
    -- headings = 'subtle'
  },
})

require('catppuccin').setup({
  flavour = 'frappe', -- latte, frappe, macchiato, mocha
  no_italic = true
})



require('evergarden').setup({
  theme = {
    variant = 'winter', -- 'winter'|'fall'|'spring'|'summer'
    accent = 'red',
  },
  editor = {
    transparent_background = false,
    override_terminal = true,
    sign = { color = 'none' },
    float = {
      color = 'mantle',
      invert_border = false,
    },
    completion = {
      color = 'surface0',
    },
  },
  style = {
    tabline = { 'reverse' },
    search = { 'italic', 'reverse' },
    incsearch = { 'italic', 'reverse' },
    types = { 'italic' },
    keyword = { 'italic' },
    comment = { 'italic' },
  },
  overrides = {},
  color_overrides = {},
})

-- Set colorscheme after options
vim.cmd('colorscheme catppuccin')
