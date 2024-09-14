local hi = vim.api.nvim_set_hl

local color = {
  medium_gray = "#a81212",
}

hi(0, "gitcommitUntracked", { fg = color.medium_gray })
hi(0, "NeoTreeGitUntracked", { fg = color.medium_gray })

return {
  "xiantang/darcula-dark.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
}
