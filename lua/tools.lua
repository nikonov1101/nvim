local M = {}

function M.dump_table(t)
    if type(t) == "table" then
        local s = "{ "
        for k, v in pairs(t) do
            if type(k) ~= "number" then k = "\"" .. k .. "\"" end
            s = s .. "[" .. k .. "] = " .. M.dump_table(v) .. ", "
        end
        return s .. "} "
    else
        return tostring(t)
    end
end

function M.len_of(t)
    local count = 0
    for _ in pairs(t) do
        count = count + 1
    end
    return count
end

function M.cwd_basename()
    -- :t truncates the given CWD to a last segment,
    -- which is often used as a project name.
    return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

function M.keymap_opts(s)
    local ta = { noremap = true, silent = true }
    if s ~= "" then ta["desc"] = s end
    return ta
end

function M.git_branch()
    local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
    if string.len(branch) > 0 then
        return branch
    else
        return "[no git]"
    end
end

function M.git_shortstat()
    local s = vim.fn.system("git diff --shortstat HEAD | sed -e 's/insertions/ins/;s/deletions/del/' | tr -d '\n'")
    if string.len(s) > 0 then
        return s
    else
        return "???"
    end
end

return M
