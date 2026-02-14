return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"stevearc/conform.nvim",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
	},
	config = function()
		-- formatter conform
		require("conform").setup({
			formatters_by_ft = {},
		})

		-- auto complete utilities : cmp
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		-- For showing lsp notifications and status
		require("fidget").setup({})
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
				"gopls",
				"ts_ls",
				"tailwindcss",
				"lua_ls",
			},
			handlers = {
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,
				-- Special handler for gopls
				["gopls"] = function()
					require("lspconfig").gopls.setup({
						capabilities = capabilities,
						settings = {
							gopls = {
								analyses = {
									composites = false,
									unusedparams = true,
								},
								staticcheck = false,
								hints = {
									compositeLiteralFields = false,
									compositeLiteralTypes = false,
								},
							},
						},
					})
				end,
			},
		})

		-- Setup the autocomplete window
		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<Enter>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = "copilot", group_index = 2 },
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- For luasnip users.
			}, {
				{ name = "buffer" },
			}),
		})

		local telescopeBuiltin = require("telescope.builtin")

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(e)
				-- Configure LSP handlers with borders
				local border_style = "rounded"

				vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
					border = "double",
					style = "minimal",
					focusable = false,
					max_width = 80, -- Control width
					max_height = 20, -- Control height
				})

				vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
					border = border_style,
					style = "minimal",
					focusable = false,
				})

				vim.diagnostic.config({
					-- update_in_insert = true,
					float = {
						focusable = false,
						style = "minimal",
						border = border_style,
						source = "always",
						header = "",
						prefix = "",
					},
				})

				local opts = { buffer = e.buf }
				vim.keymap.set("n", "gd", function()
					telescopeBuiltin.lsp_definitions()
				end, opts)
				vim.keymap.set("n", "gr", function()
					telescopeBuiltin.lsp_references()
				end, opts)
				vim.keymap.set("n", "gh", function()
					vim.lsp.buf.hover()
				end, opts)
				vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
				vim.keymap.set("n", "<leader>ws", function()
					vim.lsp.buf.workspace_symbol()
				end, opts)
				vim.keymap.set("n", "<leader>wd", function()
					vim.diagnostic.open_float()
				end, opts)
				vim.keymap.set("n", "<leader>ca", function()
					vim.lsp.buf.code_action()
				end, opts)
				vim.keymap.set("n", "<leader>br", function()
					vim.lsp.buf.rename()
				end, opts)
				vim.keymap.set("i", "<C-h>", function()
					vim.lsp.buf.signature_help()
				end, opts)
				vim.keymap.set("n", "[d", function()
					vim.diagnostic.goto_next()
				end, opts)
				vim.keymap.set("n", "]d", function()
					vim.diagnostic.goto_prev()
				end, opts)
			end,
		})
	end,
}
