return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-jest",
    "marilari88/neotest-vitest",
    "leoluz/nvim-dap-go",
    "mortepau/codicons.nvim",
  },
  config = function()
    require('neotest').setup({
      adapters = {
        require('neotest-jest')({
          jestCommand = require('neotest-jest.jest-util').getJestCommand(vim.fn.expand '%:p:h') .. ' --watch',
          jestConfigFile = "custom.jest.config.ts",
          env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        }),
        require("neotest-vitest"),
      }
    })

    vim.api.nvim_set_keymap("n", "<leader>tj",
      "<cmd>lua require('neotest').run.run({ jestCommand = 'jest ' })<cr>", {})

    vim.api.nvim_set_keymap("n", "<leader>tjw",
      "<cmd>lua require('neotest').run.run({ jestCommand = 'jest --watch ' })<cr>", {})

    vim.api.nvim_set_keymap(
      "n",
      "<leader>tv",
      "<cmd>lua require('neotest').run.run({ vitestCommand = 'vitest ' })<cr>",
      { desc = "Run Watch" }
    )

    vim.api.nvim_set_keymap(
      "n",
      "<leader>tvw",
      "<cmd>lua require('neotest').run.run({ vitestCommand = 'vitest --watch ' })<cr>",
      { desc = "Run Watch" }
    )

    vim.keymap.set("n", "<leader>tr", function()
      require("neotest").run.run({
        suite = false,
        testify = true,
      })
    end, { desc = "Debug: Running Nearest Test" })

    vim.keymap.set("n", "<leader>tt", function()
      require("neotest").summary.toggle()
    end, { desc = "Debug: Summary Toggle" })

    vim.keymap.set("n", "<leader>ts", function()
      require("neotest").run.run({
        suite = true,
        testify = true,
      })
    end, { desc = "Debug: Running Test Suite" })

    vim.keymap.set("n", "<leader>td", function()
      require("neotest").run.run({
        suite = false,
        testify = true,
        strategy = "dap",
      })
    end, { desc = "Debug: Debug Nearest Test" })

    vim.keymap.set("n", "<leader>to", function()
      require("neotest").output.open()
    end, { desc = "Debug: Open test output" })

    vim.keymap.set("n", "<leader>ta", function()
      require("neotest").run.run(vim.fn.getcwd())
    end, { desc = "Debug: Open test output" })
  end
}
