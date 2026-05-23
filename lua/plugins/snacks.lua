-- Search hidden files by default in Snacks picker.

return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = {
            hidden = true,
          },
          grep = {
            hidden = true,
          },
          grep_word = {
            hidden = true,
          },
        },
      },
    },
  },
}
