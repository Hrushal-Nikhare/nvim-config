local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  {
    "Pocco81/auto-save.nvim",
    event = "InsertEnter",
  },

  {
    "andweeb/presence.nvim",
    event = "InsertEnter",
  },

  { "m4xshen/autoclose.nvim", event = "InsertEnter" },

  { "windwp/nvim-ts-autotag", ft = "html,css,js", config = true },

  {
    "hrsh7th/nvim-cmp",
    override_options = {
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "nvim_lua" },
        { name = "path" },
        { name = "emmet_vim" },
      },
    },
  },

  { "dcampos/cmp-emmet-vim", ft = "html,css,js" },

  { "mattn/emmet-vim", ft = "html,css,js" },

 -- {
 --   "Exafunction/codeium.vim",
 --   event = "InsertEnter",
  --  config = function()
  --    -- Change '<C-g>' here to any keycode you like.
  --    vim.keymap.set("i", "<Space>", function()
  --      return vim.fn["codeium#Accept"]()
   --   end, { expr = true })
   --   vim.keymap.set("i", "<c-;>", function()
  --      return vim.fn["codeium#CycleCompletions"](1)
  --    end, { expr = true })
  --    vim.keymap.set("i", "<c-,>", function()
  --      return vim.fn["codeium#CycleCompletions"](-1)
  --    end, { expr = true })
  --    vim.keymap.set("i", "<c-x>", function()
  --      return vim.fn["codeium#Clear"]()
  --    end, { expr = true })
  --  end,
  --},
  -- Override plugin definition options
  { "romgrk/fzy-lua-native" },

  {
    "gelguy/wilder.nvim",
    lazy = false,
    config = function()
      local wilder = require "wilder"
      wilder.setup { modes = { ":", "/", "?" } }

      wilder.set_option(
        "renderer",
        wilder.popupmenu_renderer(wilder.popupmenu_palette_theme {
          -- 'single', 'double', 'rounded' or 'solid'
          -- can also be a list of 8 characters, see :h wilder#popupmenu_palette_theme() for more details
          border = "rounded",
          max_height = "75%", -- max height of the palette
          min_height = 0, -- set to the same as 'max_height' for a fixed height window
          prompt_position = "top", -- 'top' or 'bottom' to set the location of the prompt
          reverse = 0, -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
        })
      )
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
      {
        "williamboman/mason.nvim",
        config = function(_, opts)
          dofile(vim.g.base46_cache .. "mason")
          require("mason").setup(opts)
          vim.api.nvim_create_user_command("MasonInstallAll", function()
            vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
          end, {})
          require "custom.configs.lspconfig" -- Load in lsp config
        end,
      },
      "williamboman/mason-lspconfig.nvim",
    },
    config = function() end, -- Override to setup mason-lspconfig
  },

  -- overrde plugin configs
  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- Uncomment if you want to re-enable which-key
  -- {
  --   "folke/which-key.nvim",
  --   enabled = true,
  -- },
}

return plugins
