local wk = require('which-key')
local builtin = require('telescope.builtin')

function find_grep()
    builtin.grep_string({ search = vim.fn.input("grep ")})
end

wk.add({
    {'<leader>ff', builtin.find_files, desc="Find File"},
    {'<leader>fg', find_grep, desc="Find Grep"},
    {'<leader>fG', builtin.git_files, desc="Find Git"},
})

