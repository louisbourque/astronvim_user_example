return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  -- show function name at the top
  -- {
  --   "nvim-treesitter/nvim-treesitter-context",
  --   lazy = false
  -- },
  {
    "ur4ltz/surround.nvim",
    config = function() require("surround").setup { mappings_style = "surround" } end,
    lazy = false
  },
  {
    "tzachar/cmp-tabnine",
    build = './install.sh',
    dependencies = 'hrsh7th/nvim-cmp',
    lazy = false
  },
  {
    "Exafunction/codeium.vim",
    -- config = function()
      -- Change '<C-g>' here to any keycode you like.
      -- vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end, { expr = true })
      -- vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
      -- vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
      -- vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
      --
    -- end,
    lazy = false
  },
  -- tsserver
  {
    "jose-elias-alvarez/typescript.nvim",
    {
      "williamboman/mason-lspconfig.nvim",
      opts = {
        ensure_installed = { "tsserver" },     -- automatically install lsp
      },
    },
  },
  {
    "simrat39/rust-tools.nvim",
    {
      "williamboman/mason-lspconfig.nvim",
      opts = {
        ensure_installed = { "rust_analyzer" },
      },
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup()
    end,
  },
  {
    -- override nvim-autopairs plugin
    "hrsh7th/nvim-cmp",
    -- override the options table that is used in the `require("cmp").setup()` call
    opts = function(_, opts)
      -- opts parameter is the default options table
      -- the function is lazy loaded so cmp is able to be required
      local cmp = require "cmp"
      -- modify the sources part of the options table
      opts.sources = cmp.config.sources {
        { name = "nvim_lsp",    priority = 1000 },
        { name = "cmp_tabnine", priority = 800 },
        { name = "luasnip",     priority = 750 },
        { name = "buffer",      priority = 500 },
        { name = "path",        priority = 250 },
      }
        -- modify the mapping part of the table
        opts.mapping["<Tab>"] = nil

      -- return the new table to be used
      return opts
    end,
  },
}
