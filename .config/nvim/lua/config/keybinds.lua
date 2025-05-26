vim.g.maplocalleader = "\\"
vim.g.mapleader = " "

-- Duplicate line(s)
vim.keymap.set('n', '<A-S-j>', 'yyP', { noremap = true, silent = true, desc = "Duplicate current line down" })
vim.keymap.set('v', '<A-S-j>', 'yP', { noremap = true, silent = true, desc = "Duplicate selected lines down" })

-- Move line(s) up
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { noremap = true, silent = true, desc = "Move current line up" })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move selected lines up" })

-- Move line(s) down
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { noremap = true, silent = true, desc = "Move current line down" })
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move selected lines down" })


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
