vim.g.maplocalleader = "\\"
vim.g.mapleader = " "

-- Duplicate line(s) --
vim.keymap.set('n', '<M-S-j>', 'yyP', { noremap = true, silent = true, desc = "Duplicate current line down" })
vim.keymap.set('v', '<M-S-j>', 'yP', { noremap = true, silent = true, desc = "Duplicate selected lines down" })

-- Move line(s) up -- 
vim.keymap.set('n', '<M-k>', ':m .-2<CR>==', { noremap = true, silent = true, desc = "Move current line up" })
vim.keymap.set('v', '<M-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move selected lines up" })

-- Move line(s) down --
vim.keymap.set('n', '<M-j>', ':m .+1<CR>==', { noremap = true, silent = true, desc = "Move current line down" })
vim.keymap.set('v', '<M-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move selected lines down" })


-- select all --
vim.keymap.set('n', '<C-a>', 'ggVG', { noremap = true, silent = true, desc = 'Select All' })
vim.keymap.set('v', '<C-a>', 'ggVG', { noremap = true, silent = true, desc = 'Select All' })

-- yank to clipboard --
vim.keymap.set('n', '<C-c>', '<Plug>OSCYankOperator')
vim.keymap.set('n', '<leader>cc', '<leader>c_', { remap = true })
vim.keymap.set('v', '<C-c>', '<Plug>OSCYankVisual')

-- source lua -- 
vim.keymap.set('n', '<space><space>x', '<cmd>source %<CR>')
vim.keymap.set('n', '<space>x', ':.lua<CR>')
vim.keymap.set('v', '<space>x', ':.lua<CR>')

-- quickfix -- 
vim.keymap.set('n', '<M-n>', '<cmd>cnext<CR>')
vim.keymap.set('n', '<M-p>', '<cmd>cprev<CR>')

-- terminal --
vim.api.nvim_create_autocmd('TermOpen', {
	group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.cmd('startinsert')
	end
})

vim.keymap.set('n', '<leader>st', function()
		vim.cmd.vnew()
		vim.cmd.term()
end, { desc = 'Open vertical split terminal'})

vim.keymap.set('t', '<esc><esc>', '<C-\\><C-n>', { desc = "Shorcut for returning to normal mode in terminal"})

-- oil --
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
