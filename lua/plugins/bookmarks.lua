return {
    'tomasky/bookmarks.nvim',
    -- after = "telescope.nvim",
    event = "VimEnter",
    config = function()
        require('bookmarks').setup({
            signcolumn = false,
            numhl = true,
            signs = {
                add = { hl = "BookMarksAdd", text = "@", numhl = "#fafa00", linehl = "BookMarksAddLn" },
                ann = { hl = "BookMarksAnn", text = "#", numhl = "BookMarksAnnNr", linehl = "BookMarksAnnLn" },
            },
            keywords = { ["!!"] = "!", ["??"] = "?", },
            on_attach = function(_)
                local bm = require "bookmarks"
                local map = vim.keymap.set
                map("n", "mm", bm.bookmark_toggle)                  -- add or remove bookmark at current line
                map("n", "mi", bm.bookmark_ann)                     -- add or edit mark annotation at current line
                map("n", "mc", bm.bookmark_clean)                   -- clean all marks in local buffer
                map("n", "]b", bm.bookmark_next)                    -- jump to next mark in local buffer
                map("n", "[b", bm.bookmark_prev)                    -- jump to previous mark in local buffer
                map("n", "mo", "<cmd>Telescope bookmarks list<cr>") -- show marked file list in quickfix window
            end
        })
        require('telescope').load_extension('bookmarks')
    end
}
