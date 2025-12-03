return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				size = 20,
				open_mapping = [[<c-\>]],
				shade_filetypes = {},
				direction = "float",
			})

			-- Terminal mode keymaps
			vim.keymap.set("t", "<C-]>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
			vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], { desc = "Move to left window" })
			vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], { desc = "Move to bottom window" })
			vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], { desc = "Move to top window" })
			vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], { desc = "Move to right window" })
		end,
	},
}
