vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>ll', vim.cmd.Ex)

-- Virtual shifting movements
vim.keymap.set('v', 'J', ":m '>+1<Cr>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<Cr>gv=gv")

-- Vertical Movement Key Remaps
vim.keymap.set('n', 'j', "gj")
vim.keymap.set('n', 'k', "gk")
vim.keymap.set('n', 'J', "mzJ`z")
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', "nzzzv")
vim.keymap.set('n', 'N', "Nzzzv")
--
-- Window resizing Keyamps
vim.keymap.set('n', '<C-h>', ':vertical resize -5<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', ':resize +5<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', ':resize -5<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', ':vertical resize +5<cr>', { noremap = true, silent = true })

-- Formatting
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
