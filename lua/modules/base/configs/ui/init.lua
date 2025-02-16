local config = {}

function config.lvim_colorscheme()
    vim.g.lvim_sidebars = {
        "qf",
        "Outline",
        "terminal",
        "packer",
        "calendar",
        "spectre_panel",
        "ctrlspace",
        "neo-tree",
    }
    vim.cmd("colorscheme lvim")
end

function config.nui_nvim()
    vim.ui.input = require("modules.base.configs.ui.utils.input")
    vim.ui.select = require("modules.base.configs.ui.utils.select")
end

function config.alpha_nvim()
    local alpha_status_ok, alpha = pcall(require, "alpha")
    if not alpha_status_ok then
        return
    end
    local alpha_themes_dashboard_status_ok, alpha_themes_dashboard = pcall(require, "alpha.themes.dashboard")
    if not alpha_themes_dashboard_status_ok then
        return
    end
    math.randomseed(os.time())
    local function button(sc, txt, keybind, keybind_opts)
        local b = alpha_themes_dashboard.button(sc, txt, keybind, keybind_opts)
        b.opts.hl = "AlphaButton"
        b.opts.hl_shortcut = "AlphaButtonShortcut"
        return b
    end
    local function footer()
        local global = require("core.global")
        local plugins = #vim.tbl_keys(packer_plugins)
        local v = vim.version()
        local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
        local platform
        if global.os == "Linux" then
            platform = " Linux"
        elseif global.os == "macOS" then
            platform = " macOS"
        else
            platform = ""
        end
        return string.format("  %d   v%d.%d.%d  %s  %s", plugins, v.major, v.minor, v.patch, platform, datetime)
    end
    alpha_themes_dashboard.section.header.val = {
        " 888     Y88b      / 888      e    e      ",
        " 888      Y88b    /  888     d8b  d8b     ",
        " 888       Y88b  /   888    d888bdY88b    ",
        " 888        Y888/    888   / Y88Y Y888b   ",
        " 888         Y8/     888  /   YY   Y888b  ",
        " 888____      Y      888 /          Y888b ",
    }
    alpha_themes_dashboard.section.header.opts.hl = "AlphaHeader"
    alpha_themes_dashboard.section.buttons.val = {
        button("SPC SPC b", "  Projects", ":CtrlSpace b<CR>"),
        button("A-/", "  File explorer", ":Telescope file_browser<CR>"),
        button("A-,", "  Search file", ":Telescope find_files<CR>"),
        button("A-.", "  Search in files", ":Telescope live_grep<CR>"),
        button("F11", "  Help", ":LvimHelper<CR>"),
        button("q", "  Quit", "<Cmd>qa<CR>"),
    }
    alpha_themes_dashboard.section.footer.val = footer()
    alpha_themes_dashboard.section.footer.opts.hl = "AlphaFooter"
    table.insert(alpha_themes_dashboard.config.layout, { type = "padding", val = 1 })
    table.insert(alpha_themes_dashboard.config.layout, {
        type = "text",
        val = require("alpha.fortune")(),
        opts = {
            position = "center",
            hl = "AlphaQuote",
        },
    })
    alpha.setup(alpha_themes_dashboard.config)
    vim.api.nvim_create_augroup("alpha_tabline", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
        group = "alpha_tabline",
        pattern = "alpha",
        command = "set showtabline=0 laststatus=0 noruler",
    })
    vim.api.nvim_create_autocmd("FileType", {
        group = "alpha_tabline",
        pattern = "alpha",
        callback = function()
            vim.api.nvim_create_autocmd("BufUnload", {
                group = "alpha_tabline",
                buffer = 0,
                command = "set showtabline=2 ruler laststatus=3",
            })
        end,
    })
end

function config.nvim_window_picker()
    local window_picker_status_ok, window_picker = pcall(require, "window-picker")
    if not window_picker_status_ok then
        return
    end
    local filters = window_picker.filter_windows
    local function special_autoselect(windows)
        windows = filters(windows)
        if windows == nil then
            windows = {}
        end
        if #windows > 1 then
            return windows
        end
        local curr_win = vim.api.nvim_get_current_win()
        for index, window in ipairs(windows) do
            if window == curr_win then
                table.remove(windows, index)
            end
        end
        return windows
    end
    local function focus_window()
        window_picker.pick_window()
        if type(window) == "number" then
            vim.api.nvim_set_current_win(window)
        end
    end
    window_picker.setup({
        autoselect_one = false,
        include_current_win = true,
        filter_func = special_autoselect,
        filter_rules = {
            bo = {
                filetype = {},
                buftype = {},
            },
        },
        fg_color = "#20262A",
        current_win_hl_color = "#20262A",
        other_win_hl_color = "#95b365",
    })
    vim.api.nvim_create_user_command("WindowPicker", focus_window, {})
end

