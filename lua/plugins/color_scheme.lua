local colors = {
    just_white = "#ffffff",
    medium_gray = "#6C6C6C",
    git_added = "#629755",
    git_modified = "#6897BB",
    git_unknown = "#D1675A",
    noclown_line = "#2a2a2a",
}

local function repaint()
    -- go constant and constant usage must match
    vim.api.nvim_set_hl(0, "@lsp.typemod.variable.readonly.go", { italic = true, fg = "#b46958" })

    -- make NeoTree match the current theme
    vim.api.nvim_set_hl(0, "gitcommitUntracked", { fg = colors.git_unknown })

    -- https://github.com/sindrets/diffview.nvim/blob/main/lua/diffview/hl.lua#L388
    vim.api.nvim_set_hl(0, "DiffviewStatusUntracked", { fg = colors.git_unknown })
    vim.api.nvim_set_hl(0, "DiffviewStatusModified", { fg = colors.git_modified })
    vim.api.nvim_set_hl(0, "DiffviewStatusAdded", { fg = colors.git_added })

    vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = colors.git_unknown })
    vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = colors.git_modified })
    vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = colors.git_added })
    vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = colors.just_white })
    vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { bg = "none", fg = "#151515" })
    vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "#121212" })
    vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "#121212" })
    vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "#121212" })

    vim.api.nvim_set_hl(0, "SpellBad", { bg = "#680d0f" })
    vim.api.nvim_set_hl(0, "SpellCap", { bg = "#680d0f" })
    vim.api.nvim_set_hl(0, "SpellRare", { bg = "#680d0f" })
    vim.api.nvim_set_hl(0, "SpellLocal", { bg = "#680d0f" })

    -- make Flash jump label more distinguishable
    vim.api.nvim_set_hl(0, "FlashLabel", { bold = true, bg = "#0000aa" })

    -- make current line brighter
    vim.api.nvim_set_hl(0, "CursorLine", { bg = colors.noclown_line })
    vim.api.nvim_set_hl(0, "CursorLineNr", { bg = colors.noclown_line })
    vim.api.nvim_set_hl(0, "User1", { fg = colors.medium_gray, bg = "none" })

    vim.api.nvim_set_hl(0, "@comment.todo", { link = "@keyword" })
    vim.api.nvim_set_hl(0, "@comment.warning", { fg = "#ab8550", bold = true })
    vim.api.nvim_set_hl(0, "@comment.error", { fg = "#984936", bold = true })
    vim.api.nvim_set_hl(0, "@comment.note", { fg = "#afafaf", bold = true })
end

return {
    "aktersnurra/no-clown-fiesta.nvim",
    priority = 999,
    lazy = false,
    config = function()
        local plugin = require("no-clown-fiesta")
        plugin.setup({
            styles = {
                keywords = { bold = true },
                type = { bold = true },
                lsp = { underline = false },
                match_paren = { underline = true },
                comments = {},
                functions = {},
                variables = {},
            },
        })
        plugin.load()
        vim.cmd.colorscheme("no-clown-fiesta")
        repaint()
    end,
}
