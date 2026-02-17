return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons", -- optional, but recommended
        },
        lazy = false,                      -- neo-tree will lazily load itself
        opts = {
            popup_border_style = "rounded",
            window = {
                width = 30,
            },
            filesystem = {
                follow_current_file = {
                    enabled = true,
                },
            },
            buffers = {
                follow_current_file = {
                    enabled = true,
                },
            },
        },
        keys = {
            { "<leader>pt", "<Cmd>Neotree action=show toggle<CR><C-w>=" },
        },
    }
}