function config.neo_tree_nvim()
    local neo_tree_status_ok, neo_tree = pcall(require, "neo-tree")
    if not neo_tree_status_ok then
        return
    end
    neo_tree.setup({
        use_popups_for_input = false,
        popup_border_style = { " ", " ", " ", " ", " ", " ", " ", " " },
        enable_diagnostics = false,
        sources = {
            "filesystem",
            "buffers",
            "git_status",
            "diagnostics",
        },
        default_component_configs = {
            container = {
                enable_character_fade = true,
            },
            indent = {
                with_markers = false,
                with_expanders = true,
            },
            icon = {
                folder_closed = "",
                folder_open = "",
                folder_empty = "",
                highlight = "NeoTreeFileIcon",
            },
            modified = {
                symbol = "",
            },
            git_status = {
                symbols = {
                    added = "",
                    deleted = "",
                    modified = "",
                    renamed = "",
                    untracked = "",
                    ignored = "",
                    unstaged = "",
                    staged = "",
                    conflict = "",
                },
                align = "right",
            },
        },
        window = {
            mappings = {
                ["Z"] = "expand_all_nodes",
            },
        },
        filesystem = {
            follow_current_file = true,
            use_libuv_file_watcher = true,
        },
    })
end

function config.dirbuf_nvim()
    local dirbuf_status_ok, dirbuf = pcall(require, "dirbuf")
    if not dirbuf_status_ok then
        return
    end
    dirbuf.setup({})
end

