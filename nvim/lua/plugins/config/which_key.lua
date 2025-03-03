return {

  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,

  opts = {
    ---@type false | "classic" | "modern" | "helix"
    preset = "classic",

    -- local order group alphanum mod
    sort = "local",
    groups = { -- prefix names
      {"<leader>b", group = '[B]uffer'},
      {"<leader>g", group = '[G]it'},
      {"<leader>f", group = '[F]ind'},
      {"<leader>w", group = '[W]indow'},
      {"<leader>a", group = '[A]esthetics'},
      {"<leader>s", group = '[S]how Panels'},
      {"<leader>m", group = '[M]arks'},
      {"<leader>p", group = '[P]lugins'},
      {"<leader>r", group = '[R]un'},
      -- {"<leader>/", group = '[C]omment'},
      --{"<leader>h", group = 'Check [H]ealth'},
    },
  },

  config = function(_, opts)
    local wk = require('which-key')
    wk.add(opts.groups)
  end,

}
