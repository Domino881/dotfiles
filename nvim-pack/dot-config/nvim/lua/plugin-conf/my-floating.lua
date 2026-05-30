local function longest_line_in_buf(bufnr)
	local lines = vim.fn.getbufline(bufnr, 0, "$")
	local max_len = 0
	for _, line in pairs(lines) do
		if line:match("%a") and vim.fn.strchars(line) > max_len then
			max_len = vim.fn.strchars(line)
		end
	end
	return max_len
end

local orig_open_floating_preview = vim.lsp.util.open_floating_preview
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
	opts = opts or {}
	opts.max_height = 25
	opts.max_width = math.min(vim.o.columns, 100)
	opts.wrap = false

	-- Capture cursor screen position BEFORE the preview opens
	local screen_row = vim.fn.screenpos(0, vim.fn.line("."), vim.fn.col(".")).row
	local space_above = screen_row - 1
	local space_below = vim.o.lines - screen_row

	local bufnr, winnr = orig_open_floating_preview(contents, syntax, opts, ...)

	if winnr and vim.api.nvim_win_is_valid(winnr) then
		local cfg = vim.api.nvim_win_get_config(winnr)
		cfg.hide = nil

		-- Flip the N/S component of the anchor based on full-screen space
		local want_above = space_above + 5 > space_below
		local current_above = cfg.anchor and cfg.anchor:sub(1, 1) == "S"

		if want_above and not current_above then
			cfg.anchor = "S" .. cfg.anchor:sub(2, 2)
			cfg.row = cfg.row - 1
		elseif not want_above and current_above then
			cfg.anchor = "N" .. cfg.anchor:sub(2, 2)
			cfg.row = 1
		end

		if want_above then
			cfg.height = math.min(cfg.height, opts.max_height, math.max(2, space_above - 1))
		else
			cfg.height = math.min(cfg.height, opts.max_height, math.max(2, space_below - 1))
		end

		local want_width = longest_line_in_buf(bufnr)
		if want_width > cfg.width and cfg.width < opts.max_width then
			cfg.width = math.min(want_width, opts.max_width)
		end

		vim.api.nvim_win_set_config(winnr, cfg)
	end

	return bufnr, winnr
end