function config.which_key_nvim()
    local which_key_status_ok, which_key = pcall(require, "which-key")
    if not which_key_status_ok then
        return
    end
    local options = {
        plugins = {
            marks = true,
            registers = true,
            presets = {
                operators = false,
                motions = false,
                text_objects = false,
                windows = false,
                nav = false,
                z = false,
                g = false,
            },
            spelling = {
                enabled = true,
                suggestions = 20,
            },
        },
        icons = {
            breadcrumb = "»",
            separator = "➜",
            group = "+",
        },
        window = {
            border = { " ", " ", " ", " ", " ", " ", " ", " " },
            position = "bottom",
            margin = {
                0,
                0,
                0,
                0,
            },
            padding = {
                2,
                2,
                2,
                2,
            },
        },
        layout = {
            height = {
                min = 4,
                max = 25,
            },
            width = {
                min = 20,
                max = 50,
            },
            spacing = 10,
        },
        hidden = {
            "<silent>",
            "<cmd>",
            "<Cmd>",
            "<CR>",
            "call",
            "lua",
            "^:",
            "^ ",
        },
        show_help = true,
        buftype = "",
    }
    local nopts = {
        mode = "n",
        prefix = "<leader>",
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = true,
    }
    local vopts = {
        mode = "v",
        prefix = "<leader>",
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = true,
    }
    local nmappings = {
        a = { ":e $HOME/.config/nvim/README.org<CR>", "Open README file" },
        b = {
            name = "Buffers",
            n = { "<Cmd>BufSurfForward<CR>", "Next buffer" },
            p = { "<Cmd>BufSurfBack<CR>", "Prev buffer" },
            l = { "<Cmd>Telescope buffers<CR>", "List buffers" },
        },
        d = {
            name = "Database",
            u = { "<Cmd>DBUIToggle<CR>", "DB UI toggle" },
            f = { "<Cmd>DBUIFindBuffer<CR>", "DB find buffer" },
            r = { "<Cmd>DBUIRenameBuffer<CR>", "DB rename buffer" },
            l = { "<Cmd>DBUILastQueryInfo<CR>", "DB last query" },
        },
        e = {
            name = "NeoTree",
            l = { "<Cmd>Neotree left<CR>", "Neotree left" },
            f = { "<Cmd>Neotree float<CR>", "Neotree float" },
            b = { "<Cmd>Neotree buffers float<CR>", "Neotree buffers" },
            g = { "<Cmd>Neotree git_status float<CR>", "Neotree git_status" },
        },
        f = {
            name = "Find & Fold",
            f = { "<Cmd>HopWord<CR>", "Hop Word" },
            ["]"] = { "<Cmd>HopChar1<CR>", "Hop Char1" },
            ["["] = { "<Cmd>HopChar2<CR>", "Hop Char2" },
            l = { "<Cmd>HopLine<CR>", "Hop Line" },
            s = { "<Cmd>HopLineStart<CR>", "Hop Line Start" },
            m = { "<Cmd>:set foldmethod=manual<CR>", "Manual (default)" },
            i = { "<Cmd>:set foldmethod=indent<CR>", "Indent" },
            e = { "<Cmd>:set foldmethod=expr<CR>", "Expr" },
            d = { "<Cmd>:set foldmethod=diff<CR>", "Diff" },
            M = { "<Cmd>:set foldmethod=marker<CR>", "Marker" },
        },
        g = {
            name = "GIT",
            b = { "<Cmd>GitSignsBlameLine<CR>", "Blame" },
            ["]"] = { "<Cmd>GitSignsNextHunk<CR>", "Next hunk" },
            ["["] = { "<Cmd>GitSignsPrevHunk<CR>", "Prev hunk" },
            P = { "<Cmd>GitSignsPreviewHunk<CR>", "Preview hunk" },
            r = { "<Cmd>GitSignsResetHunk<CR>", "Reset stage hunk" },
            s = { "<Cmd>GitSignsStageHunk<CR>", "Stage hunk" },
            u = { "<Cmd>GitSignsUndoStageHunk<CR>", "Undo stage hunk" },
            R = { "<Cmd>GitSignsResetBuffer<CR>", "Reset buffer" },
            n = { "<Cmd>Neogit<CR>", "Neogit" },
            l = { "<Cmd>Lazygit<CR>", "Lazygit" },
        },
        n = {
            name = "Neogen",
            l = { "<Cmd>NeogenFile<CR>", "File" },
            c = { "<Cmd>NeogenClass<CR>", "Class" },
            f = { "<Cmd>NeogenFunction<CR>", "Function" },
            t = { "<Cmd>NeogenType<CR>", "Type" },
        },
        l = {
            name = "LSP",
            r = { "<Cmd>LspRename<CR>", "Rename" },
            f = { "<Cmd>LspFormatting<CR>", "Format" },
            h = { "<Cmd>Hover<CR>", "Hover" },
            a = { "<Cmd>LspCodeAction<CR>", "Code action" },
            d = { "<Cmd>LspDefinition<CR>", "Definition" },
            t = { "<Cmd>LspTypeDefinition<CR>", "Type definition" },
            R = { "<Cmd>LspReferences<CR>", "References" },
            i = { "<Cmd>LspImplementation<CR>", "Implementation" },
            s = { "<Cmd>LspSignatureHelp<CR>", "Signature help" },
            S = {
                name = "Symbol",
                d = { "<Cmd>LspDocumentSymbol<CR>", "Document symbol" },
                w = { "<Cmd>LspWorkspaceSymbol<CR>", "Workspace symbol" },
            },
            w = {
                "<Cmd>LspAddToWorkspaceFolder<CR>",
                "Add to workspace folder",
            },
        },
        p = {
            name = "Packer",
            c = { "<cmd>PackerCompile<CR>", "Compile" },
            i = { "<cmd>PackerInstall<CR>", "Install" },
            s = { "<cmd>PackerSync<CR>", "Sync" },
            S = { "<cmd>PackerStatus<CR>", "Status" },
            u = { "<cmd>PackerUpdate<CR>", "Update" },
        },
        P = {
            name = "Path",
            g = { "<Cmd>SetGlobalPath<CR>", "Set global path" },
            w = { "<Cmd>SetWindowPath<CR>", "Set window path" },
        },
        s = {
            name = "Spectre",
            d = {
                '<Cmd>lua require("spectre").delete()<CR>',
                "Toggle current item",
            },
            g = {
                '<Cmd>lua require("spectre.actions").select_entry()<CR>',
                "Goto current file",
            },
            q = {
                '<Cmd>lua require("spectre.actions").send_to_qf()<CR>',
                "Send all item to quickfix",
            },
            m = {
                '<Cmd>lua require("spectre.actions").replace_cmd()<CR>',
                "Input replace vim command",
            },
            o = {
                '<Cmd>lua require("spectre").show_options()<CR>',
                "show option",
            },
            R = {
                '<Cmd>lua require("spectre.actions").run_replace()<CR>',
                "Replace all",
            },
            v = {
                '<Cmd>lua require("spectre").change_view()<CR>',
                "Change result view mode",
            },
            c = {
                '<Cmd>lua require("spectre").change_options("ignore-case")<CR>',
                "Toggle ignore case",
            },
            h = {
                '<Cmd>lua require("spectre").change_options("hidden")<CR>',
                "Toggle search hidden",
            },
        },
        t = {
            name = "Telescope",
            b = { "<Cmd>Telescope file_browser<CR>", "File browser" },
            f = { "<Cmd>Telescope find_files<CR>", "Find files" },
            w = { "<Cmd>Telescope live_grep<CR>", "Live grep" },
            u = { "<Cmd>Telescope buffers<CR>", "Buffers" },
            m = { "<Cmd>Telescope marks<CR>", "Marks" },
            o = { "<Cmd>Telescope commands<CR>", "Commands" },
            y = { "<Cmd>Telescope symbols<CR>", "Symbols" },
            n = { "<Cmd>Telescope quickfix<CR>", "Quickfix" },
            c = { "<Cmd>Telescope git_commits<CR>", "Git commits" },
            B = { "<Cmd>Telescope git_bcommits<CR>", "Git bcommits" },
            r = { "<Cmd>Telescope git_branches<CR>", "Git branches" },
            s = { "<Cmd>Telescope git_status<CR>", "Git status" },
            S = { "<Cmd>Telescope git_stash<CR>", "Git stash" },
            i = { "<Cmd>Telescope git_files<CR>", "Git files" },
        },
    }
    local vmappings = {
        ["/"] = { ":CommentToggle<CR>", "Comment" },
        f = { "<Cmd>LspRangeFormatting<CR>", "Range formatting" },
    }
    which_key.setup(options)
    which_key.register(nmappings, nopts)
    which_key.register(vmappings, vopts)
