return {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',
   
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        keymap = {
          -- set to 'none' to disable the 'default' preset
          preset = 'none',
          ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
          ['<C-e>'] = { 'hide', 'fallback' },

          ['<Tab>'] = {
            function(cmp)
              if cmp.snippet_active() then return cmp.accept()
              else return cmp.select_and_accept() end
            end,
            'snippet_forward',
            'fallback'
          },
          ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

          ['<Up>'] = { 'select_prev', 'fallback' },
          ['<Down>'] = { 'select_next', 'fallback' },
          ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
          ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
        },
        appearance = {
            nerd_font_variant = 'mono'
        },

        completion = { documentation = { auto_show = false } },

        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },

        fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
}
