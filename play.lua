-- print lua table
function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            s = s .. '[' .. k .. '] = ' .. dump(v) .. ', '
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

-- todo: do we need a "tools" package?
local function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

-- print(vim.fn.fnamemodify(vim.fn.getcwd(), ":t"))
-- print(vim.fn.stdpath("data"))
