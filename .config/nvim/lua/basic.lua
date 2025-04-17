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

function find_file_in_parents_and_open(possible_filenames)
    function _find_file_closure()
        local fn = vim.fn;
        local env = vim.env;

        
        local home = env.HOME or env.USERPROFILE
        local cwd = fn.getcwd()

        while cwd ~= home and cwd ~= '/' do
            for _, filename in ipairs(possible_filenames) do
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

    return _find_file_closure
end

local possible_readmes = {"README.txt", "README.md", "README.rst", "README"}
wk.add({
    {'<leader>orm', find_file_in_parents_and_open(possible_readmes), desc="Open README"},
    {'<leader>ogi', find_file_in_parents_and_open({".gitignore"}), desc="Open .gitignore"}
})

local capabilities = require('blink.cmp').get_lsp_capabilities()
lspconfig = require('lspconfig')
lspconfig.clangd.setup({ capabilities = capabilities })

-- For compiling competetive programming things/leetcode
function build_comp_cpp()
    local filename = vim.fn.expand('%:t:r')
    vim.notify(string.format("Compiling %s...", filename), vim.log.levels.INFO)
    
    local filepath  = vim.fn.expand('%:p')
    local dir = vim.fn.expand('%:p:h')

    if vim.fn.filereadable(filepath) ~= 1 then
        vim.notify("File is not readable: " .. filepath, vim.log.levels.ERROR)
        return
    end

    local compile_cmd = string.format(
        'clang -Wall -Wextra -std=c++20 -lstdc++ %s -o %s/a.out',
        vim.fn.shellescape(filepath),
        vim.fn.shellescape(dir)
    )

    local output = vim.fn.systemlist(compile_cmd)

    if vim.v.shell_error ~= 0 then
        vim.fn.setqflist({}, ' ', {
            title = 'Clang Compilation Errors',
            lines = output,
            efm = '%f:%l:%c: %m'
        })
        vim.cmd('copen')
        vim.notify("Compilation failed", vim.log.levels.ERROR)
    else
        vim.notify("Compilation successful!", vim.log.levels.INFO)
    end
end

wk.add({
    {'<leader><leader>cc', build_and_run_comp_cpp, desc="Build & Run C++ Algorithm"}
})
