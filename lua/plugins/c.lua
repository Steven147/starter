-- C/C++ support: LSP (clangd via system install) + Treesitter

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          mason = false,
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "c", "cpp" })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    optional = true,
    opts = function(_, opts)
      opts.automatic_installation = opts.automatic_installation or {}

      if opts.automatic_installation == true then
        opts.automatic_installation = { exclude = { "codelldb" } }
        return
      end

      local exclude = opts.automatic_installation.exclude or {}
      if not vim.tbl_contains(exclude, "codelldb") then
        table.insert(exclude, "codelldb")
      end
      opts.automatic_installation.exclude = exclude
    end,
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      local dap = require("dap")
      local lldb_dap = vim.fn.exepath("lldb-dap")

      if lldb_dap == "" then
        lldb_dap = "/Applications/Xcode.app/Contents/Developer/usr/bin/lldb-dap"
      end

      dap.adapters.codelldb = {
        type = "executable",
        command = lldb_dap,
        name = "lldb",
      }

      if vim.fn.filereadable(lldb_dap) == 0 then
        vim.notify("lldb-dap not found: " .. lldb_dap, vim.log.levels.WARN)
      end

      for _, lang in ipairs({ "c", "cpp" }) do
        dap.configurations[lang] = {
          {
            type = "codelldb",
            request = "launch",
            name = "Launch file",
            program = function()
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
          },
          {
            type = "codelldb",
            request = "attach",
            name = "Attach to process",
            pid = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
        }
      end
    end,
  },
}
