local tools = require("lua.tools")
print(tools.dump_table(tools))

local t = { "qwe", "rty", "foo", "bar" }
print(tools.dump_table(t))
print(tools.len_of(t))
print(tools.cwd_basename())
