return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- Lazily load this plugin when other Mason/LSP plugins are loaded
    -- Or you can set an explicit event like "VeryLazy" if you want it to run very early
    event = "BufReadPost", -- Or "LspAttach" if you want it to run after an LSP is attached
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "williamboman/mason.nvim",
    },
    build = function()
      -- This ensures that MasonToolsInstall runs after the plugin is installed/updated
      -- and its dependencies are available.
      vim.cmd("MasonToolsInstall")
    end,
    -- Configure mason-tool-installer
    opts = {
      ensure_installed = {
        -- language servers
        "basedpyright",
        "bashls",
        "clangd",
        "cssls",
        "gopls",
        "html-lsp",
        "lua_ls",
        "tailwindcss",
        "ts_ls",

        -- debug adapters
        "codelldb",

        -- formatters
        -- astyle missing
        "biome",
        "clang-format",
        "cmakelang",
        "goimports",
        "prettier",
        "ruff",
        "shfmt",
        "stylua",

        -- linters
        "eslint_d",
        "luacheck",
        "proselint",
        "shellcheck",
      },
    },
  },
  {
    "williamboman/mason.nvim",
    -- It's common to load Mason relatively early, but you can adjust this event
    -- based on when you need Mason's UI or functionality.
    event = "BufReadPre", -- Load Mason before reading any buffer to ensure tools are ready
    opts = {
      ui = {
        border = "single",
      },
      registries = {
        "github:nvim-java/mason-registry",
        "github:mason-org/mason-registry",
      },
    },
  },
  -- You likely already have mason-lspconfig configured in your LazyVim setup,
  -- but if not, here's how you'd add it:
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    -- This plugin usually doesn't need much 'opts' configuration itself,
    -- as it primarily bridges Mason and nvim-lspconfig.
    -- LSP server specific configurations go into nvim-lspconfig setup.
  },
}
