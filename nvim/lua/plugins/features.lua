-- features.lua
-- Andrew Barlow
--
-- treats for a more civilized editor

return {

  { -- Which-Key
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,

    opts = {
      groups = { -- prefix names
        {"<leader>b", group = '[B]uffer'},
        {"<leader>g", group = '[G]it'},
        {"<leader>f", group = '[F]ind'},
        {"<leader>w", group = '[W]indow'},
        {"<leader>a", group = '[A]esthetics'},
        {"<leader>s", group = '[S]how Panels'},
        -- {"<leader>/", group = '[C]omment'},
        --{"<leader>h", group = 'Check [H]ealth'},
      },
    },

    config = function(_, opts)
      local wk = require('which-key')
      wk.add(opts.groups)
    end

  },

  -- See `:help gitsigns` to understand what the configuration keys do
  { -- GitSigns: Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  { -- Telescope: adds nice menu to some vim ops
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    requires = { 'nvim-lua/plenary.nvim', },

    config = function()
      require('telescope').setup {
        extensions = {
          fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                             -- the default case_mode is "smart_case"
          }
        }
      }

      -- enable telescope fuzzy finding
      require('telescope').load_extension('fzf')
    end,
  },

  { -- telescope fzf util
    'nvim-telescope/telescope-fzf-native.nvim',
    -- need make, gcc installed, also have versions for cmake
    build = 'make',
  },

  { -- NeoTree: filetree viewer
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
    },

    -- when a directory is passed to vim as an argument, open neotree instead of Ex
    -- https://old.reddit.com/r/neovim/comments/195mfz2/open_only_neotree_when_opening_a_directory/
    init = function()
      if vim.fn.argc(-1) == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))

        if stat and stat.type == "directory" then
          require("neo-tree").setup(
            { filesystem = { hijack_netrw_behavior = "open_current", }, }
          )
        end
      end
    end
  },

  { -- Autopairs
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {}
  },

  {
    "folke/todo-comments.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim",
      "ibhagwan/fzf-lua",
    },
    config = function()
      require('todo-comments').setup()
    end
  },

  { -- Comment
    'numToStr/Comment.nvim', opts = {}, lazy = false,
    config = function()
      require('Comment').setup()
    end
  },

  { -- formatter
    'stevearc/conform.nvim',
    opts = {},
    keys = {
      {
        -- Customize or remove this keymap to your liking
        "<leader>bf",
        function()
          require("conform").format({ async = true })
        end,
        mode = "n",
        desc = "[F]ormat Buffer",
      },
    },

    config = function ()
      require('conform').setup({
        formatters_by_ft = {
          lua = { "stylua" },
          rust = { "rustfmt", lsp_format = "fallback" },
          javascript = { "prettierd", "prettier", stop_after_first = true },
        }
      })
    end

  }
}
