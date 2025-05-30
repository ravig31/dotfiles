local state = {
	floating = {
		win = nil,
		buf = nil,
	}
}

local function floatty(opts)
	opts = opts or {}

	-- Calculate default dimensions (80% of screen)
	local width = opts.width or math.floor(vim.o.columns * 0.4)
	local height = opts.height or math.floor(vim.o.lines * 0.4)

	-- Calculate position for centering
	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)

	-- Create a new buffer for the floating window content
	-- This buffer will be temporary and not associated with a file on disk
	local buf = nil
	if opts.buf and vim.api.nvim_buf_is_valid(opts.buf) then
		buf = opts.buf
	else
		buf = vim.api.nvim_create_buf(false, true)
	end

	-- Define the window configuration
	local win_config = {
		relative = 'editor',
		row = row,
		col = col,
		width = width,
		height = height,
		border = 'rounded',
		anchor = 'NW',
		style = 'minimal',
		focusable = true,
	}

	local win = vim.api.nvim_open_win(buf, true, win_config)

	return {buf = buf, win = win}
end

local toggle_floatty = function()
  -- toggle hide
	if state.floating.win and vim.api.nvim_win_is_valid(state.floating.win) then
		vim.api.nvim_win_hide(state.floating.win)
	else -- toggle show
		state.floating = floatty { buf = state.floating.buf}
		if vim.bo[state.floating.buf].buftype ~= "terminal" then
				vim.cmd.term()
		end
	end
end

vim.api.nvim_create_user_command("Floatty", toggle_floatty, {})
vim.keymap.set({'n', 't'}, '<leader>ft', toggle_floatty)

return {}
