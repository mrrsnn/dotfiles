function ColorMyPencils(color)
    color = color or "vesper"
    vim.cmd.colorscheme(color)
end

return {

    {
        "Shatur/neovim-ayu",
        as = 'ayu'
    },

    {
        "erikbackman/brightburn.vim",
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
    },

    {
        "Mofiqul/dracula.nvim",
        as = "dracula",
    },

    {
        "rebelot/kanagawa.nvim",
        as = "kanagawa",
    },

    {
        'everviolet/nvim',
        as = 'evergarden'
    },

    {
        'datsfilipe/vesper.nvim',
        as = 'vesper',
        config = function()
            require("vesper").setup({
                palette_overrides = {
                    bg = '#1d1a1d', -- Your custom background color
                },
                overrides = {
                    Visual = { bg = '#3f3f3f' },
                    TreeSitterContext = { bg = '#2f2f2f' },
                    TelescopePromptBorder = { fg = '#555555', bg = '#1d1a1d' },
                    TelescopeResultsBorder = { fg = '#555555', bg = '#1d1a1d' },
                    TelescopePreviewBorder = { fg = '#555555', bg = '#1d1a1d' },

                    -- Neotree text
                    NeoTreeFileName = { fg = '#a9a9a9' },      -- Dark grey for file names
                    NeoTreeDirectoryName = { fg = '#a9a9a9' }, -- Dark grey for directories
                    NeoTreeDimText = { fg = '#444444' },       -- Even darker for dim text
                    NeoTreeNormal = { bg = '#1d1a1d' },        -- Match your background if needed
                    NeoTreeActive = { bg = '#1d1a1d' },

                    -- Neotree icons
                    NeoTreeFileIcon = { fg = '#FFCFA8' },      -- Dark grey for file icons
                    NeoTreeDirectoryIcon = { fg = '#FFCFA8' }, -- Dark grey for folder icons
                }
            })
        end
    },

    {
        "AlexvZyl/nordic.nvim",
        as = "nordic",
        config = function()
            require("nordic").setup({
                transparent = {
                    bg = true,
                    float = false
                },
                reduced_blue = true,
                bright_border = false,
                cursorline = {
                    -- Bold font in cursorline.
                    bold = false,
                    -- Bold cursorline number.
                    bold_number = true,
                    -- Available styles: 'dark', 'light'.
                    theme = 'light',
                    -- Blending the cursorline bg with the buffer bg.
                    blend = 0.85,
                },
            })
        end
    },

    {
        "EdenEast/nightfox.nvim",
        config = function()
            require('nightfox').setup({
                options = {
                    transparent = true
                }
            })
        end
    },

    {
        "ellisonleao/gruvbox.nvim",
        name = "gruvbox",
        config = function()
            require("gruvbox").setup({
                terminal_colors = true, -- add neovim terminal colors
                undercurl = true,
                underline = false,
                bold = true,
                italic = {
                    strings = false,
                    emphasis = false,
                    comments = false,
                    operators = false,
                    folds = false,
                },
                strikethrough = true,
                invert_selection = false,
                invert_signs = false,
                invert_tabline = false,
                invert_intend_guides = false,
                inverse = true, -- invert background for search, diffs, statuslines and errors
                contrast = "",  -- can be "hard", "soft" or empty string
                palette_overrides = {},
                overrides = {},
                dim_inactive = false,
                transparent_mode = false,
            })
        end,
    },

    {
        "folke/tokyonight.nvim",
        config = function()
            require("tokyonight").setup({
                style = "night", -- Keep the night variant
                transparent = false,
                -- terminal_colors = true,
                styles = {
                    comments = { italic = true },
                    keywords = { italic = false },
                    functions = {},
                    variables = {},
                    sidebars = "storm",
                    floats = "storm",
                },
                -- Custom highlight overrides to match OpenCode's syntax colors
                on_highlights = function(hl, c)
                    local storm_bg = "#24283b"
                    -- Popup/floating windows
                    hl.NormalFloat = { bg = storm_bg }
                    hl.FloatBorder = { fg = c.blue, bg = storm_bg }
                    hl.FloatTitle = { fg = c.blue, bg = storm_bg }
                    -- LSP diagnostic floats
                    hl.DiagnosticFloatingError = { fg = c.error, bg = storm_bg }
                    hl.DiagnosticFloatingWarn = { fg = c.warning, bg = storm_bg }
                    hl.DiagnosticFloatingInfo = { fg = c.info, bg = storm_bg }
                    hl.DiagnosticFloatingHint = { fg = c.hint, bg = storm_bg }
                end,
            })
        end
    },

    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require('rose-pine').setup({
                disable_background = false,
                styles = {
                    italic = false,
                },
            })

            ColorMyPencils();
        end
    },
}
