return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        local notify = require("fidget")

        harpoon:extend({
            -- notify with a number when file added
            ADD = function(ctx)
                notify.notify(
                    "harpoon: " .. ctx.item.value .. " added.",
                    nil,
                    { group = "harpoon", annote = "key: " .. ctx.idx }
                )
            end,
        })

        vim.api.nvim_create_autocmd("VimLeavePre", {
            -- cleanup on exit
            callback = function() harpoon:list():clear() end,
        })

        harpoon:setup()

        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
        vim.keymap.set("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

        vim.keymap.set("n", "<Leader>1", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<Leader>2", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<Leader>3", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<Leader>4", function() harpoon:list():select(4) end)
        vim.keymap.set("n", "<Leader>5", function() harpoon:list():select(5) end)
        vim.keymap.set("n", "<Leader>6", function() harpoon:list():select(6) end)
        vim.keymap.set("n", "<Leader>7", function() harpoon:list():select(7) end)
    end,
}
