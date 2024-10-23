local function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

local function last_playground_num(root_dir)
    local Path = require("plenary.path")
    local Scan = require("plenary.scandir")

    -- create playground dir if not exists
    local root_path = Path:new(root_dir)
    if not root_path:exists() then
        print("path does not exists, creating...")
        root_path:mkdir()
    end

    -- count existing playgrounds
    local play_dirs = Scan.scan_dir(root_dir, { hidden = false, depth = 1, only_dirs = true })
    return tablelength(play_dirs)
end

local default_dir = "/Users/alex/src/go-playground"

function create_playground(playroot)
    local Path = require("plenary.path")

    local root_dir = playroot or default_dir
    local num = last_playground_num(root_dir)

    local next_dir = root_dir .. string.format("/play-%04d", num + 1)

    Path:new(next_dir):mkdir()
    local main_go = Path:new(next_dir .. "/main.go")
    main_go:write("package main\n\nfunc main() {\n\n}\n", "a")
    return main_go:absolute()
end

function last_playground(playroot)
    local root_dir = playroot or default_dir
    local num = last_playground_num(root_dir)
    return root_dir .. string.format("/play-%04d/main.go", num)
end
