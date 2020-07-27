" Install Vim Plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

" function {{{
function! EnsureDirExits (dir)
    if !isdirectory(a:dir)
        if exists("*mkdir")
            call mkdir(a:dir, 'p')
            echo "Created directory: " . a:dir
        else
            echo "please create directory: " . a:dir
        endif
    endif
endfunction
" }}}

" Specify a directory for plugins ( for Neovim: ~/.config/nvim/plugged ) {{{
call plug#begin('~/.config/nvim/plugged')
Plug 'gruvbox-community/gruvbox'
Plug 'tomasiser/vim-code-dark'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rbgrouleff/bclose.vim'
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'honza/vim-snippets'
Plug 'tomtom/tcomment_vim'
Plug 'thinca/vim-quickrun'
" escape stop input chinese
Plug 'lyokha/vim-xkbswitch'
Plug 'rlue/vim-barbaric'

Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'

Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf',{'dir': '~/.fzf', 'do': './install --all'}
Plug 'tracyone/fzf-funky',{'on': 'FzfFunky'}
Plug 'francoiscabrol/ranger.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'simnalamburt/vim-mundo'
" Plug 'terryma/vim-multiple-cursors'
Plug 'scrooloose/nerdtree'
" Plug 'easymotion/vim-easymotion'
Plug 'travisjeffery/vim-auto-mkdir'
Plug 'bantana/vim-article'
Plug 'liuchengxu/graphviz.vim'
" Plug 'lervag/vimtex', {'for': ['tex', 'plaintex', 'bst']}
" Plug 'liuchengxu/vista.vim'
Plug 'dart-lang/dart-vim-plugin'
" Plug 'https://gn.googlesource.com/gn', { 'rtp': 'tools/gn/misc/vim' }
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
Plug 'rhysd/vim-clang-format'
" Plug 'udalov/kotlin-vim'
" Plug 'pechorin/any-jump.vim'
Plug 'dense-analysis/ale'
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
Plug 'bluk/swifty-vim'
" Plug 'bantana/swift'
Plug 'editorconfig/editorconfig-vim'
call plug#end()
" }}}

" Color Scheme {{{
" set t_Co=256
" set termguicolors
" set background=dark
" hi Search term=reverse cterm=reverse gui=reverse ctermfg=237
" colorscheme codedark
colorscheme gruvbox
" }}}

" basic {{{
set nolazyredraw
set nocompatible
syntax enable
filetype plugin indent on
set mouse=i

" set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
" set enc=utf8
" set fencs=utf8,gbk,gb2312,gb18030

set showcmd
set showmode
set backspace=indent,eol,start
set wildmenu
set wildmode=list:longest
set ignorecase
set smartcase
set number
set relativenumber
set ruler
set incsearch
set hlsearch
set wrap
set scrolloff=3
set title
set visualbell
set shell=bash

set ofu=syntaxcomplete#Complete
" Map cursor for insert mode
let &t_SI .= "\<Esc>[5 q"
" solid block
let &t_EI .= "\<Esc>[2 q"

" }}}

" Tabs, spaces, wrapping {{{
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set wrap
" set textwidth=110 "80-width lines is for 1995"
let &wrapmargin=&textwidth
set formatoptions=qrn1
autocmd Filetype vue setlocal ts=2 sw=2 expandtab
" }}}

" mapleader {{{
let mapleader = " "
let maplocalleader = "\\"
" }}}

" copy {{{
" pbcopy
if has('mac')
    let g:clipboard = {
                \   'name': 'macOS-clipboard',
                \   'copy': {
                \      '+': 'pbcopy',
                \      '*': 'pbcopy',
                \    },
                \   'paste': {
                \      '+': 'pbpaste',
                \      '*': 'pbpaste',
                \   },
                \   'cache_enabled': 0,
                \ }
    let g:rust_clip_command = 'pbcopy'
elseif has('linux')
    vmap "+y :!xclip -f -sel clip
    map "+p :r!xclip -o -sel clip
    let g:rust_clip_command = 'xclip -selection clipboard'
endif
if has('clipboard')
    set clipboard& clipboard+=unnamedplus
endif
" }}}

" vim-go {{{
let g:go_metalinter_autosave = 1
let g:go_auto_type_info = 1
" :GoInfo update time Default->800
autocmd FileType go set updatetime=100
au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4
" }}}


