-- lua/plugins/formatting.lua
-- プロジェクトの設定ファイルに応じてフォーマッターを自動選択

local js_ts_formatters = function(bufnr)
  local has_biome = vim.fs.find({
    "biome.json",
    "biome.jsonc",
  }, { upward = true, path = vim.api.nvim_buf_get_name(bufnr) })[1]

  if has_biome then
    return { "biome" }
  end

  local has_prettier = vim.fs.find({
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
  }, { upward = true, path = vim.api.nvim_buf_get_name(bufnr) })[1]

  if has_prettier then
    return { "prettier", "eslint_d" }
  end

  -- デフォルトはprettier + eslint
  return { "prettier", "eslint_d" }
end

return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      javascript = js_ts_formatters,
      typescript = js_ts_formatters,
      javascriptreact = js_ts_formatters,
      typescriptreact = js_ts_formatters,
      json = js_ts_formatters,
      jsonc = js_ts_formatters,
    },
  },
}
