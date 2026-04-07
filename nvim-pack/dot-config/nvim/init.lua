-- The below are taken from NormalVim/NormalVim

local function load_source(source)
	local status_ok, error = pcall(require, source)
	if not status_ok then
		vim.notify("Failed to load " .. source .. "\n\n" .. error, vim.log.levels.ERROR)
		vim.cmd([[e ~/.config/nvim]])
	end
end

-- local function load_colorscheme_async(colorscheme)
-- 	vim.defer_fn(function()
-- 		if vim.g.default_colorscheme then
-- 			if not pcall(vim.cmd.colorscheme, colorscheme) then
-- 				vim.notify("Error setting up colorscheme: " .. colorscheme, vim.log.levels.ERROR)
-- 			end
-- 		end
-- 	end, 0)
-- end

-- Call the functions defined above.
load_source("options")
load_source("pack-plugins")
vim.cmd([[colorscheme gruvbox]])
load_source("mappings")
