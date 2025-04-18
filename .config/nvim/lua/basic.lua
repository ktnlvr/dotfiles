-- Enable line numbers
vim.opt.number = true

-- Proper indentation
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.scrolloff = 7

-- Exit out of terminal mode easily
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

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
        'clang -Wall -Wextra -DDEBUG -std=c++20 -lstdc++ %s -o %s/a.out -g',
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

    local input = "input.txt"
    local output = ""

    if vim.fn.filereadable(input) == 1 then
        local handle = io.popen("./a.out < " .. input)
        if handle then
            output = handle:read("*a")
            handle:close()
        else
            vim.notify("Failed to run the file")
            return
        end
    else
        vim.notify("No input.txt file ran")
        return
    end

    local main_win = vim.api.nvim_get_current_win()

    local out_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(out_buf, 0, -1, false, vim.split(output, "\n"))
    vim.cmd("vsplit")
    vim.api.nvim_win_set_buf(0, out_buf)
end

wk.add({
    {'<leader><leader>c', build_comp_cpp, desc="Build & Run C++ Algorithm"}
})

local floating_window = {
    buf = -1,
    win = -1,
}

function create_floating_window(opts)
    opts = opts or {}
    local width = opts.width or math.floor(vim.o.columns * 0.8)
    local height = opts.height or math.floor(vim.o.lines * 0.8)
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    local buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false, true)
    end

    local win_config = {
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        style = "minimal",
        border = "rounded"
    }

    local win = vim.api.nvim_open_win(buf, true, win_config)
    return { buf = buf, win = win }
end

function toggle_floating_window()
    if not vim.api.nvim_win_is_valid(floating_window.win) then
        floating_window = create_floating_window { buf = floating_window.buf }
        if vim.bo[floating_window.buf].buftype ~= "terminal" then 
            vim.cmd.terminal()
        end
    else
        vim.api.nvim_win_hide(floating_window.win)
    end
end

wk.add({{ '<leader>tt', toggle_floating_window }})

