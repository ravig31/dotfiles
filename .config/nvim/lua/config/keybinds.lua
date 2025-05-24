vim.g.maplocalleader = "\\"
vim.g.mapleader = " "

-- select all ----
vim.keymap.set('n', '<C-a>', 'ggVG', { noremap = true, silent = true, desc = 'Select All' })
vim.keymap.set('v', '<C-a>', 'ggVG', { noremap = true, silent = true, desc = 'Select All' })

-- yank to clipboard ---
vim.keymap.set('n', '<leader>c', '<Plug>OSCYankOperator')
vim.keymap.set('n', '<leader>cc', '<leader>c_', { remap = true })
vim.keymap.set('v', '<leader>c', '<Plug>OSCYankVisual')

-- source lua
vim.keymap.set('n', '<space><space>x', '<cmd>source %<CR>')
vim.keymap.set('n', '<space>x', ':.lua<CR>')
vim.keymap.set('v', '<space>x', ':.lua<CR>')

