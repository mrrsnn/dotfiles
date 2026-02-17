return {
    "echasnovski/mini.files",
    version = false,
    opts = {
        mappings = {
            go_in_plus = "<CR>",
        },
        windows = {
            -- Maximum number of windows to show side by side
            max_number = 10,
            -- Whether to show preview of file/directory under cursor
            preview = true,
            -- Width of focused window
            width_focus = 25,
            -- Width of non-focused window
            width_nofocus = 25,
            -- Width of preview window
            width_preview = 50,
        },
    },
    keys = {
        {
            "<leader>pe",
            function()
                local buf_name = vim.api.nvim_buf_get_name(0)
                local path = vim.fn.filereadable(buf_name) == 1 and buf_name or vim.fn.getcwd()
                require("mini.files").open(path)
            end,
            desc = "Mini Files (current file)",
        },
    },
}
