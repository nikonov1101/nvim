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
    vim.api.nvim_set_hl(0, "@lsp.typemod.variable.readonly.go", { link = "Constant" })

    -- make NeoTree match the current theme
    vim.api.nvim_set_hl(0, "gitcommitUntracked", { fg = colors.git_unknown })
    vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = colors.git_unknown })
    vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = colors.git_modified })
    vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = colors.git_added })
    vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = colors.just_white })
    vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { bg = "none", fg = "#151515" })
    vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "#121212" })
    vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "#121212" })
    vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "#121212" })

    -- make current line brighter
    vim.api.nvim_set_hl(0, "CursorLine", { bg = colors.noclown_line })
    vim.api.nvim_set_hl(0, "CursorLineNr", { bg = colors.noclown_line })
    vim.api.nvim_set_hl(0, "@lsp.typemod.variable.readonly.go", { italic = true, fg = "#b46958" })
end

return {
    {
        -- the default one
        "xiantang/darcula-dark.nvim",
        config = function()
            -- vim.cmd.colorscheme("darcula-dark")
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
    },
    {
        -- nice set of themes, give it a try
        "EdenEast/nightfox.nvim",
        config = function()
            require("nightfox").setup({
                options = {
                    styles = {
                        comments = "italic",
                        keywords = "bold",
                        types = "italic,bold",
                    },
                },
            })
            -- or duskfox?
            -- vim.cmd.colorscheme("nightfox")
        end,
    },
    {
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
    },
    {
        "savq/melange-nvim",
        config = function()
            -- vim.cmd.colorscheme("melange")
        end,
    },
    {
        "sainnhe/everforest",
        lazy = false,
        priority = 1000,
        config = function()
            -- Optionally configure and load the colorscheme
            -- directly inside the plugin declaration.
            vim.g.everforest_enable_italic = true
            -- vim.cmd.colorscheme('everforest')
        end,
    },
}
