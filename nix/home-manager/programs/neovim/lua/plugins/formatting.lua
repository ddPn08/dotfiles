-- lua/plugins/formatting.lua
-- プロジェクトの設定ファイルに応じてフォーマッターを自動選択

local oxfmt_config_files = {
	".oxfmtrc.json",
	".oxfmtrc.jsonc",
	"oxfmt.config.ts",
}

local oxlint_config_files = {
	".oxlintrc.json",
	".oxlintrc.jsonc",
	"oxlint.config.ts",
}

local biome_config_files = {
	"biome.json",
	"biome.jsonc",
	".biome.json",
	".biome.jsonc",
}

local prettier_config_files = {
	".prettierrc",
	".prettierrc.json",
	".prettierrc.yml",
	".prettierrc.yaml",
	".prettierrc.js",
	".prettierrc.cjs",
	".prettierrc.mjs",
	"prettier.config.js",
	"prettier.config.cjs",
	"prettier.config.mjs",
}

local frontend_filetypes = {
	"javascript",
	"javascriptreact",
	"typescript",
	"typescriptreact",
	"json",
	"jsonc",
	"vue",
	"svelte",
	"astro",
}

local oxlint_filetypes = {
	javascript = true,
	javascriptreact = true,
	typescript = true,
	typescriptreact = true,
	vue = true,
	svelte = true,
	astro = true,
}

local function buffer_path(bufnr)
	local path = vim.api.nvim_buf_get_name(bufnr)
	return path ~= "" and path or vim.uv.cwd()
end

local function has_config(files, bufnr)
	return vim.fs.find(files, { upward = true, path = buffer_path(bufnr) })[1] ~= nil
end

local function formatter_available(name, bufnr)
	local ok, conform = pcall(require, "conform")
	if not ok then
		return vim.fn.executable(name) == 1
	end

	local info = conform.get_formatter_info(name, bufnr)
	return info and info.available
end

local function add_oxlint_fix(formatters, bufnr)
	if oxlint_filetypes[vim.bo[bufnr].filetype] and has_config(oxlint_config_files, bufnr) then
		table.insert(formatters, "oxlint")
	end
end

local function frontend_formatters(bufnr)
	local formatters = {}
	add_oxlint_fix(formatters, bufnr)

	if has_config(oxfmt_config_files, bufnr) then
		table.insert(formatters, "oxfmt")
		return formatters
	end

	if has_config(biome_config_files, bufnr) then
		table.insert(formatters, "biome-check")
		return formatters
	end

	if has_config(prettier_config_files, bufnr) then
		vim.list_extend(formatters, { "prettier", "eslint_d" })
		return formatters
	end

	if formatter_available("oxfmt", bufnr) then
		table.insert(formatters, "oxfmt")
	else
		vim.list_extend(formatters, { "prettier", "eslint_d" })
	end

	return formatters
end

return {
	"stevearc/conform.nvim",
	opts = function(_, opts)
		opts.formatters_by_ft = opts.formatters_by_ft or {}
		for _, filetype in ipairs(frontend_filetypes) do
			opts.formatters_by_ft[filetype] = frontend_formatters
		end

		local util = require("conform.util")
		opts.formatters = opts.formatters or {}
		opts.formatters.oxfmt = { cwd = util.root_file(oxfmt_config_files) }
		opts.formatters.oxlint = { cwd = util.root_file(oxlint_config_files) }
	end,
}
