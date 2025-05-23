return {
  -- nvim-lspconfig plugin definition
  'neovim/nvim-lspconfig',
  dependencies = {
    'mason-org/mason.nvim',
    'mason-org/mason-lspconfig.nvim',
  },

  -- All setup and configuration for nvim-lspconfig, mason, and mason-lspconfig
  -- must go inside a 'config' function.
  config = function()
    -- 1. Setup Mason (usually configured once globally, but can be done here if you prefer)
    require('mason').setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    })

    -- 2. Setup Mason-LSPConfig
    require('mason-lspconfig').setup({
      -- A list of servers to automatically install if they're not already installed
      ensure_installed = { 'pylsp', 'lua_ls', 'clangd' },
    })

    -- Set different settings for different languages' LSP
    -- LSP list: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    -- How to use setup({}): https://github.com/neovim/nvim-lspconfig/wiki/Understanding-setup-%7B%7D
    --    - the settings table is sent to the LSP
    --    - on_attach: a lua callback function to run after LSP attaches to a given buffer
    local lspconfig = require('lspconfig')

    -- Customized on_attach function
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    local opts = { noremap = true, silent = true }
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
      -- Enable completion triggered by <c-x><c-o>
---@diagnostic disable-next-line: deprecated
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local bufopts = { noremap = true, silent = true, buffer = bufnr }
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
      vim.keymap.set('n', '<C-j>', vim.lsp.buf.signature_help, bufopts)
      vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
      vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
      vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, bufopts)
      vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
      vim.keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })
      end, bufopts)
    end

    -- Configure each language
    -- How to add LSP for a specific language?
    -- 1. use `:Mason` to install corresponding LSP
    -- 2. add configuration below
    lspconfig.pylsp.setup({
      on_attach = on_attach,
    })

    -- Example for lua_ls
    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
          },
          telemetry = {
            enable = false,
          },
        },
      },
    })

    -- Example for clangd (often needs specific compile_commands.json setup)
    lspconfig.clangd.setup({
      on_attach = on_attach,
      -- cmd = { "clangd", "--background-index" }, -- Example of custom command
    })
  end,
}
