local keymaps = {}

keymaps["normal"] = {
    {"<F1>", ":TTOne<CR>"}, -- Toggleterm one open
    {"<F2>", ":TTTwo<CR>"}, -- Toggleterm two open
    {"<F3>", ":TTThree<CR>"}, -- Toggleterm three open
    {"<F4>", ":TTFloat<CR>"}, -- Toggleterm float open
    {"<F5>", ":UndotreeToggle<CR>"}, -- UndoTree toggle
    {"<F11>", ":LvimHelper<CR>"}, -- LvimHelper
    {"<space><space>", ":CtrlSpace<CR>"}, -- CtrlSpace
    {"<Esc>", "<Esc>:noh<CR>"}, -- Remove highlight after search
    {"<C-c>n", ":e %:h/filename<CR>"}, -- Create new file in current directory
    {"<C-s>", ":w<CR>"}, -- Save
    {"<C-c>a", ":wa<CR>"}, -- Save all
    {"<C-c>e", ":qa!<CR>"}, -- Close all, exit nvim
    {"<C-c>x", "<C-w>c"}, -- Close current window
    {"<C-c>o", "<C-w>o"}, -- Close other windows
    {"<C-c>d", ":bdelete<CR>"}, -- BDelete
    {"<C-n>", ":BufSurfForward<CR>"}, -- Next buffer
    {"<C-p>", ":BufSurfBack<CR>"}, -- Previews buffer
    {"<C-c>b", ":GitBlameToggle<CR>"}, -- Git blame toggle
    {"<C-h>", "<C-w>h"}, -- Move to window left
    {"<C-l>", "<C-w>l"}, -- Move to window right
    {"<C-j>", "<C-w>j"}, -- Move to window down
    {"<C-k>", "<C-w>k"}, -- Move to window up
    {"<C-z>", ":Zoom<CR>"}, -- Move to window up
    {"<C-Left>", ":vertical resize -2<CR>"}, -- Resize width -
    {"<C-Right>", ":vertical resize +2<CR>"}, -- Resize width +
    {"<C-Up>", ":resize -2<CR>"}, -- Resize height -
    {"<C-Down>", ":resize +2<CR>"}, -- Resize height +
    {"<C-]>", ":GitSignsNextHunk<CR>"}, -- Git signs next hunk
    {"<C-[>", ":GitSignsPrevHunk<CR>"}, -- Git signs prev hunk
    {"<S-u>", ":GitSignsPreviewHunk<CR>"}, -- Git signs preview hunk
    {"<S-x>", ":NvimTreeToggle<CR>"}, -- Nvim tree explorer
    {"<S-m>", ":MarkdownPreviewToggle<CR>"}, -- Markdown preview toggle
    {"<A-,>", ":Telescope find_files<CR>"}, -- Search files with Telescope
    {"<A-.>", ":Telescope live_grep<CR>"}, -- Search word with Telescope
    {"<A-/>", ":TelescopeBrowser<CR>"}, -- Telescope browser
    {"<A-j>", ":AnyJump<CR>"}, -- Any jump
    {"<A-v>", ":SymbolsOutline<CR>"}, -- Symbols outline
    {"<A-[>", ":foldopen<CR>:IndentBlanklineRefresh<CR>"}, -- Fold open
    {"<A-]>", ":foldclose<CR>:IndentBlanklineRefresh<CR>"}, -- Fold close
    {"<A-f>", ":LspFormatting<CR>"}, -- Lsp format code
    {"<A-t>", ":LspCodeAction<CR>"}, -- Lsp action
    {"<A-s>", ":Spectre<CR>"}, -- Replace in multiple files
    {"<A-g>", ":LspReferences<CR>"}, -- Lsp references
    {"<A-d>", ":LspDefinition<CR>"}, -- Lsp definition
    {"<A-c>", ":LspDeclaration<CR>"}, -- Lsp declaration
    {"<A-h>", ":LspHover<CR>"}, -- Lsp hover
    {"<A-r>", ":LspRename<CR>"}, -- Lsp rename
    {"<A-n>", ":LspGoToNext<CR>"}, -- Lsp go to next
    {"<A-p>", ":LspGoToPrev<CR>"}, -- Lsp go to prev
    {"<A-e>", ":TroubleToggle<CR>"}, -- Trouble toggle
    {"<A-*>", ":LspVirtualTextToggle<CR>"}, -- Lsp virtual text toggle
    {"<A-1>", "<Cmd>DapToggleBreakpoint<CR>"}, -- Toggle breakpoint
    {"<A-2>", "<Cmd>DapStartContinue<CR>"}, -- Start / continue
    {"<A-3>", "<Cmd>DapStepInto<CR>"}, -- Step into
    {"<A-4>", "<Cmd>DapStepOver<CR>"}, -- Step over
    {"<A-5>", "<Cmd>DapStepOut<CR>"}, -- Step out
    {"<A-6>", "<Cmd>DapUp<CR>"}, -- Up
    {"<A-7>", "<Cmd>DapDown<CR>"}, -- Down
    {"<A-8>", "<Cmd>DapUIClose<CR>"}, -- UI close
    {"<A-9>", "<Cmd>DapRestart<CR>"}, -- Restart
    {"<A-0>", "<Cmd>DapToggleRepl<CR>"}, -- Toggle Repl
    {"tn", ":tabn<CR>"}, -- Tab next
    {"tp", ":tabp<CR>"}, -- Tab prev
    {"tt", ":Telescope tmux sessions<CR>"}, -- Telescope tmux session
    {"zo", "zo:IndentBlanklineRefresh<CR>"}, -- Fix indent + fold lines
    {"zO", "zO:IndentBlanklineRefresh<CR>"}, -- Fix indent + fold lines
    {"zc", "zc:IndentBlanklineRefresh<CR>"}, -- Fix indent + fold lines
    {"zC", "zC:IndentBlanklineRefresh<CR>"}, -- Fix indent + fold lines
    {"za", "za:IndentBlanklineRefresh<CR>"}, -- Fix indent + fold lines
    {"zA", "zA:IndentBlanklineRefresh<CR>"}, -- Fix indent + fold lines
    {"zv", "zv:IndentBlanklineRefresh<CR>"}, -- Fix indent + fold lines
    {"zx", "zx:IndentBlanklineRefresh<CR>"}, -- Fix indent + fold lines
    {"zX", "zX:IndentBlanklineRefresh<CR>"}, -- Fix indent + fold lines
    {"zm", "zm:IndentBlanklineRefresh<CR>"}, -- Fix indent + fold lines
    {"zM", "zM:IndentBlanklineRefresh<CR>"}, -- Fix indent + fold lines
    {"zr", "zr:IndentBlanklineRefresh<CR>"}, -- Fix indent + fold lines
    {"zR", "zR:IndentBlanklineRefresh<CR>"} -- Fix indent + fold lines
}

keymaps["visual"] = {
    {"<", "<gv"}, -- Tab left
    {">", ">gv"}, -- Tab right
    {"*", "<Esc>/\\%V"}, -- Visual search /
    {"#", "<Esc>?\\%V"}, -- Visual search ?
    {"K", ":move '<-2<CR>gv-gv"}, -- Move up
    {"J", ":move '>+1<CR>gv-gv"}, -- Move down
    {"<A-j>", ":AnyJumpVisual<CR>"}, -- Any jump visual
    {"<A-/>", ":CommentToggle<CR>"} -- Comment toggle
}

return keymaps
