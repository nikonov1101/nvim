return {
    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({
                icons = {},
            })

            vim.keymap.set(
                "n",
                "[t",
                function() require("trouble").next({ skip_groups = true, jump = true }) end,
                { desc = "trouble: next" }
            )

            vim.keymap.set(
                "n",
                "]t",
                function() require("trouble").previous({ skip_groups = true, jump = true }) end,
                { desc = "trouble: prev" }
            )
        end,
    },
}
