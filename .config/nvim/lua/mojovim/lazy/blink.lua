return {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
        keymap = {
            preset = "default",
            ["<C-p>"] = { "select_prev", "fallback" },
            ["<C-n>"] = { "select_next", "fallback" },
            ["<CR>"] = { "accept", "fallback" },
            ["<C-space>"] = { "show" },
        },
        completion = {
            documentation = { auto_show = true, auto_show_delay_ms = 250 },
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },
    },
}
