-- JavaScript/TypeScript support: LSP (ts_ls) + Treesitter

return {
  -- Add ts_ls to lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ts_ls = {},
      },
    },
  },
  -- Add JS/TS treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "javascript", "typescript", "jsdoc" })
    end,
  },
}
