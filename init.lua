return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "stable", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false, -- automatically quit the current session after a successful update
    remotes = { -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },

  -- Set colorscheme to use
  colorscheme = "catppuccin",

  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
    update_in_insert= false,
  },

  lsp = {
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = false, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- "sumneko_lua",
      },
      timeout_ms = 7000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
    setup_handlers = {
      -- add custom handler
      tsserver = function(_, opts) require("typescript").setup { server = opts } end,
      rust_analyzer = function(_, opts) require("rust-tools").setup { server = opts } end
    },
    -- Add overrides for LSP server settings, the keys are the name of the server
    config = {
      tsserver = {
        init_options = {
          preferences = {
            disableSuggestions = true,
          },
        },
      },
      ["neo-tree"] = {
        enable_diagnostics = true,
      },
    },
  },

  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
  },

  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- remove trailing whitespace
    -- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    --   pattern = { "*" },
    --   command = [[%s/\s\+$//e]],
    -- })
    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
      pattern = { "*.js", "*.vue", "*.ts" },
      command = "EslintFixAll",
    })
    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
      pattern = { "*/locales/**.json" },
      command = "Format",
    })
    vim.api.nvim_set_option("fixendofline", false)
    -- :set nofixeol
  end,
}
