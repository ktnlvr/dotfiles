-- Enable line numbers
vim.opt.number = true

-- Proper indentation
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Run the plugin for installing all the LSP things
require('mason').setup()

local wk = require('which-key')

function find_file_in_parents_and_open()
    function _find_file_closure()
        local fn = vim.fn;
        local env = vim.env;

        
        local home = env.HOME or env.USERPROFILE
        local cwd = fn.getcwd()

        while cwd ~= home and cwd ~= '/' do
            for _, filename in ipairs(possible_readmes) do
                local filepath = cwd .. '/' .. filename
                if fn.filereadable(filepath) == 1 then 
                    vim.cmd('vsplit ' .. fn.fnameescape(filepath))
                    print("Found README: " .. filepath)
                    return
                end
            end
        end

        print("No README found")
    end
end

local possible_readmes = {"README.txt", "README.md", "README.rst", "README"}
wk.add({
    {'<leader>orm', find_file_in_parents_and_open(possible_readmes), desc="Open README"},
    {'<leader>ogi', find_file_in_parents_and_open({".gitignore"}), desc="Open .gitignore"}
})

