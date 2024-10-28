local hi = vim.api.nvim_set_hl

local colors = {
    just_white = "#ffffff",
    medium_gray = "#6C6C6C",
    git_added = "#629755",
    git_modified = "#6897BB",
    git_unknown = "#D1675A",
}

-- // TODO(nikonov): move to neotree.lua
hi(0, "gitcommitUntracked", { fg = colors.git_unknown })
hi(0, "NeoTreeGitUntracked", { fg = colors.git_unknown })
hi(0, "NeoTreeGitModified", { fg = colors.git_modified })
hi(0, "NeoTreeGitAdded", { fg = colors.git_added })
hi(0, "NeoTreeDirectoryName", { fg = colors.just_white })

-- return {
--     'sainnhe/everforest',
--     lazy = false,
--     priority = 1000,
--     config = function()
--         -- Optionally configure and load the colorscheme
--         -- directly inside the plugin declaration.
--         vim.g.everforest_enable_italic = true
--         vim.cmd.colorscheme('everforest')
--     end
-- }

-- return {
--     "savq/melange-nvim",
--     config = function()
--         vim.cmd.colorscheme("melange")
--     end
-- }

-- return {
--     'rmehri01/onenord.nvim',
--     config = function()
--         require('onenord').setup({
--             theme = "dark", -- "dark" or "light". Alternatively, remove the option and set vim.o.background instead
--             borders = true,
--             fade_nc = true,
--             styles = {
--             }
--
--         })
--         vim.cmd.colorscheme("onenord")
--     end,
-- }

return {
    "xiantang/darcula-dark.nvim",
    config = function()
        vim.cmd.colorscheme("darcula-dark")
    end,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
}
