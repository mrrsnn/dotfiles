local lsp = require('lsp-zero')
local lspconfig = require('lspconfig')
local mason = require("mason")
local mason_lspconfig = require('mason-lspconfig')
local luasnip = require("luasnip")
require('cmp_nvim_lsp')

-- set up lsp zero with presets
lsp.preset('recommended')

lsp.on_attach(function(client, bufnr)
  -- Custom hover handler to render Markdown
  local function custom_hover_handler(_, result, ctx, config)
    config = config or {}
    config.focus_id = ctx.method
    if not (result and result.contents) then
      return
    end

    local lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
    lines = vim.lsp.util.trim_empty_lines(lines)
    if vim.tbl_isempty(lines) then
      return
    end

    -- Create a floating window with formatted content
    return vim.lsp.util.open_floating_preview(lines, "markdown", {
      border = "rounded", -- Use a rounded border for a nicer look
      max_width = 80,    -- Limit the width of the hover window
      focusable = false, -- Prevent focusing the hover window
    })
  end

  -- Replace the default hover handler with the custom one
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(custom_hover_handler, {})

  lsp.default_keymaps({ buffer = bufnr })
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', function()
    vim.lsp.buf.code_action { context = { only = { 'quickfix', 'refactor', 'source' } } }
  end, '[C]ode [A]ction')

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  -- nmap('gh', '<cmd>Lspsaga hover_doc<CR>', 'Hover Documentation')
  nmap('gh', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
  require('which-key')
end)

-- add icons to mason ui
mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

-- install commonly used LSPs and set them up with lspconfig.
mason_lspconfig.setup({
  ensure_installed = {
    'ts_ls',
    'eslint',
    'tailwindcss',
    'html',
    'clangd',
    'cssls',
    'cssmodules_ls',
    'css_variables',
    'unocss',
    'jsonls',
    'lua_ls',
    'marksman',
    'pylsp',
    'vuels',
    'yamlls'
  },
  handlers = {
    function(server_name)
      lspconfig[server_name].setup({})
    end,
    -- eslint = function()
    --   lspconfig.eslint.setup({
    --     on_attach = function(_, bufnr)
    --       vim.api.nvim_create_autocmd("BufWritePre", {
    --         buffer = bufnr,
    --         command = "EslintFixAll",
    --       })
    --     end,
    --   })
    -- end
  }
})

local cmp = require("cmp")
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<Esc>'] = cmp.mapping.abort()
  },
  sources = {
    { name = 'nvim_lsp'},
    { name = 'luasnip' },
    { name = 'path' },
  },
}

-- NULL-LS SECTION START
-- REMOVE THIS SECTION WHEN NULL-LS BECOMES A PROBLEM FROM BEING ARCHIVED
local none_ls = require("null-ls") -- Changed from null-ls to none-ls
local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre"
local async = event == "BufWritePost"

none_ls.setup({
  sources = {
    none_ls.builtins.formatting.prettier,
    none_ls.builtins.diagnostics.eslint,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.keymap.set("n", "<Leader>f", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })

      vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
      vim.api.nvim_create_autocmd(event, {
        buffer = bufnr,
        group = group,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, async = async })
        end,
        desc = "[lsp] format on save",
      })
    end

    if client.supports_method("textDocument/rangeFormatting") then
      vim.keymap.set("x", "<Leader>f", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })
    end
  end,
}) -- NULL-LS SECTION END

-- remove redundant mapping
vim.keymap.del('n', 'gc')
