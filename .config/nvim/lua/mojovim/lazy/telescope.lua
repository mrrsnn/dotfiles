return {
  "nvim-telescope/telescope.nvim",

  tag = "0.1.5",

  dependencies = {
    "nvim-lua/plenary.nvim"
  },

  config = function()
    require('telescope').setup({})

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<letypescript-language-serverader>gf', builtin.git_files, { desc = '[G]it [F]iles' })
    vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = '[P]roject [F]iles' })
    vim.keymap.set('n', '<leader>pb', builtin.buffers, { desc = '[P]roject [B]uffers' })
    vim.keymap.set('n', '<leader>ps', builtin.live_grep, { desc = '[P]roject [S]earch (live grep)' })
    vim.keymap.set('n', '<leader>pws', function()
      local word = vim.fn.expand("<cword>")
      builtin.grep_string({ search = word })
    end)
    vim.keymap.set('n', '<leader>pWs', function()
      local word = vim.fn.expand("<cWORD>")
      builtin.grep_string({ search = word })
    end)
    vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
  end
}
