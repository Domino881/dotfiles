-- The below are taken from NormalVim/NormalVim

local function load_source(source)
	local status_ok, error = pcall(require, source)
	if not status_ok then
		vim.notify("Failed to load " .. source .. "\n\n" .. error, vim.log.levels.ERROR)
		vim.cmd([[e ~/.config/nvim]])
	end
end

-- Call the functions defined above.
load_source("options")
load_source("pack-plugins")
vim.cmd([[colorscheme gruvbox]])
load_source("mappings")
