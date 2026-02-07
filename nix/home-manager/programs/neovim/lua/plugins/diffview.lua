return {
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
		keys = {
			{ "<leader>Gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
			{ "<leader>Gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History (current)" },
			{ "<leader>GH", "<cmd>DiffviewFileHistory<cr>", desc = "File History (all)" },
		},
		opts = {},
	},
}