" coc.nvim extensions {{{
let g:coc_global_extensions = [
            \ 'coc-diagnostic',
            \ 'coc-json',
            \ 'coc-yaml',
            \ 'coc-git',
            \ 'coc-snippets',
            \ 'coc-pairs',
            \ 'coc-vimlsp',
            \ 'coc-clangd',
            \ 'coc-translator',
            \ 'coc-rls',
            \ 'coc-rust-analyzer',
            \ 'coc-prettier',
            \ 'coc-sh',
            \ 'coc-marketplace',
            \ 'coc-tsserver',
            \ 'coc-deno',
            \ ]
" }}}

" coc.nvim settings {{{
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
    " Use `complete_info` if your (Neo)Vim version supports it.
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>gn <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>Rf <Plug>(coc-refactor)

" Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

" augroup mygroup
"     autocmd!
"     " Setup formatexpr specified filetype(s).
"     autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"     " Update signature help on jump placeholder.
"     autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>s  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>o
" }}}

" golang {{{
augroup golang
    " this one is which you're most likely to use?
    autocmd FileType go nnoremap <buffer> <leader>gi :GoImport<space>
    autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
augroup end
" }}}

" shortkey {{{
nnoremap <leader>ev :e ~/.config/nvim/init.vim<CR>
nnoremap <ESC><ESC> :nohlsearch<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>/ :Ack!<Space>
" nnoremap <leader>m :TagbarToggle<CR>
nnoremap <leader>q :Bclose<CR>
nnoremap <leader>gt :Gist

nnoremap <leader>es :CocCommand snippets.editSnippets<CR>
nnoremap <leader>epac :e ~/Library/Application Support/V2RayX/pac/pac.js<CR>
nmap <Leader>t <Plug>(coc-translator-p)
vmap <Leader>t <Plug>(coc-translator-pv)
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" nnoremap <leader>z :new<CR>:terminal bash --rcfile ~/.bash_profile<CR>
nnoremap <silent> <leader>z :sp term://bash --rcfile ~/.bash_profile<CR>
"
" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
if has('nvim')
    augroup vimrc_term
        autocmd!
        autocmd WinEnter term://* nohlsearch
        autocmd WinEnter term://* startinsert

        autocmd TermOpen * tnoremap <buffer> <C-h> <C-\><C-n><C-w>h
        autocmd TermOpen * tnoremap <buffer> <C-j> <C-\><C-n><C-w>j
        autocmd TermOpen * tnoremap <buffer> <C-k> <C-\><C-n><C-w>k
        autocmd TermOpen * tnoremap <buffer> <C-l> <C-\><C-n><C-w>l
        autocmd TermOpen * tnoremap <buffer> <Esc> <C-\><C-n>
    augroup end
endif
" }}}

" vim-quickrun {{{
let g:quickrun_config = {
            \    "_" : {
            \        "outputter" : "message",
            \    },
            \    'dart': {
            \       'command': 'dart',
            \       'cmdopt': '--enable-asserts',
            \    }
            \}
" }}}
" vim-barbaric {{{
" install:
" curl -o /usr/local/bin/xkbswitch https://raw.githubusercontent.com/myshov/xkbswitch-macosx/master/bin/xkbswitch
" chmod +x /usr/local/bin/xkbswitch

" The input method for Normal mode (as defined by `xkbswitch -g` or `ibus engine`)
let g:barbaric_default = 0

" The scope where alternate input methods persist (buffer, window, tab, global)
let g:barbaric_scope = 'buffer'

" Forget alternate input method after n seconds in Normal mode (disabled by default)
" Useful if you only need IM persistence for short bursts of active work.
let g:barbaric_timeout = -1
" }}}
" Zoom panel {{{
function! Zoom ()
    " check if is the zoomed state (tabnumber > 1 && window == 1)
    if tabpagenr('$') > 1 && tabpagewinnr(tabpagenr(), '$') == 1
        let l:cur_winview = winsaveview()
        let l:cur_bufname = bufname('')
        tabclose

        " restore the view
        if l:cur_bufname == bufname('')
            call winrestview(cur_winview)
        endif
    else
        tab split
    endif
endfunction

nmap <leader>b :call Zoom()<CR>
" }}}

" split naviagation {{{
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" }}}

" fzf-funky {{{
" Plug 'junegunn/fzf',{'dir': '~/.fzf', 'do': './install --all'}
" Plug 'tracyone/fzf-funky',{'on': 'FzfFunky'}
nnoremap <Leader>fu :FzfFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'FzfFunky ' . expand('<cword>')<Cr>
" }}}

