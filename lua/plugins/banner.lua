return {
  "goolord/alpha-nvim",
  opts = function(_, opts)
    -- customize the dashboard header
    opts.section.header.val = {
      -- "            Stop the dick. ",
      -- "            I want to get off.",
      -- "                       \\",
      -- "          ",
      "                -      #####       .|||||.",
      "                      ####  \\_    |||||||||",
      "                      ##=-[.].]  ||||||  .",
      "                 --   #(    _\\   ||||||   >",
      "                       #   __|  ||||||| -/",
      "                -      _\\   /   ||||||'(",
      "                      (  `-'|   .'      \\",
      "                     / \\  \\/_.-'    | | |",
      "                    /   \\____|_)     \\ \\ ",
      "              --   |-----.._      `---:.`.\\",
      "             ______(_____   )          \\_\\____ ,--.__",
      "  --    ,--\"\"           /  / `-   .     |)_)    '\\     '\\",
      "       /  \"            /  /   .-'     /          \\      '\\",
      "     ,/               /__/           .'            '\\     |",
      '     | "   "   "     [____)         /                \'\\,  /',
      '     |           " , =_____`-.   .-\'_________________,--""',
      '   - |  "    "    /"/\'      /\\>-\' ( <',
      '     \\  "      ",/ /    -  ( <    |\\_)',
      '      \\   ",",_/,-\'        |\\_)',
      "   -- -'-;.__:-'                    vk/lament/dp",
    }

    local da = require "alpha.themes.dashboard"
    opts.section.buttons.val = {
      da.button("e", "  New file", ":ene <CR>"),
      da.button("r", "  Recent", ":Telescope oldfiles<CR>"),
      da.button("m", "  Bookmarks", ":BookmarksGoto<cr>"),
    }
    return opts
  end,
}
