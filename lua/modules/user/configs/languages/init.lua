local config = {}

function config.nvim_test()
    require("neotest").setup({
        adapters = {
            require("neotest-python")({
                dap = { justMyCode = false },
            }),
            require("neotest-plenary"),
            -- require("neotest-jest"),
            require("neotest-vim-test")({
                ignore_file_types = { "python", "lua", "rust" },
            }),
            require("neotest-rust"),
        },
    })
end

-- function config.nvim_formatters()
--     require("null-ls").setup({
--         sources = require("null-ls").builtins.formatting.yapf,
--     })
-- end

return config
