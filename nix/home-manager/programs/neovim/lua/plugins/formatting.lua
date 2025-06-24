-- lua/plugins/format-js.lua
return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      javascript = { "prettier", "eslint_d" },
      typescript = { "prettier", "eslint_d" },
    },
  },
}
