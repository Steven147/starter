-- Replace neo-tree with yazi file manager

return {
  -- Disable neo-tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },
  -- Add yazi.nvim
  {
    "mikavilpas/yazi.nvim",
    keys = {
      { "<leader>fy", "<cmd>Yazi<cr>", desc = "Open Yazi (cwd)" },
      { "<leader>fY", "<cmd>Yazi cwd=%:p<cr>", desc = "Open Yazi (buffer dir)" },
    },
    opts = {
      open_for_directories = true, -- use yazi instead of netrw for :e
    },
  },
}