" coc-pairs {{{
" :CocInstall coc-pairs
autocmd FileType tex let b:coc_pairs = [["$", "$"]]
" autocmd FileType markdown let b:coc_pairs_disabled = ['`']
autocmd FileType vim let b:coc_pairs_disabled = ['"']
" }}}
let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ 'active': {
            \   'left': [
            \     [ 'mode', 'paste' ],
            \     [ 'gitbranch', 'ctrlpmark', 'git', 'diagnostic', 'cocstatus', 'filename', 'method', 'modified' ]
            \   ],
            \   'right':[
            \     [ 'filetype', 'fileencoding', 'lineinfo', 'percent' ],
            \     [ 'blame' ]
            \   ],
            \ },
            \ 'component_function': {
            \   'gitbranch': 'fugitive#head',
            \   'blame': 'LightlineGitBlame',
            \ }
            \ }

function! LightlineGitBlame() abort
    let blame = get(b:, 'coc_git_blame', '')
    " return blame
    return winwidth(0) > 120 ? blame : ''
endfunction

" }}}

" Command for fzf {{{
nnoremap <C-p> :<C-u>FZF<CR>

if has('nvim')
    let $FZF_DEFAULT_OPTS='--layout=reverse'
    let g:fzf_layout = { 'window': 'call OpenFloatingWin()' }
    function! OpenFloatingWin()
        let height = &lines - 3
        let width = float2nr(&columns - (&columns * 2 / 10))
        let col = float2nr((&columns - width) / 2)

        " 设置浮动窗口打开的位置，大小等。
        " 这里的大小配置可能不是那么的 flexible 有继续改进的空间
        let opts = {
                    \ 'relative': 'editor',
                    \ 'row': height * 0.3,
                    \ 'col': col + 25,
                    \ 'width': width * 2 / 3,
                    \ 'height': height / 2
                    \ }

        let buf = nvim_create_buf(v:false, v:true)
        let win = nvim_open_win(buf, v:true, opts)

        " 设置浮动窗口高亮
        call setwinvar(win, '&winhl', 'Normal:Pmenu')

        setlocal
                    \ buftype=nofile
                    \ nobuflisted
                    \ bufhidden=hide
                    \ nonumber
                    \ norelativenumber
                    \ signcolumn=no
    endfunction
endif
" }}}

" Command for shortkey {{{
inoremap jj <ESC>
" }}}

" vim-mundo ------- {{{
set undofile
nnoremap <leader>u :MundoToggle<cr>
let g:mundo_debug = 1
let g:mundo_preview_bottom = 1
let g:mundo_tree_statusline = "mundo"
let g:mundo_preview_statusline = "mundo preview"
" }}}

" python {{{
if has('mac')
    let g:python3_host_prog="/usr/local/bin/python3"
elseif has('linux')
    let g:python3_host_prog="/usr/bin/python3"
endif
" }}}

" coc-vimlsp {{{
" document highlight
let g:markdown_fenced_languages = [
            \ 'vim',
            \ 'help'
            \]
" }}}

" vimtex {{{
" require: brew cask install mactex skim
let g:tex_flavor='latex'
let g:vimtex_view_method='skim'
let g:vimtex_quickfix_mode=0
set conceallevel=0
let g:tex_conceal='abdmg'
let g:Tex_CompileRule_pdf='xelatex -interaction=nonstopmode $*'
let g:vimtex_compiler_enabled=1
let g:vimtex_compiler_progname='nvr'
let g:vimtex_view_general_options
            \ = '-reuse-instance -forward-search @tex @line @pdf'
let g:vimtex_view_general_options_latexmk = '-reuse-instance'

" TOC settings
let g:vimtex_toc_config = {
            \ 'name' : 'TOC',
            \ 'layers' : ['content', 'todo', 'include'],
            \ 'resize' : 1,
            \ 'split_width' : 50,
            \ 'todo_sorted' : 0,
            \ 'show_help' : 1,
            \ 'show_numbers' : 1,
            \ 'mode' : 2,
            \}
"
" }}}

" graphviz {{{
" How to open the generated output file.
" If does not exist, graphviz.vim will automatically choose the right way depending on the platform.
"let g:graphviz_viewer = 'open'
let g:graphviz_viewer = 'skim'

" Default output format. Default is 'pdf'.
let g:graphviz_output_format = 'pdf'

" Options passed on to dot. Default is ''.
let g:graphviz_shell_option = ''
augroup graphviz
    " this one is which you're most likely to use?
    "autocmd FileType dot nnoremap <buffer> <leader>gb :GraphvizCompile<CR> :Graphviz! pdf<CR>
    autocmd FileType dot nnoremap <buffer> <leader>gb :GraphvizCompile<CR>
augroup end
" }}}

