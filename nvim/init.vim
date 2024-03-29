if has('unix')
    if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
        silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
                    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
endif

call plug#begin('$HOME/.nvim/plugged')
Plug 'Olical/conjure'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'bakpakin/fennel.vim'
Plug 'beyondmarc/glsl.vim'
Plug 'habamax/vim-godot'
Plug 'honza/vim-snippets' " needs a snippet engine to function
Plug 'dcampos/nvim-snippy'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'peterhoeg/vim-qml'
Plug 'plasticboy/vim-markdown'
Plug 'rafcamlet/coc-nvim-lua'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'rhysd/vim-clang-format'
Plug 'rust-lang/rust.vim'
Plug 'schme/vim-paredit'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'wlangstroth/vim-racket'
Plug 'tom-doerr/vim_codex'
call plug#end()

" Required so that most themes don't fallback to 16 colors or be otherwise shitty!
set termguicolors
set background=dark
colorscheme alduin
"set colorcolumn=120,200
"highlight ColorColumn guibg=grey

let mapleader="\<space>"
let maplocalleader="§"

set showmatch			" Show matching brackets.
set expandtab
set tabstop=4			" Render TABs using this many spaces.
set shiftwidth=4		" Indentation amount for < and > commands.
set nojoinspaces		" Prevents inserting two spaces after punctuation on a join (J)
set number 				" Show the line numbers on the left side.
set nowrap
set ignorecase
set smartcase
set smartindent
set undofile
set laststatus=3
set textwidth=100
set secure
set exrc

highlight ExtraWhitespace ctermbg=darkgreen guibg=black

"Show trailing whitespace AND spaces before a tab
"match ExtraWhitespace /\s\+$\| \+\ze\t/
" Show spaces used for indenting
"match ExtraWhitespace /^\t*\zs \+/

" Ignore some files
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*.obj,*.map,*.pdb,*.idb  " Windows
set wildignore+=*\\build\\*,*.o,*.odp,*.pdf,*.odg,*.vcxproj*,*.odt,*.fbt,*.fbr,*.dll,*.lib

if has('win32')
    let &grepprg='findstr /n /s /p $*'
endif


" Tagbar
nnoremap <c-q> :TagbarToggle<cr>
" vim-airline
" --------------------------------------
let g:airline#extensions#tabline#enabled = 2
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#right_sep = ' '
let g:airline#extensions#tabline#right_alt_sep = '|'
let g:airline_left_sep = ' '
let g:airline_left_alt_sep = '|'
let g:airline_right_sep = ' '
let g:airline_right_alt_sep = '|'
let g:airline_theme= 'minimalist'
" Nerdtree
nnoremap <c-e> :NERDTreeToggle<cr>
" vim-markdown
let g:vim_markdown_folding_disabled = 1

" clang-format
" Check FormatFile()
nmap <Leader>C :ClangFormatAutoToggle<CR>
" fzf
let g:fzf_command_prefix = 'Fzf'
if executable('ag')
    let $FZF_DEFAULT_COMMAND = 'ag --follow --ignore "*thirdparty*" -g ""'
endif
nnoremap <leader>f :FzfFiles<cr>
nnoremap <leader>/ :FzfAg<cr>
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" glsl

" GLSL defaults
"let g:glsl_default_version = 'glsl330'
let g:glsl_file_extensions = '*.glsl,*.vsh,*.fsh,*.vert,*.tesc,*.tese,*.geom,*.frag,*.comp,*.vs,*.fs,*.gs'

" Bind Remaps
" General mapedings
inoremap kj <esc>
nnoremap gj J
nnoremap <c-k> {
nnoremap <c-j> }
vnoremap gj J
vnoremap <c-k> {
vnoremap <c-j> }
nnoremap H 0
nnoremap L $

nnoremap <c-f> <c-f>zz
nnoremap <c-b> <c-b>zz

"  Need to remap tags due to finnish layout
nnoremap <c-i> <c-]>

" Use <C-N> to clear the highlighting of :set hlsearch.
if maparg('<leader>l', 'n') ==# ''
    nnoremap <silent> <leader>l :nohlsearch<cr>
endif

"Switch from header to cpp or vice versa
nnoremap <F4> :e %:p:s,.h$,.X123X,:s,.cc$,.h,:s,.X123X$,.cc,<cr>

"rust-vim
" change cargo command shell
" let g:cargo_shell_command_runner = '!'

function FormatFile()
    if &filetype ==# 'rust'
        :RustFmt
    elseif &filetype ==# 'cpp'
        :ClangFormat
    elseif &filetype ==# 'c'
        :ClangFormat
    else
        " todo: gq command
    endif
