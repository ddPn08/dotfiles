local function find_hpack_root(bufnr)
	local path = vim.api.nvim_buf_get_name(bufnr)
	if path == "" then
		return nil
	end

	local package_yaml = vim.fs.find({ "package.yaml" }, {
		upward = true,
		path = path,
	})[1]

	return package_yaml and vim.fs.dirname(package_yaml) or nil
end

local function hpack_output(obj)
	local output = vim.trim(obj.stderr ~= "" and obj.stderr or obj.stdout)
	if output == "" then
		output = "hpack exited without output"
	end

	return output
end

local function notify_hpack_failure(root, output)
	vim.schedule(function()
		vim.notify(string.format("hpack failed in %s\n%s", root, output), vim.log.levels.ERROR)
	end)
end

local function run_hpack(root, opts)
	opts = opts or {}

	if opts.sync then
		local ok, obj = pcall(function()
			return vim.system({ "hpack" }, {
				cwd = root,
				text = true,
			}):wait()
		end)

		if not ok then
			vim.notify(string.format("Failed to start hpack in %s\n%s", root, obj), vim.log.levels.ERROR)
			return
		end

		if obj.code ~= 0 then
			notify_hpack_failure(root, hpack_output(obj))
		end

		return
	end

	local ok, err = pcall(vim.system, { "hpack" }, {
		cwd = root,
		text = true,
	}, function(obj)
		if obj.code == 0 then
			return
		end

		notify_hpack_failure(root, hpack_output(obj))
	end)

	if ok then
		return
	end

	vim.notify(string.format("Failed to start hpack in %s\n%s", root, err), vim.log.levels.ERROR)
end

return {
	{
		"mason-org/mason.nvim",
		opts = function(_, opts)
			opts.ensure_installed = vim.tbl_filter(function(pkg)
				return pkg ~= "haskell-language-server"
			end, opts.ensure_installed or {})
		end,
	},
	{
		"mrcjkb/haskell-tools.nvim",
		init = function()
			-- Extend fix_cabal_client: HLS falsely advertises inlayHintProvider for cabal files
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if client and client.name == "haskell-tools.nvim (cabal)" and client.server_capabilities then
						client.server_capabilities.inlayHintProvider = nil
					end
				end,
			})

			vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
				pattern = { "*.hs", "*.lhs", "*.hs-boot", "*.hsc", "package.yaml" },
				callback = function(args)
					local root = find_hpack_root(args.buf)
					if not root then
						return
					end

					run_hpack(root, { sync = true })
				end,
			})

			vim.api.nvim_create_autocmd("BufWritePost", {
				pattern = { "*.hs", "*.lhs", "*.hs-boot", "*.hsc" },
				callback = function(args)
					local root = find_hpack_root(args.buf)
					if not root then
						return
					end

					run_hpack(root)
				end,
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = function(_, opts)
			opts.formatters_by_ft = opts.formatters_by_ft or {}
			opts.formatters_by_ft.haskell = { "fourmolu", "stylish-haskell" }
		end,
	},
}
