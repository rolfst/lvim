local languages_setup = require("languages.base.utils")
local tsserver_config = require("languages.base.languages._configs").jsts_config(
    { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    "jsts"
)
local dap = require("dap")

local language_configs = {}

language_configs["lsp"] = function()
    languages_setup.setup_languages({
        ["language"] = "js-ts",
<<<<<<< HEAD
        ["dap"] = { "chrome-debug-adapter", "node-debug2-adapter" },
=======
>>>>>>> production
        ["typescript-language-server"] = { "tsserver", tsserver_config },
        ["dap"] = { "js-debug-adapter" },
        ["dependencies"] = {
            "prettierd",
        },
    })
end

language_configs["dap"] = function()
<<<<<<< HEAD
    -- dap.adapters.chrome = {
    --     type = "executable",
    --     command = "node",
    --     args = { global.mason_path .. "/packages/chrome-debug-adapter/out/src/chromeDebug.js" },
    -- }
    -- dap.configurations.javascript = {
    --     {
    --         type = "chrome",
    --         request = "attach",
    --         program = function()
    --             return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    --         end,
    --         cwd = vim.fn.getcwd(),
    --         sourceMaps = true,
    --         protocol = "inspector",
    --         port = 9222,
    --         webRoot = "${workspaceFolder}",
    --     },
    -- }
    -- dap.configurations.typescript = {
    --     {
    --         type = "chrome",
    --         request = "attach",
    --         program = function()
    --             return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    --         end,
    --         cwd = vim.fn.getcwd(),
    --         sourceMaps = true,
    --         protocol = "inspector",
    --         port = 9222,
    --         webRoot = "${workspaceFolder}",
    --     },
    -- }
    dap.adapters.node2 = {
        type = "executable",
        command = "node",
        args = { global.mason_path .. "/packages/node-debug2-adapter/out/src/nodeDebug.js" },
    }
    dap.adapters["pwa-node"] = {
        type = "executable",
        command = "node",
        args = { global.mason_path .. "/packages/node-debug2-adapter/out/src/nodeDebug.js" },
    }
    dap.configurations.javascript = {
        {
            name = "Launch",
            type = "node2",
            request = "launch",
            program = "${file}",
            -- program = function()
            --     return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            -- end,
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            protocol = "inspector",
            -- port = 9222,
            -- webRoot = "${workspaceFolder}",
        },
        {
            type = "node2",
            name = "Attach to process",
            request = "attach",
            process = require("dap.utils").pick_process,
=======
    dap.configurations.javascript = {
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
        },
        {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
        },
        {
            type = "pwa-node",
            request = "launch",
            name = "Debug Jest Tests",
            trace = true,
            runtimeExecutable = "node",
            runtimeArgs = {
                "./node_modules/jest/bin/jest.js",
                "--runInBand",
            },
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
        },
        {
            type = "pwa-node",
            request = "launch",
            name = "Debug Mocha Tests",
            trace = true,
            runtimeExecutable = "node",
            runtimeArgs = {
                "./node_modules/mocha/bin/mocha.js",
            },
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
>>>>>>> production
        },
    }
    dap.configurations.typescript = {
        {
<<<<<<< HEAD
            type = "node2",
            request = "attach",
            program = "${file}",
            -- program = function()
            --     return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            -- end,
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            protocol = "inspector",
            -- port = 9222,
            -- webRoot = "${workspaceFolder}",
=======
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
        },
        {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
        },
        {
            type = "pwa-node",
            request = "launch",
            name = "Debug Jest Tests",
            trace = true, -- include debugger info
            runtimeExecutable = "node",
            runtimeArgs = {
                "./node_modules/jest/bin/jest.js",
                "--runInBand",
            },
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
        },
        {
            type = "pwa-node",
            request = "launch",
            name = "Debug Mocha Tests",
            trace = true, -- include debugger info
            runtimeExecutable = "node",
            runtimeArgs = {
                "./node_modules/mocha/bin/mocha.js",
            },
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
>>>>>>> production
        },
    }
end

return language_configs
