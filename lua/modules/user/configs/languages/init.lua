local config = {}

function config.nvim_test()
    require("neotest").setup({
        adapters = {
            require("neotest-python")({
                dap = { justMyCode = false },
                ignore_file_types = { "javascript", "typescript" },
            }),
            require("neotest-plenary"),
            -- require("neotest-jest"),
            require("neotest-mocha"),
            require("neotest-vim-test")({
                ignore_file_types = { "python", "lua", "rust" },
            }),
            require("neotest-rust"),
        },
    })
end

return config
