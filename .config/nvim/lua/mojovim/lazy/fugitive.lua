return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				current_line_blame = true,
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol",
					delay = 300,
				},
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation between hunks
					map("n", "]h", gs.next_hunk)
					map("n", "[h", gs.prev_hunk)

					-- Stage / undo / preview hunks
					map("n", "<leader>hs", gs.stage_hunk)
					map("n", "<leader>hr", gs.reset_hunk)
					map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)
					map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)
					map("n", "<leader>hu", gs.undo_stage_hunk)
					map("n", "<leader>hp", gs.preview_hunk)

					-- Blame
					map("n", "<leader>gb", gs.blame)
					map("n", "<leader>gl", gs.blame_line)
					map("n", "<leader>gt", gs.toggle_current_line_blame)
				end,
			})
		end,
	},

	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

			local function float_commit()
				local buf = vim.api.nvim_create_buf(false, true)
				local width = math.floor(vim.o.columns * 0.8)
				local height = math.floor(vim.o.lines * 0.8)

				local win = vim.api.nvim_open_win(buf, true, {
					relative = "editor",
					width = width,
					height = height,
					col = math.floor((vim.o.columns - width) / 2),
					row = math.floor((vim.o.lines - height) / 2),
					style = "minimal",
					border = "rounded",
				})

				vim.fn.termopen("git commit", {
					on_exit = function()
						vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf })
						-- Refresh fugitive status if open
						vim.cmd("silent! e")
					end,
				})
				-- Auto-insert when terminal opens and when returning to it
				vim.cmd("startinsert")
				vim.api.nvim_create_autocmd("BufEnter", {
					buffer = buf,
					callback = function()
						vim.cmd("startinsert")
					end,
				})
			end

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "fugitive",
				callback = function()
					vim.keymap.set("n", "cc", float_commit, { buffer = true })
				end,
			})
		end,
	},

	-- GitHub integration for fugitive (:GBrowse)
	{ "tpope/vim-rhubarb" },
}
