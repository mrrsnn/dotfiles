require("nvim-tree").setup()

vim.keymap.set('n', '<leader>pt', ':NvimTreeToggle<CR>', { desc = 'Project [T]ree'})
vim.keymap.set('n', '<leader>tc', ':NvimTreeCollapse<CR>', { desc = "[T]ree [C]ollapse"})
vim.keymap.set('n', '<leader>tf', ':NvimTreeFindFile<CR>', { desc = "[T]ree [F]ind File"})