" "+++ Spelling +++ {{{
let g:spellfile_URL = 'http://ftp.vim.org/vim/runtime/spell'
set spelllang=en_us
setlocal spell spelllang=en_us
set spellfile=~/.config/nvim/spell/en.utf-8.add
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.txt setlocal spell
autocmd BufRead,BufNewFile *.article setlocal spell

autocmd FileType gitcommit setlocal spell
set complete+=kspell
" }}}

" Nerdtree {{{
map <leader>n :NERDTreeToggle<cr>
map <leader>nn :NERDTree %<cr>
let NERDTreeIgnore=['node_modules']
" autocmd BufWritePost * NERDTreeFocus | execute 'normal R' | wincmd p
" }}}
" range {{{
map <leader>rg :Ranger<CR>
let g:ranger_map_keys = 0
let g:NERDTreeHijackNetrw = 0 "// add this line if you use NERDTree
let g:ranger_replace_netrw = 1 "// open ranger when vim open a directory
" }}}
" " clang-format {{{
" let g:clang_format#command="clang-format"
" let g:clang_format#code_style="Mozilla"
" let g:clang_format#detect_style_file=1
" let g:clang_format#auto_format=1
" " }}}
" coc-cursors {{{
" nmap <silent> <C-c> <Plug>(coc-cursors-position)
" nmap <silent> <C-d> <Plug>(coc-cursors-word)
" xmap <silent> <C-d> <Plug>(coc-cursors-range)
" " use normal command like `<leader>xi(`
" nmap <leader>x  <Plug>(coc-cursors-operator)
nmap <silent> <C-d> <Plug>(coc-cursors-word)*
xmap <silent> <C-d> y/\V<C-r>=escape(@",'/\')<CR><CR>gN<Plug>(coc-cursors-range)gn
" }}}
" tcomment graphviz dot file {{{
if !exists("g:tcomment#filetype#guess_dot")
    let g:tcomment#filetype#guess_dot='go'
endif
if !exists("g:tcomment#filetype#guess_c")
    let g:tcomment#filetype#guess_c='go'
endif
if !exists("g:tcomment#filetype#guess_json")
    let g:tcomment#filetype#guess_json='go'
endif
if !exists("g:tcomment#filetype#guess_swift")
    let g:tcomment#filetype#guess_json='go'
endif
" }}}
" " ALE {{{
" " Load all plugins now.
" " Plugins need to be added to runtimepath before helptags can be generated.
" packloadall
" " Load all of the helptags now, after plugins have been loaded.
" " All messages and errors will be ignored.
" silent! helptags ALL
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" Map movement through errors without wrapping.
nmap <silent> <leader>ap <Plug>(ale_previous)
nmap <silent> <leader>an <Plug>(ale_next)
" OR map keys to use wrapping.
nmap <silent> <leader>ap <Plug>(ale_previous_wrap)
nmap <silent> <leader>an <Plug>(ale_next_wrap)
" highlight ALEWarning ctermbg=DarkMagenta
" let g:ale_set_loclist = 0
" let g:ale_set_quickfix = 1
" let g:ale_open_list = 1
" " Set this if you want to.
" " This can be useful if you are combining ALE with
" " some other plugin which sets quickfix errors, etc.
" let g:ale_keep_list_window_open = 1
"  " Show 5 lines of errors (default: 10)
" let g:ale_list_window_size = 5
" let g:ale_c_clang_executable='clang'
" let g:ale_c_clang_options='-std=c11 -Wall'
" let g:ale_c_clangd_executable='clangd'
" let g:ale_c_clangtidy_executable='clang-tidy'
" let g:ale_c_clangformat_executable='clang-format'
let g:ale_linters_ignore = {'c': ['gcc']}
" " }}}
"
highlight link CocErrorSign GruvboxRed
" nnoremap <leader>m :!swiftformat --swiftversion 5 % --quiet<cr>:bufdo :e!<cr>
nnoremap <leader>m :!swift-format -i %<cr>:bufdo :e!<cr>
au BufWritePre,FileWritePre *.swift :SwiftFormat<cr>

autocmd BufNewFile,BufRead *.toml set ft=cfg
nmap <leader>l :bn<cr>

" vim-racer {{{
set hidden
let g:racer_cmd = "~/.cargo/bin/racer"
let g:racer_experimental_completer = 1
let g:racer_insert_paren = 1
" }}}
"
set autoread
au FocusGained,BufEnter * :checktime

" " scala {{{
" au BufRead,BufNewFile *.sbt set filetype=scala
" autocmd FileType json syntax match Comment +\/\/.\+$+
" " }}}
let g:swift_version_check = 0
" shortkey usage {{{
" Move the current window to L|H|J|K
" Ctrl-w + L[H|J|K]
" }}}
"
