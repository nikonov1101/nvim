return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require('gitsigns').setup({
            on_attach = function(bufnr)
                local gitsigns = require('gitsigns')

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']g', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ ']g', bang = true })
                    else
                        gitsigns.nav_hunk('next')
                    end
                end)

                map('n', '[g', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ '[g', bang = true })
                    else
                        gitsigns.nav_hunk('prev')
                    end
                end)

                -- view with telescope, V for VCS
                local tele = require("telescope.builtin")
                map('n', '<leader>vl', tele.git_bcommits, { desc = "git log (buffer)" })
                map('n', '<leader>vL', tele.git_commits, { desc = "git log (all)" })
                map('n', '<leader>vb', tele.git_branches, { desc = "git branches" })
                map('n', '<leader>vs', tele.git_status, { desc = "git status" })

                -- Actions
                map('n', '<leader>gs', gitsigns.stage_hunk, { desc = "stage hunk" })
                map('n', '<leader>gr', gitsigns.reset_hunk, { desc = "reset hunk" })
                map('v', '<leader>gs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                    { desc = "stage hunk" })
                map('v', '<leader>gr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                    { desc = "reset hunk" })
                map('n', '<leader>gS', gitsigns.stage_buffer, { desc = "stage buffer" })
                map('n', '<leader>gR', gitsigns.reset_buffer, { desc = "reset buffer" })
                map('n', '<leader>gp', gitsigns.preview_hunk, { desc = "preview hunk" })
                map('n', '<leader>gb', function() gitsigns.blame_line { full = false } end, { desc = "blame line" })
                map('n', '<leader>gB', gitsigns.toggle_current_line_blame, { desc = "toggle blame" })
                map('n', '<leader>gd', gitsigns.diffthis, { desc = "diff this" })
                map('n', '<leader>gD', function() gitsigns.diffthis('~') end, { desc = "diff this" })

                -- Text object
                map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
            end
        })
    end
}
