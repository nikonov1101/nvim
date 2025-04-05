vim.o.sessionoptions = "blank,curdir,folds,tabpages,winsize,winpos"

return {
    "rmagatti/auto-session",
    lazy = false,

    keys = {
        { "<leader><leader>s", "<cmd>Autosession delete<CR>", desc = "delete session" },
    },

    opts = {
        suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    },
}