end

function config.heirline_nvim()
    local heirline_status_ok, heirline = pcall(require, "heirline")
    if not heirline_status_ok then
        return
    end
    local heirline_conditions_status_ok, heirline_conditions = pcall(require, "heirline.conditions")
    if not heirline_conditions_status_ok then
        return
    end
    local heirline_utils_status_ok, heirline_utils = pcall(require, "heirline.utils")
    if not heirline_utils_status_ok then
        return
    end
    local colors = LVIM_COLORS()
    local align = { provider = "%=" }
    local space = { provider = " " }
    local mode
    local vi_mode = {
        init = function(self)
            self.mode = vim.fn.mode(1)
            if not self.once then
                vim.api.nvim_create_autocmd("ModeChanged", {
                    pattern = "*:*o",
                    command = "redrawstatus",
                })
                self.once = true
            end
        end,
        static = {
            mode_names = {
                n = "N",
                no = "N?",
                nov = "N?",
                noV = "N?",
                ["no\22"] = "N?",
                niI = "Ni",
                niR = "Nr",
                niV = "Nv",
                nt = "Nt",
                v = "V",
                vs = "Vs",
                V = "V_",
                Vs = "Vs",
                ["\22"] = "^V",
                ["\22s"] = "^V",
                s = "S",
                S = "S_",
                ["\19"] = "^S",
                i = "I",
                ic = "Ic",
                ix = "Ix",
                R = "R",
                Rc = "Rc",
                Rx = "Rx",
                Rv = "Rv",
                Rvc = "Rv",
                Rvx = "Rv",
                c = "C",
                cv = "Ex",
                r = "...",
                rm = "M",
                ["r?"] = "?",
                ["!"] = "!",
                t = "T",
            },
            mode_colors = {
                n = colors.color_01,
                i = colors.color_02,
                v = colors.color_03,
                V = colors.color_03,
                ["\22"] = colors.color_03,
                c = colors.color_03,
                s = colors.purple,
                S = colors.purple,
                ["\19"] = colors.purple,
                R = colors.color_03,
                r = colors.color_03,
                ["!"] = colors.color_02,
                t = colors.color_02,
            },
        },
        provider = function(self)
            return "   %(" .. self.mode_names[self.mode] .. "%)"
        end,
        hl = function(self)
            mode = self.mode:sub(1, 1)
            return { fg = self.mode_colors[mode], bold = true }
        end,
        update = {
            "ModeChanged",
        },
    }
    local file_name_block = {
        init = function(self)
            self.filename = vim.api.nvim_buf_get_name(0)
        end,
    }
    local work_dir = {
        provider = function(self)
            self.icon = "    "
            local cwd = vim.fn.getcwd(0)
            self.cwd = vim.fn.fnamemodify(cwd, ":~")
        end,
        hl = { fg = colors.color_05, bold = true },
        heirline_utils.make_flexible_component(1, {
            provider = function(self)
                local trail = self.cwd:sub(-1) == "/" and "" or "/"
                return self.icon .. self.cwd .. trail
            end,
        }, {
            provider = function(self)
                local cwd = vim.fn.pathshorten(self.cwd)
                local trail = self.cwd:sub(-1) == "/" and "" or "/"
                return self.icon .. cwd .. trail
            end,
        }, {
            provider = "",
        }),
    }
    local file_icon = {
        init = function(self)
            local filename = self.filename
            local extension = vim.fn.fnamemodify(filename, ":e")
            self.icon = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
        end,
        provider = function(self)
            local is_filename = vim.fn.fnamemodify(self.filename, ":.")
            if is_filename ~= "" then
                return self.icon and self.icon .. " "
            end
        end,
        hl = function()
            return {
                fg = vi_mode.static.mode_colors[mode],
                bold = true,
            }
        end,
    }
    local file_name = {
        provider = function(self)
            local filename = vim.fn.fnamemodify(self.filename, ":.")
            if filename == "" then
                return
            end
            if not heirline_conditions.width_percent_below(#filename, 0.25) then
                filename = vim.fn.pathshorten(filename)
            end
            return filename .. " "
        end,
        hl = function()
            return {
                fg = vi_mode.static.mode_colors[mode],
                bold = true,
            }
        end,
    }
    local file_flags = {
        {
            provider = function()
                if vim.bo.modified then
                    return " "
                end
            end,
            hl = { fg = colors.color_02 },
        },
        {
            provider = function()
                if not vim.bo.modifiable or vim.bo.readonly then
                    return "  "
                end
            end,
            hl = { fg = colors.color_05 },
        },
    }
    local file_size = {
        provider = function()
            local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
            fsize = (fsize < 0 and 0) or fsize
            if fsize <= 0 then
                return
            end
            local file_size = require("core.funcs").file_size(fsize)
            return "  " .. file_size
        end,
        hl = { fg = colors.color_05 },
    }
    file_name_block = heirline_utils.insert(
        file_name_block,
        space,
        space,
        file_icon,
        file_name,
        file_size,
        unpack(file_flags),
        { provider = "%<" }
    )
    local git = {
        condition = heirline_conditions.is_git_repo,
        init = function(self)
            self.status_dict = vim.b.gitsigns_status_dict
            self.has_changes = self.status_dict.added ~= 0
                or self.status_dict.removed ~= 0
                or self.status_dict.changed ~= 0
        end,
        hl = { fg = colors.color_03 },
        {
            provider = "  ",
        },
        {
            provider = function(self)
                return " " .. self.status_dict.head .. " "
            end,
            hl = { bold = true },
        },
        {
            provider = function(self)
                local count = self.status_dict.added or 0
                return count > 0 and ("  " .. count)
            end,
            hl = { fg = colors.color_01 },
        },
        {
            provider = function(self)
                local count = self.status_dict.removed or 0
                return count > 0 and ("  " .. count)
            end,
            hl = { fg = colors.color_02 },
        },
        {
            provider = function(self)
                local count = self.status_dict.changed or 0
                return count > 0 and ("  " .. count)
            end,
            hl = { fg = colors.color_03 },
        },
    }
    local diagnostics = {
        condition = heirline_conditions.has_diagnostics,
        static = {
            error_icon = " ",
            warn_icon = " ",
            info_icon = " ",
            hint_icon = " ",
        },
        update = { "DiagnosticChanged", "BufEnter" },
        init = function(self)
            self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
            self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
            self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
            self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
        end,
        {
            provider = function(self)
                return self.errors > 0 and (self.error_icon .. self.errors .. " ")
            end,
            hl = { fg = colors.color_02 },
        },
        {
            provider = function(self)
                return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
            end,
            hl = { fg = colors.color_03 },
        },
        {
            provider = function(self)
                return self.info > 0 and (self.info_icon .. self.info .. " ")
            end,
            hl = { fg = colors.color_04 },
        },
        {
            provider = function(self)
                return self.hints > 0 and (self.hint_icon .. self.hints .. " ")
            end,
            hl = { fg = colors.color_05 },
        },
    }
    local lsp_active = {
        condition = heirline_conditions.lsp_attached,
        update = { "LspAttach", "LspDetach", "BufWinEnter" },
        provider = function()
            local names = {}
            for _, server in pairs(vim.lsp.buf_get_clients(0)) do
                table.insert(names, server.name)
            end
            return "  " .. table.concat(names, ", ")
        end,
        hl = { fg = colors.color_05, bold = true },
    }
    local is_lsp_active = {
        condition = heirline_conditions.lsp_attached,
        update = { "LspAttach", "LspDetach" },
        provider = function()
            return "  "
        end,
        hl = { fg = colors.color_03, bold = true },
    }
    local file_type = {
        provider = function()
            local filetype = vim.bo.filetype
            if filetype ~= "" then
                return string.upper(filetype)
            end
        end,
        hl = { fg = colors.color_03, bold = true },
    }
    local file_encoding = {
        provider = function()
            local enc = vim.opt.fileencoding:get()
            if enc ~= "" then
                return " " .. enc:upper()
            end
        end,
        hl = { fg = colors.color_04, bold = true },
    }
    local file_format = {
        provider = function()
            local format = vim.bo.fileformat
            if format ~= "" then
                local symbols = {
                    unix = " ",
                    dos = " ",
                    mac = " ",
                }
                return symbols[format]
            end
        end,
        hl = { fg = colors.color_04, bold = true },
    }
    local spell = {
        condition = function()
            return vim.wo.spell
        end,
        provider = "  SPELL",
        hl = { bold = true, fg = colors.color_03 },
    }
    local scroll_bar = {
        provider = function()
            local current_line = vim.fn.line(".")
            local total_lines = vim.fn.line("$")
            local chars = { "█", "▇", "▆", "▅", "▄", "▃", "▂", "▁" }
            local line_ratio = current_line / total_lines
            local index = math.ceil(line_ratio * #chars)
            return "  " .. chars[index]
        end,
        hl = { fg = colors.color_02 },
    }
    local file_icon_name = {
        provider = function()
            local function isempty(s)
                return s == nil or s == ""
            end

            local hl_group_1 = "FileTextColor"
            vim.api.nvim_set_hl(0, hl_group_1, {
                fg = colors.color_01,
                bg = colors.status_line_bg,
                bold = true,
            })
            local filename = vim.fn.expand("%:t")
            local extension = vim.fn.expand("%:e")
            if not isempty(filename) then
                local f_icon, f_icon_color =
                    require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
                local hl_group_2 = "FileIconColor" .. extension
                vim.api.nvim_set_hl(0, hl_group_2, { fg = f_icon_color, bg = colors.status_line_bg })
                if isempty(f_icon) then
                    f_icon = ""
                    f_icon_color = ""
                end
                return "%#"
                    .. hl_group_2
                    .. "# "
                    .. f_icon
                    .. "%*"
                    .. " "
                    .. "%#"
                    .. hl_group_1
                    .. "#"
                    .. filename
                    .. "%*"
                    .. "  "
            end
        end,
        hl = { fg = colors.color_02 },
    }
    local navic = {
        condition = require("nvim-navic").is_available,
        provider = require("nvim-navic").get_location,
    }
    local terminal_name = {
        provider = function()
            local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
            return " " .. tname
        end,
        hl = { fg = colors.color_02, bold = true },
    }
    local status_lines = {
        fallthrough = false,
        hl = function()
            if heirline_conditions.is_active() then
                return {
                    fg = colors.status_line_fg,
                    bg = colors.status_line_bg,
                }
            else
                return {
                    fg = colors.status_line_nc_fg,
                    bg = colors.status_line_nc_bg,
                }
            end
        end,
        static = {
            mode_color = function(self)
                local mode = heirline_conditions.is_active() and vim.fn.mode() or "n"
                return self.mode_colors[mode]
            end,
        },
        {
            vi_mode,
            work_dir,
            file_name_block,
            git,
            align,
            diagnostics,
            lsp_active,
            is_lsp_active,
            file_type,
            file_encoding,
            file_format,
            spell,
            scroll_bar,
        },
    }
    local win_bars = {
        fallthrough = false,
        {
            condition = function()
                return heirline_conditions.buffer_matches({
                    buftype = {
                        "nofile",
                        "prompt",
                        "help",
                        "quickfix",
                    },
                    filetype = {
                        "ctrlspace",
                        "ctrlspace_help",
                        "packer",
                        "undotree",
                        "diff",
                        "Outline",
                        "NvimTree",
                        "LvimHelper",
                        "floaterm",
                        "dashboard",
                        "vista",
                        "spectre_panel",
                        "DiffviewFiles",
                        "flutterToolsOutline",
                        "log",
                        "qf",
                        "dapui_scopes",
                        "dapui_breakpoints",
                        "dapui_stacks",
                        "dapui_watches",
                        "calendar",
                        "neo-tree",
                        "neo-tree-popup",
                    },
                })
            end,
            init = function()
                vim.opt_local.winbar = nil
            end,
        },
        {
            condition = function()
                return heirline_conditions.buffer_matches({ buftype = { "terminal" } })
            end,
            {
                file_type,
                space,
                terminal_name,
            },
        },
        {
            condition = function()
                return not heirline_conditions.is_active()
            end,
            {
                file_icon_name,
            },
        },
        {
            file_icon_name,
            navic,
        },
    }
    if vim.fn.has("nvim-0.8") == 1 then
        heirline.setup(status_lines, win_bars)
        vim.api.nvim_create_autocmd("User", {
            pattern = "HeirlineInitWinbar",
            callback = function(args)
                local buf = args.buf
                local buftype = vim.tbl_contains({
                    "nofile",
                    "prompt",
                    "help",
                    "quickfix",
                }, vim.bo[buf].buftype)
                local filetype = vim.tbl_contains({
                    "ctrlspace",
                    "ctrlspace_help",
                    "packer",
                    "undotree",
                    "diff",
                    "Outline",
                    "LvimHelper",
                    "floaterm",
                    "dashboard",
                    "vista",
                    "spectre_panel",
                    "DiffviewFiles",
                    "flutterToolsOutline",
                    "log",
                    "qf",
                    "dapui_scopes",
                    "dapui_breakpoints",
                    "dapui_stacks",
                    "dapui_watches",
                    "calendar",
                    "neo-tree",
                    "neo-tree-popup",
                }, vim.bo[buf].filetype)
                if buftype or filetype then
                    vim.opt_local.winbar = nil
                end
            end,
        })
    else
        heirline.setup(status_lines)
    end
end

function config.fm_nvim()
    local fm_nvim_status_ok, fm_nvim = pcall(require, "fm-nvim")
    if not fm_nvim_status_ok then
        return
    end
    fm_nvim.setup({
        ui = {
            float = {
                border = "single",
                float_hl = "NormalFloat",
                border_hl = "FloatBorder",
                height = 0.95,
                width = 0.99,
            },
        },
        cmds = {
            vifm_cmd = "vifmrun",
        },
    })
end

function config.toggleterm_nvim()
    local toggleterm_terminal_status_ok, toggleterm_terminal = pcall(require, "toggleterm.terminal")
    if not toggleterm_terminal_status_ok then
        return
    end
    local terminal_float = toggleterm_terminal.Terminal:new({
        count = 4,
        direction = "float",
        float_opts = {
            border = "single",
            winblend = 0,
            width = vim.o.columns - 20,
            height = vim.o.lines - 9,
            highlights = {
                border = "FloatBorder",
                background = "NormalFloat",
            },
        },
        on_open = function(term)
            vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<Esc>", "<cmd>close<cr>", { noremap = true, silent = true })
            vim.api.nvim_buf_set_keymap(
                term.bufnr,
                "t",
                "<Esc>",
                "<c-\\><c-n><cmd>close<cr><c-w><c-p>",
                { noremap = true }
            )
            vim.wo.cursorcolumn = false
            vim.wo.cursorline = false
            vim.cmd("startinsert!")
        end,
        on_close = function()
            vim.cmd("quit!")
        end,
    })
    local terminal_one = toggleterm_terminal.Terminal:new({
        count = 1,
        direction = "horizontal",
        on_open = function(term)
            vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<Esc>", "<cmd>close<cr>", { noremap = true, silent = true })
            vim.api.nvim_buf_set_keymap(
                term.bufnr,
                "t",
                "<Esc>",
                "<c-\\><c-n><cmd>close<cr><c-w><c-p>",
                { noremap = true, silent = true }
            )
            vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-x>", "<c-\\><c-n>", { noremap = true, silent = true })
            vim.wo.cursorcolumn = false
            vim.wo.cursorline = false
            vim.cmd("startinsert!")
            vim.api.nvim_exec([[exe "normal \<C-W>\="]], true)
        end,
        on_close = function()
            vim.cmd("quit!")
        end,
    })
    local terminal_two = toggleterm_terminal.Terminal:new({
        count = 2,
        direction = "horizontal",
        on_open = function(term)
            vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<Esc>", "<cmd>close<cr>", { noremap = true, silent = true })
            vim.api.nvim_buf_set_keymap(
                term.bufnr,
                "t",
                "<Esc>",
                "<c-\\><c-n><cmd>close<cr><c-w><c-p>",
                { noremap = true, silent = true }
            )
            vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-x>", "<c-\\><c-n>", { noremap = true, silent = true })
            vim.wo.cursorcolumn = false
            vim.wo.cursorline = false
            vim.cmd("startinsert!")
            vim.api.nvim_exec([[exe "normal \<C-W>\="]], true)
        end,
        on_close = function()
            vim.cmd("quit!")
        end,
    })
    local terminal_three = toggleterm_terminal.Terminal:new({
        count = 3,
        direction = "horizontal",
        on_open = function(term)
            vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<Esc>", "<cmd>close<cr>", { noremap = true, silent = true })
            vim.api.nvim_buf_set_keymap(
                term.bufnr,
                "t",
                "<Esc>",
                "<c-\\><c-n><cmd>close<cr><c-w><c-p>",
                { noremap = true, silent = true }
            )
            vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-x>", "<c-\\><c-n>", { noremap = true, silent = true })
            vim.wo.cursorcolumn = false
            vim.wo.cursorline = false
            vim.cmd("startinsert!")
            vim.api.nvim_exec([[exe "normal \<C-W>\="]], true)
        end,
        on_close = function()
            vim.cmd("quit!")
        end,
    })
    function _G.toggleterm_float_toggle()
        terminal_float:toggle()
    end
    function _G.toggleterm_one_toggle()
        terminal_one:toggle()
    end
    function _G.toggleterm_two_toggle()
        terminal_two:toggle()
    end
    function _G.toggleterm_three_toggle()
        terminal_three:toggle()
    end
    vim.api.nvim_create_user_command("TTFloat", "lua _G.toggleterm_float_toggle()", {})
    vim.api.nvim_create_user_command("TTOne", "lua _G.toggleterm_one_toggle()", {})
    vim.api.nvim_create_user_command("TTTwo", "lua _G.toggleterm_two_toggle()", {})
    vim.api.nvim_create_user_command("TTThree", "lua _G.toggleterm_three_toggle()", {})
end

function config.zen_mode_nvim()
    local zen_mode_status_ok, zen_mode = pcall(require, "zen-mode")
    if not zen_mode_status_ok then
        return
    end
    zen_mode.setup({
        window = {
            options = {
                number = false,
                relativenumber = false,
            },
        },
        plugins = {
            gitsigns = {
                enabled = true,
            },
        },
    })
end

function config.twilight_nvim()
    local twilight_status_ok, twilight = pcall(require, "twilight")
    if not twilight_status_ok then
        return
    end
    twilight.setup({
        dimming = {
            alpha = 0.5,
        },
    })
end

function config.neozoom_lua()
    local neo_zoom_status_ok, neo_zoom = pcall(require, "neo-zoom")
    if not neo_zoom_status_ok then
        return
    end
    neo_zoom.setup({})
    vim.keymap.set("n", "<C-z>", function()
        vim.cmd("NeoZoomToggle")
    end, NOREF_NOERR_TRUNC)
end

function config.stay_in_place()
    local stay_in_place_status_ok, stay_in_place = pcall(require, "stay-in-place")
    if not stay_in_place_status_ok then
        return
    end
    stay_in_place.setup({})
end

function config.indent_blankline_nvim()
    local indent_blankline_status_ok, indent_blankline = pcall(require, "indent_blankline")
    if not indent_blankline_status_ok then
        return
    end
    indent_blankline.setup({
        char = "▏",
        show_first_indent_level = true,
        show_trailing_blankline_indent = true,
        show_current_context = true,
        context_patterns = {
            "class",
            "function",
            "method",
            "block",
            "list_literal",
            "selector",
            "^if",
            "^table",
            "if_statement",
            "while",
            "for",
        },
        filetype_exclude = {
            "startify",
            "dashboard",
            "dotooagenda",
            "log",
            "fugitive",
            "gitcommit",
            "packer",
            "vimwiki",
            "markdown",
            "json",
            "txt",
            "vista",
            "help",
            "todoist",
            "NvimTree",
            "peekaboo",
            "git",
            "TelescopePrompt",
            "undotree",
            "org",
            "flutterToolsOutline",
        },
        buftype_exclude = {
            "terminal",
            "nofile",
        },
    })
end

function config.nvim_notify()
    local notify_status_ok, notify = pcall(require, "notify")
    if not notify_status_ok then
        return
    end
    notify.setup({
        background_colour = "#2A3339",
        icons = {
            DEBUG = " ",
            ERROR = " ",
            INFO = " ",
            TRACE = " ",
            WARN = " ",
        },
        stages = "fade",
        on_open = function(win)
            if vim.api.nvim_win_is_valid(win) then
                vim.api.nvim_win_set_config(win, {
                    border = { " ", " ", " ", " ", " ", " ", " ", " " },
                    zindex = 200,
                })
            end
        end,
    })
    notify.print_history = function()
        local color = {
            DEBUG = "NotifyDEBUGTitle",
            TRACE = "NotifyTRACETitle",
            INFO = "NotifyINFOTitle",
            WARN = "NotifyWARNTitle",
            ERROR = "NotifyERRORTitle",
        }
        for _, m in ipairs(notify.history()) do
            vim.api.nvim_echo({
                { vim.fn.strftime("%FT%T", m.time), "Identifier" },
                { " ", "Normal" },
                { m.level, color[m.level] or "Title" },
                { " ", "Normal" },
                { table.concat(m.message, " "), "Normal" },
            }, false, {})
        end
    end
    vim.cmd("command! Message :lua require('notify').print_history()<CR>")
    vim.notify = notify
end

function config.lvim_focus()
    require("lvim-focus").setup({
        colorcolumn = true,
        colorcolumn_value = "120",
    })
end

function config.lvim_helper()
    local lvim_helper_status_ok, lvim_helper = pcall(require, "lvim-helper")
    if not lvim_helper_status_ok then
        return
    end
    local global = require("core.global")
    lvim_helper.setup({
        files = {
            global.home .. "/.config/nvim/help/lvim_bindings_normal_mode.md",
            global.home .. "/.config/nvim/help/lvim_bindings_visual_mode.md",
            global.home .. "/.config/nvim/help/lvim_bindings_debug_dap.md",
            global.home .. "/.config/nvim/help/vim_cheat_sheet_global.md",
            global.home .. "/.config/nvim/help/vim_cheat_sheet_cursor_movement.md",
            global.home .. "/.config/nvim/help/vim_cheat_sheet_visual_mode.md",
            global.home .. "/.config/nvim/help/vim_cheat_sheet_visual_commands.md",
            global.home .. "/.config/nvim/help/vim_cheat_sheet_insert_mode.md",
            global.home .. "/.config/nvim/help/vim_cheat_sheet_editing.md",
            global.home .. "/.config/nvim/help/vim_cheat_sheet_registers.md",
            global.home .. "/.config/nvim/help/vim_cheat_sheet_marks_and_positions.md",
            global.home .. "/.config/nvim/help/vim_cheat_sheet_macros.md",
            global.home .. "/.config/nvim/help/vim_cheat_sheet_cut_and_paste.md",
            global.home .. "/.config/nvim/help/vim_cheat_sheet_indent_text.md",
            global.home .. "/.config/nvim/help/vim_cheat_sheet_exiting.md",
            global.home .. "/.config/nvim/help/vim_cheat_sheet_search_and_replace.md",
            global.home .. "/.config/nvim/help/vim_cheat_sheet_search_in_multiple_files.md",
            global.home .. "/.config/nvim/help/vim_cheat_sheet_tabs.md",
            global.home .. "/.config/nvim/help/vim_cheat_sheet_working_with_multiple_files.md",
            global.home .. "/.config/nvim/help/vim_cheat_sheet_diff.md",
        },
    })
end

return config
