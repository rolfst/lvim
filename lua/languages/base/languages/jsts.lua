local global = require("core.global")
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
        ["dap"] = { "chrome-debug-adapter", "node-debug2-adapter" },
        ["typescript-language-server"] = { "tsserver", tsserver_config },
        ["dependencies"] = {
            "prettierd",
        },
    })
end

language_configs["dap"] = function()
    -- dap.adapters.chrome = {
    --     type = "executable",
    --     command = "node",
    --     args = { global.mason_path .. "packages/chrome-debug-adapter/out/src/chromeDebug.js" },
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
        args = { global.mason_path .. "packages/node-debug2-adapter/out/src/nodeDebug.js" },
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
        },
    }
    dap.configurations.typescript = {
        {
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
        },
    }
end

return language_configs
