return {
    "ckipp01/stylua-nvim",
    config = function()
        require("stylua-nvim").setup()

        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.lua",
            callback = function() require("stylua-nvim").format_file() end,
        })
    end,
}
