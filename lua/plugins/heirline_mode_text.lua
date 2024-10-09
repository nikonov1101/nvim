return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astroui.status"
    opts.statusline = { -- statusline
      hl = { fg = "fg", bg = "bg" },
      status.component.mode {
        mode_text = { padding = { left = 1, right = 1 } },
      }, -- add the mode text
      status.component.git_branch(),
      status.component.git_diff(),
      status.component.diagnostics(),
      status.component.fill(),
      status.component.cmd_info(),
      status.component.fill(),
      -- status.component.lsp(),
      -- status.component.treesitter(),

      -- directory info
      status.component.file_info {
        hl = {
          fg = "#fac000",
          bold = true,
          force = true,
          -- this does not work by some reason
          bg = "#FF00FF",
        },
        provider = status.provider.filename {
          fallback = "",
          fname = function() return vim.fn.fnamemodify(vim.fn.getcwd(), ":t") end,
          modify = false,
        },
        filetype = false,
        file_icon = false,
      },
      -- the actual file name, related to a project dir
      status.component.file_info {
        provider = status.provider.filename {
          fallback = "[none]",
          fname = function() return vim.fn.expand "%:." end,
          modify = false,
        },
        filetype = false,
        file_icon = false,
      },
      status.component.nav {
        scrollbar = false,
      },
    }
  end,
}
