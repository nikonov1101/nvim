vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

return {
    'rmagatti/auto-session',
    lazy = false,

    keys = {
        { "<leader>Sa", "<cmd>SessionSave<CR>",        desc = "save session" },
        { "<leader>Sl", "<cmd>SessionSearch<CR>",      desc = "search session" },
        { "<leader>Sd", "<cmd>Autosession delete<CR>", desc = "delete session" },
    },

    opts = {}
}
