local wk = require('which-key')

wk.add({
    { '<leader>Gb', ":Gitsigns blame<CR>", desc="Git Blame" },
    { '<leader>Gd', ":Gitsigns diffthis<CR>", desc="Git Diff" },
})

