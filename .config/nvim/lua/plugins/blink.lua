return {
    'saghen/blink.cmp',
		cond = not vim.g.vscode,
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
				signature = { enabled = true },
        keymap = {
						preset = "super-tab"
				},
        appearance = {
            nerd_font_variant = 'mono'
        },

        completion = {
						documentation = { auto_show = false }
				},

        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },

        fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
}
