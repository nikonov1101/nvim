local t = require("tools")
-- print(t.dump_table(t))

local r = {
    "a",
    "b",
}

print(table.concat(r, ", "))

-- require("local.gitc").show()
-- print(tools.dump_table(tools))
-- local t = { "qwe", "rty", "foo", "bar" }
-- print(tools.dump_table(t))
-- print(tools.len_of(t))
-- print(tools.cwd_basename())
-- print(tools.dump_table(vim.loop.os_uname().sysname))
