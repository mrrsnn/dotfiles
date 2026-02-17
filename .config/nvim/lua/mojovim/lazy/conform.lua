return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		local conform = require("conform")

		local js_fts = { "typescript", "typescriptreact", "javascript", "javascriptreact" }

		-- Use biome if the project has it, otherwise prettier
		local function js_formatter(bufnr)
			if conform.get_formatter_info("biome", bufnr).available then
				return { "biome" }
			end
			return { "prettier" }
		end

		local formatters_by_ft = {
			lua = { "stylua" },
			go = { "goimports", "gofmt" },
			terraform = { "terraform_fmt" },
		}
		for _, ft in ipairs(js_fts) do
			formatters_by_ft[ft] = js_formatter
		end

		conform.setup({ formatters_by_ft = formatters_by_ft })

		-- Ask the LSP to sort/remove imports (sync so it finishes before formatting)
		local function organize_imports(bufnr)
			local clients = vim.lsp.get_clients({ bufnr = bufnr, method = "textDocument/codeAction" })
			if #clients == 0 then
				return
			end
			local client = clients[1]
			local result = client:request_sync("textDocument/codeAction", {
				textDocument = vim.lsp.util.make_text_document_params(bufnr),
				range = {
					start = { line = 0, character = 0 },
					["end"] = { line = vim.api.nvim_buf_line_count(bufnr), character = 0 },
				},
				context = { only = { "source.organizeImports" }, diagnostics = {} },
			}, 3000, bufnr)
			if result and result.result and result.result[1] and result.result[1].edit then
				vim.lsp.util.apply_workspace_edit(result.result[1].edit, client.offset_encoding)
			end
		end

		local js_ft_set = {}
		for _, ft in ipairs(js_fts) do
			js_ft_set[ft] = true
		end

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				if js_ft_set[vim.bo[args.buf].filetype] then
					organize_imports(args.buf)
				end
				conform.format({ bufnr = args.buf })
			end,
		})
	end,
}
