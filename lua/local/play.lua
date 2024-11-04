local M = {}

local playground_dir = "/tmp/"

-- TODO: probably move to utils
local function tablelength(T)
    local count = 0
    for _ in pairs(T) do
        count = count + 1
    end
    return count
end

local function last_playground_num()
    local Path = require("plenary.path")
    local Scan = require("plenary.scandir")

    -- create playground dir if not exists
    local root_path = Path:new(playground_dir)
    if not root_path:exists() then
        print("path does not exists, creating...")
        root_path:mkdir()
    end

    -- count existing playgrounds
    local play_dirs = Scan.scan_dir(playground_dir, { hidden = false, depth = 1, only_dirs = true })
    return tablelength(play_dirs)
end

function M.create_playground()
    local Path = require("plenary.path")

    local num = last_playground_num()
    local next_dir = playground_dir .. string.format("/play-%04d", num + 1)

    Path:new(next_dir):mkdir()
    local main_go = Path:new(next_dir .. "/main.go")
    main_go:write("package main\n\nfunc main() {\n\n}\n", "a")
    return main_go:absolute()
end

function M.last_playground()
    local num = last_playground_num()
    return playground_dir .. string.format("/play-%04d/main.go", num)
end

function M.setup(local_dir)
    -- todo: check that dir exists
    playground_dir = local_dir and local_dir or playground_dir
end

return M
