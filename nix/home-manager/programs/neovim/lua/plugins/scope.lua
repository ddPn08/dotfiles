return {
	{
		"tiagovla/scope.nvim",
		lazy = false,
		opts = {},
		config = function(_, opts)
			require("scope").setup(opts)

			local persistence_group = vim.api.nvim_create_augroup("ScopePersistence", { clear = true })

			vim.api.nvim_create_autocmd("User", {
				group = persistence_group,
				pattern = "PersistenceLoadPre",
				-- Legacy sessions do not unset globals, so discard state left by the previously loaded session.
				callback = function()
					vim.g.ScopeState = nil
				end,
			})

			vim.api.nvim_create_autocmd("User", {
				group = persistence_group,
				pattern = "PersistenceLoadPost",
				command = "ScopeLoadState",
			})

			vim.api.nvim_create_autocmd("User", {
				group = persistence_group,
				pattern = "PersistenceSavePre",
				-- persistence.nvim saves globals after this event, so serialize Scope's Lua state first.
				command = "ScopeSaveState",
			})
		end,
	},
}
