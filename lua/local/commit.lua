local Popup = require("nui.popup")
local tools = require("tools")

-- todo: setup !cmd as well?
-- OR do so in the git plugin file
local M = {}
function M.show()
    local branch = tools.git_branch()
    local stats = tools.git_shortstat()
    local bottom_text = " on branch: " .. branch .. ";" .. stats .. " "

    local popup = Popup({
        position = "50%",
        size = {
            width = "60%",
            height = "30%",
        },
        enter = true,
        focusable = false,
        zindex = 50,
        relative = "editor",
        border = {
            padding = {
                top = 0,
                bottom = 0,
                left = 1,
                right = 1,
            },
            style = "single",
            text = {
                top = " Git Commit ",
                top_align = "center",
            },
        },
        buf_options = {
            modifiable = true,
            readonly = false,
        },
    })
    popup:map("n", "<esc>", function() popup:unmount() end)
    popup:on({ "BufWinEnter", "BufEnter" }, function() vim.cmd.startinsert() end)
    popup:on("BufLeave", function()
        local function all_trim(s) return s:match("^%s*(.-)%s*$") end
        local lines = vim.api.nvim_buf_get_lines(0, 0, vim.api.nvim_buf_line_count(0), false)

        if string.len(lines[1]) > 0 then
            local msg = all_trim(table.concat(lines, "\n"))
            local results = vim.system({ "git", "commit", "-m", msg }, { text = true }):wait()
            vim.notify(results.stdout, vim.log.levels.INFO, { title = "Commit" })
        else
            vim.notify("aborting commit", vim.log.levels.WARN, { title = "Commit" })
        end

        popup:unmount()
    end, { once = true })

    popup:mount()
    popup.border:set_text("bottom", bottom_text, "left")
end
return M
