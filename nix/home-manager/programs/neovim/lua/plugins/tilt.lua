return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"starlark",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				tilt_lsp = {
					cmd = { "tilt", "lsp", "start" },
					filetypes = { "starlark" },
					root_markers = { "Tiltfile", ".git" },
					mason = false,
				},
			},
		},
	},
}
