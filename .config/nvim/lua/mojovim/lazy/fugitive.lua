return {
	{

		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
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
}