endfunction

function CheckProgram()
    if &filetype ==# 'rust'
        Cargo check
    endif
endfunction

function RunProgram()
    if &filetype ==# 'rust'
        Cargo run
    endif
    if &filetype ==# 'gdscript'
        :GodotRun
    endif
endfunction

" I'm a genious!
nnoremap ö :

nnoremap <F2> :call FormatFile()<cr>
nnoremap <F3> :call CheckProgram()<cr>
nnoremap <F5> :call RunProgram()<cr><cr>
"Go to previous error
nnoremap <F6> :cp<cr>
"Go to next error
nnoremap <F7> :cn<cr>
"Close quickfix
nnoremap <F8> :ccl<cr>
" Clear trailing whitespaces
nnoremap <silent> <F9> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <cr>
" Get ctags and dump tagfile in the current directory
"nnoremap <silent> <F10> :!ctags -R .<cr><cr>
" Easy word replace
nnoremap <F10> :%s/\<<C-r><C-w>\>/
nnoremap <F12> :vsplit $MYVIMRC<cr>
" Save
"nnoremap <c-s> <esc>:wa<cr>
" Since even split is so hard with nordic qwerty
nnoremap <leader>0 <c-w>=
" Automatic bracket thing on demand
"inoremap <leader>7 <cr>{<cr>}<Esc>ko
"inoremap <leader>8 <space>{<cr>}<Esc>ko

nnoremap <leader>n :tabnew<cr>
nnoremap <leader>qt :tabc<cr>

" Silver Searcher
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
endif

augroup vimrc     " Source vim configuration upon save
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
augroup end

function! SetFourTabNoExpandOptions()
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set noexpandtab
    set autoindent
    set fileformat=unix
endfunction

function! SetTwoTabNoExpandOptions()
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set noexpandtab
    set autoindent
    set fileformat=unix
endfunction

function! SetTwoTabExpandOptions()
    set tabstop=2
    set softtabstop=2
    set shiftwidth=2
    set expandtab
    set autoindent
endfunction

function! SetPythonOptions()
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set expandtab
    set autoindent
    set fileformat=unix
endfunction

function! RacketOptions()
    setlocal formatprg=raco\ fmt
endfunction

function! MarkdownOptions()
    call SetTwoTabExpandOptions()
    set wrap linebreak textwidth=0
endfunction

" C/C++ file settings
augroup filetype_cpp
    autocmd!
    au FileType cpp call SetFourTabNoExpandOptions()
augroup end

" Python file settings
augroup filetype_py
    au!
    "" Python PEP 8 indentation
    au FileType python call SetPythonOptions()
augroup end

" Rust things
augroup filetype_rust
    autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi
    autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!
augroup end

augroup filetype_javascript
    au!
    au FileType javascript call SetTwoTabExpandOptions()
augroup end

augroup filetype_css
    au!
    au FileType css,scss call SetTwoTabExpandOptions()
augroup end

augroup filetype_racket
    au!
    au FileType racket call RacketOptions()
augroup end

augroup filetype_md
    au!
    au FileType markdown call MarkdownOptions()
augroup end

" Use racket type for zuo files atm
au BufRead,BufNewFile *.zuo                set filetype=racket

" TreeSitter
let treesitter = 1
if treesitter

    lua <<EOF
    local languages = {"cpp", "c", "rust", "lua", "vim", "cmake", "bash", "python", "toml", "scheme"}
    require'nvim-treesitter.configs'.setup {
            ensure_installed = languages,
            sync_install = false,
            highlight = {
                enable = true
            },
        }
EOF

endif

" COC
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=auto

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
            \ coc#pum#visible() ? coc#pum#next(1):
            \ CheckBackspace() ? "\<Tab>" :
            \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        call feedkeys('K', 'in')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>y  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Conjure
let g:conjure#client#scheme#stdio#command = "scheme"
"" Not technically Conjure, but changed because of it
" highlight NormalFloat ctermbg=black guibg=black

imap <expr> <C-Tab> snippy#can_expand_or_advance() ? '<Plug>(snippy-expand-or-advance)' : '<C-Tab>'
imap <expr> <C-S-Tab> snippy#can_jump(-1) ? '<Plug>(snippy-previous)' : '<C-S-Tab>'
smap <expr> <C-Tab> snippy#can_jump(1) ? '<Plug>(snippy-next)' : '<C-Tab>'
smap <expr> <C-S-Tab> snippy#can_jump(-1) ? '<Plug>(snippy-previous)' : '<C-S-Tab>'
xmap <C-Tab> <Plug>(snippy-cut-text)
