vim.o.sessionoptions = "blank,curdir,folds,help,tabpages,winsize,winpos,localoptions,options"

return {
    "rmagatti/auto-session",
    lazy = false,

    keys = {
        { "<leader><leader>s", "<cmd>Autosession delete<CR>", desc = "delete session" },
    },

    opts = {},
}
