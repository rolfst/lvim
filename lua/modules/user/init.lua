local modules = {}

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- HELP ---------------------------------------------------------
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

-- Disable of default Module (Plug-in) (from lua/modules/base/init.lua)

-- You can disable of any default Module (Plug-in)
-- modules["glepnir/dashboard-nvim"] = false

-- Rewrite of settings of default Module (Plug-in) (from lua/modules/base/init.lua)

-- You can rewrite of settings of any of default Module (Plug-in)
-- modules["glepnir/dashboard-nvim"] = {
--     -- your code
-- }

-- Add new Module (Plug-in)

-- You can add new Module (Plug-in)
-- modules["sheerun/vim-polyglot"] = {
--     your code
-- }

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- HELP ---------------------------------------------------------
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- UI -----------------------------------------------------------
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

-- local ui_config = require("modules.user.configs.ui")

-- modules["name_of_your/module"] = {
--     config = ui_config.name_of_your_function
-- }

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- Editor -------------------------------------------------------
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

-- local editor_config = require("modules.user.configs.editor")

-- modules["name_of_your/module"] = {
--     config = editor_config.name_of_your_function
-- }

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- Version control ----------------------------------------------
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

-- local version_control_config = require("modules.user.configs.version_control")

-- modules["name_of_your/module"] = {
--     config = version_control_config.name_of_your_function
-- }

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- Languages ----------------------------------------------------
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

local languages_config = require("modules.user.configs.languages")

-- modules["name_of_your/module"] = {
--     config = languages_config.name_of_your_function
-- }
--
-- modules["jose-elias-alvarez/null-ls.nvim"] = {
--     config = languages_config.nvim_formatters,
-- }
modules["mfussenegger/nvim-dap-python"] = {
    requires = {
        "mfussenegger/nvim-dap",
    },
}
modules["nvim-neotest/neotest"] = {
    requires = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-treesitter/nvim-treesitter" },
        { "antoinemadec/FixCursorHold.nvim" },
        { "nvim-neotest/neotest-python" },
        { "nvim-neotest/neotest-go" },
        --   { "haydenmeade/neotest-jest" },
        { "adrigzr/neotest-mocha" },

        {
            "nvim-neotest/neotest-vim-test",
            requires = {
                { "vim-test/vim-test" },
            },
        },
        { "rouge8/neotest-rust" },
        { "nvim-neotest/neotest-plenary" },
        { "nvim-treesitter/nvim-treesitter" },
        {
            "stevearc/overseer.nvim",
            opt = true,
            cmd = {
                "OverseerToggle",
                "OverseerOpen",
                "OverseerRun",
                "OverseerBuild",
                "OverseerClose",
                "OverseerLoadBundle",
                "OverseerSaveBundle",
                "OverseerDeleteBundle",
                "OverseerRunCmd",
                "OverseerQuickAction",
                "OverseerTaskAction",
            },
            -- overseer.nvim
            -- consumers = {
            --     overseer = require("neotest.consumers.overseer"),
            -- },
            overseer = {
                enabled = true,
                force_default = true,
            },
        },
    },
    wants = {
        "plenary.nvim",
        "nvim-treesitter",
        "FixCursorHold.nvim",
        "neotest-python",
        "neotest-mocha",
        "neotest-plenary",
        "neotest-go",
        -- "neotest-jest",
        "neotest-vim-test",
        "neotest-rust",
        "vim-test",
        "overseer.nvim",
    },
    module = { "neotest", "neotest.async" },
    cmd = {
        "TestNearest",
        "TestFile",
        "TestSuite",
        "TestLast",
        "TestVisit",
    },
    disable = false,
    config = languages_config.nvim_test,
}
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- Completion ---------------------------------------------------
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

-- local completion_config = require("modules.user.configs.editor")

-- modules["name_of_your/module"] = {
--     config = completion_config.name_of_your_function
-- }

-- modules["numToStr/Comment.nvim"] = false
-- modules["terrortylor/nvim-comment"] = {
--     opt = false,
-- }

return modules
