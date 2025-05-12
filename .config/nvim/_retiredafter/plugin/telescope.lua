local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = '[P]roject [F]iles' })
vim.keymap.set('n', '<leader>pb', builtin.buffers, { desc = '[P]roject [B]uffers'})
vim.keymap.set('n', '<leader>ps', builtin.live_grep, { desc = '[P]roject [S]earch (live grep)' })

vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = '[G]it [F]iles' })
