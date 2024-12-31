-- The below are taken from NormalVim/NormalVim

local function load_source(source)
  local status_ok, error = pcall(require, source)
  if not status_ok then
    vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. error)
  end
end

local function load_sources(source_files)
  vim.loader.enable()
  for _, source in ipairs(source_files) do
    load_source(source)
  end
end

local function load_sources_async(source_files)
  for _, source in ipairs(source_files) do
    vim.defer_fn(function()
      load_source(source)
    end, 50)
  end
end

local function load_colorscheme_async(colorscheme)
  vim.defer_fn(function()
    if vim.g.default_colorscheme then
      if not pcall(vim.cmd.colorscheme, colorscheme) then
          vim.notify("Error setting up colorscheme: " .. colorscheme, vim.log.levels.ERROR)
      end
    end
  end, 0)
end

-- Call the functions defined above.
load_sources({
  "options",
  "lazy-plugins",
})
load_colorscheme_async(vim.g.default_colorscheme)
load_sources_async({ "mappings" })
