vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

-- Define the run_cpp function globally
function _G.run_cpp()
  vim.cmd('w') -- save

  local filename = vim.fn.expand('%')           -- Get the current file name
  local output_name = vim.fn.expand('%:r')     -- Get the base name (without extension)

  -- Compile the C++ file
  local compile_cmd = 'g++ ' .. vim.fn.shellescape(filename) .. ' -o ' .. vim.fn.shellescape(output_name)
  
  -- Run the compiled executable
  local run_cmd = './' .. vim.fn.shellescape(output_name)

  -- Execute the compile command
  local compile_result = vim.fn.system(compile_cmd)

  -- Check the compilation result
  if vim.v.shell_error == 0 then
    print('Compilation successful! Running...')
    print(vim.fn.system(run_cmd))  -- Show output from running the program
  else
    print('Compilation failed:\n' .. compile_result)
  end
end

-- Create an autocommand for C++ file type
vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  callback = function()
    -- Map <F5> to compile and run the C++ code
    vim.api.nvim_set_keymap('n', '<F1>', ':lua run_cpp()<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<F5>', ':help<CR>', { noremap = true, silent = true })
  end,
})
