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
    end,
  },
}
