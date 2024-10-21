local n = require("fidget")

n.notify("text", nil, { annote = "annotation", key = "keystr1" })
n.notify("text1", nil, { annote = "annotation", key = "keystr2" })
n.notify("text2", nil, { annote = "annotation", key = "keystr3" })
n.notify("text4", nil, { annote = "annotation", key = "keystr4" })
n.notify("... and overwriting notifications.", vim.log.levels.WARN, { annote = "YOUR AD HERE" })

-- n.notify(nil, vim.log.levels.ERROR, { annote = "bottom text", key = "foobar" })
