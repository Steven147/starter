-- Go language support: LSP (gopls via system install) + Treesitter

-- Set Go env for gopls (needed when nvim doesn't inherit shell env)
vim.env.GOPROXY = "https://goproxy.cn,direct"
vim.env.GONOSUMDB = "*"

return {
  -- Add gopls to lspconfig (using system-installed gopls, skip mason)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          mason = false, -- use system-installed gopls, skip mason
          settings = {
            gopls = {
              gofumpt = true,
              analyses = {
                unusedparams = true,
              },
            },
          },
        },
      },
    },
  },
  -- Add Go treesitter parser
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "go" })
    end,
  },
}
