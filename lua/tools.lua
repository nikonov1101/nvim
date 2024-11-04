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

function M.cwd_basename() return vim.fn.fnamemodify(vim.fn.getcwd(), ":t") end

function M.keymap_opts(s)
    local ta = { noremap = true, silent = true }
    if s ~= "" then ta["desc"] = s end
    return ta
end

return M
