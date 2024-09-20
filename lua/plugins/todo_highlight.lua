return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    keywords = {
      FIX = {
        icon = "󰖷", -- icon used for the sign, and in search results
        color = "error", -- can be a hex color, or a named color (see below)
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "fix", "fixme", "bug", "fixit", "issue" }, -- a set of other keywords that all map to this FIX keywords
        -- signs = false, -- configure signs for some keywords individually
      },
      TODO = { icon = "", color = "todo", alt = { "todo" } },
      HACK = { icon = " ", color = "warning", alt = { "hack" } },
      WARN = { icon = " ", color = "warning", alt = { "warn", "XXX", "xxx" } },
      NOTE = { icon = "󱞀", color = "todo", alt = { "note", "note", "INFO" } },
    },
    colors = {
      todo = { "DiagnosticWarn" },
      error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
      warning = { "#FBBF24", "DiagnosticWarn", "WarningMsg" },
    },
    highlight = {
      keyword = "bg",
      pattern = [[.*<(KEYWORDS)\(?.*\)?:]],
    },
  },
}
