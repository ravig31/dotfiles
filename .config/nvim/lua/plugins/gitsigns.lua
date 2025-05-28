return {
    'lewis6991/gitsigns.nvim',
    config = function ()
        require('gitsigns').setup{
            on_attach = function(bufnr)

                local gitsigns = require('gitsigns')

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr -- This is correct for buffer-local mappings
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
								map('n', '<leader>gb', gitsigns.blame, { desc = "Gitsigns: Blame Tree"})


                map('n', ']c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({']c', bang = true})
                    else
                        gitsigns.nav_hunk('next')
                    end
                end, { desc = "Gitsigns: Next Hunk" }) -- Adding descriptions is good practice

                map('n', '[c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({'[c', bang = true})
                    else
                        gitsigns.nav_hunk('prev')
                    end
                end, { desc = "Gitsigns: Previous Hunk" })

                -- Actions
                map('n', '<leader>hs', gitsigns.stage_hunk, { desc = "Gitsigns: Stage Hunk" })
                map('n', '<leader>hr', gitsigns.reset_hunk, { desc = "Gitsigns: Reset Hunk" })

                map('v', '<leader>hs', function()
                    gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end, { desc = "Gitsigns: Stage Hunk (Visual)" })

                map('v', '<leader>hr', function()
                    gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end, { desc = "Gitsigns: Reset Hunk (Visual)" })

                map('n', '<leader>hS', gitsigns.stage_buffer, { desc = "Gitsigns: Stage Buffer" })
                map('n', '<leader>hR', gitsigns.reset_buffer, { desc = "Gitsigns: Reset Buffer" })
                map('n', '<leader>hp', gitsigns.preview_hunk, { desc = "Gitsigns: Preview Hunk" })
                map('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = "Gitsigns: Preview Hunk Inline" })

                map('n', '<leader>hb', function()
                    gitsigns.blame_line({ full = true })
                end, { desc = "Gitsigns: Blame Line" })

                map('n', '<leader>hd', gitsigns.diffthis, { desc = "Gitsigns: Diff This" })

                map('n', '<leader>hD', function()
                    gitsigns.diffthis('~')
                end, { desc = "Gitsigns: Diff This (~)" })

                map('n', '<leader>hQ', function() gitsigns.setqflist('all') end, { desc = "Gitsigns: Quickfix List (All)" })
                map('n', '<leader>hq', gitsigns.setqflist, { desc = "Gitsigns: Quickfix List (Current Hunk)" })

                -- Toggles
                map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = "Gitsigns: Toggle Line Blame" })
                map('n', '<leader>tw', gitsigns.toggle_word_diff, { desc = "Gitsigns: Toggle Word Diff" })

                -- Text object
                map({'o', 'x'}, 'ih', gitsigns.select_hunk, { desc = "Gitsigns: Select Hunk (Text Object)" })
            end
        }
    end
}
