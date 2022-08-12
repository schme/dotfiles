if has('unix')
	if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
		silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
			\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif
endif

call plug#begin('$HOME/.nvim/plugged')
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'beyondmarc/glsl.vim'
Plug 'cespare/vim-toml'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'easymotion/vim-easymotion'
Plug 'habamax/vim-godot'
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'peterhoeg/vim-qml'
Plug 'plasticboy/vim-markdown'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'ron-rs/ron.vim'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-liquid'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'wlangstroth/vim-racket'
Plug 'Olical/conjure'
Plug 'bakpakin/fennel.vim'
Plug 'vim-scripts/paredit.vim'

call plug#end()

set background=dark
"colorscheme PaperColor

let $LANG = 'en'

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

set ignorecase			" Make searching case insensitive
set smartcase			" ... unless the query has capital letters.
set smartindent

set undofile

highlight ExtraWhitespace ctermbg=darkgreen guibg=black

"Show trailing whitespace AND spaces before a tab
"match ExtraWhitespace /\s\+$\| \+\ze\t/
" Show spaces used for indenting
"match ExtraWhitespace /^\t*\zs \+/

if has('win32')
	let &grepprg='findstr /n /s /p $*'
endif


" Tagbar
nnoremap <c-q> :TagbarToggle<cr>

" Ignore some files
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*.obj,*.map,*.pdb,*.idb  " Windows
set wildignore+=*\\build\\*,*.o,*.odp,*.pdf,*.odg,*.vcxproj*,*.odt,*.fbt,*.fbr,*.dll,*.lib

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

"  vim-easymotion
let g:EasyMotion_leader_key = '<S-Q>'
map <S-Q> <Plug>(easymotion-prefix)

" fzf
let g:fzf_command_prefix = 'Fzf'

if executable('ag')
	let $FZF_DEFAULT_COMMAND = 'ag -g ""'
endif

nnoremap <leader>o :FzfFiles<cr>

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
nnoremap <F3> :e %:p:s,.h$,.X123X,:s,.cc$,.h,:s,.X123X$,.cc,<cr>

"rust-vim
" change cargo command shell
" let g:cargo_shell_command_runner = '!'


function CheckProgram()
	if &filetype ==# 'rust'
		Cargo check
	endif
endfunction

function RunProgram()
	if &filetype ==# 'rust'
		Cargo run
	endif
endfunction

" I'm a genious!
nnoremap ö :

nnoremap <F1> :vsplit $MYVIMRC<cr>

nnoremap <F2> :RustFmt<cr>

nnoremap <F4> :call CheckProgram()<cr>
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
nnoremap <silent> <F10> :!ctags -R .<cr><cr>

" Save
"nnoremap <c-s> <esc>:wa<cr>

" Since even split is so hard with nordic qwerty
nnoremap <leader>0 <c-w>=
" Easy word replace
nnoremap <leader>s :%s/\<<C-r><C-w>\>/
" Automatic bracket thing on demand
inoremap <leader>7 <cr>{<cr>}<Esc>ko
inoremap <leader>8 <space>{<cr>}<Esc>ko

nnoremap <leader>n :tabnew<cr>
nnoremap <leader>q :tabc<cr>

nnoremap <leader>t :vsplit <Bar> :terminal<cr>

" map away terminal!
tnoremap <leader>w <c-\><c-n>

" Grepper
nnoremap <leader>f :silent execute "grep! " . shellescape(expand("<cword>")) . " *.*"<cr>:copen<cr>

" Silver Searcher
if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor
	let g:ctrlp_user_command = 'ag %s -l -g ""'
endif


" MS Compiler Errors
" Thanks to https://forums.handmadehero.org/index.php/forum?view=topic&catid=4&id=704#3982
" error message formats
" Microsoft MSBuild
set errorformat+=\\\ %#%f(%l\\\,%c):\ %m
" Microsoft compiler: cl.exe
set errorformat+=\\\ %#%f(%l)\ :\ %#%t%[A-z]%#\ %m
" Microsoft HLSL compiler: fxc.exe
set errorformat+=\\\ %#%f(%l\\\,%c-%*[0-9]):\ %#%t%[A-z]%#\ %m

" Common file settings
augroup common_vimrc
	autocmd!
	" Set syntax folding
	"autocmd BufReadPre * setlocal foldmethod=syntax
	" Save and reload views
	"autocmd BufWinLeave * mkview
	"autocmd BufWinEnter * silent loadview
augroup end

" Vimscript file settings
augroup filetype_vim
	autocmd!
	" Config autoreload
	autocmd BufWritePost init.vim source $MYVIMRC
augroup end

" Terminal settings
"augroup terminal_settings
	"autocmd!
	"autocmd TermOpen * startinsert
"augroup end

function SetFourTabNoExpandOptions()
	set tabstop=4
	set softtabstop=4
	set shiftwidth=4
	set noexpandtab
	set autoindent
    set fileformat=unix
endfunction

function SetTwoTabNoExpandOptions()
	set tabstop=4
	set softtabstop=4
	set shiftwidth=4
	set noexpandtab
	set autoindent
    set fileformat=unix
endfunction

function SetTwoTabExpandOptions()
	set tabstop=2
	set softtabstop=2
	set shiftwidth=2
	set expandtab
	set autoindent
    set fileformat=unix
endfunction

" C/C++ file settings
augroup filetype_cpp
	autocmd!
    au FileType cpp call SetFourTabNoExpandOptions()
augroup end

" racket file settings
augroup filetype_racket
	au!
	au FileType racket call SetTwoTabExpandOptions()
augroup end


function SetPythonOptions()
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set expandtab
    set autoindent
    set fileformat=unix
endfunction

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
    au FileType css call SetTwoTabExpandOptions()
augroup end

" TreeSitter
let treesitter = 1
if treesitter

lua <<EOF
local languages = {"cpp", "c", "rust", "lua", "vim", "cmake", "bash", "python", "toml", "scheme"}
require'nvim-treesitter.configs'.setup {
	ensure_installed = languages,
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
:highlight NormalFloat ctermbg=black guibg=black



" EXAMPLE STUFF {{{ "
" ----------------------------------------------------------"

" Operator bindings
"onoremap b /return<cr>
"onoremap p i(
":onoremap in( :<c-u>normal! f(vi(<cr>

" Abbreviations
"iabbrev ssig -- <cr>Kasper Sauramo<cr>mail@kaspersauramo.me

" Filetype stuff
" Examples
":autocmd FileType javascript :iabbrev <buffer> iff if: 
":autocmd FileType python     :iabbrev <buffer> iff if ()<left>

"augroup filetype_cpp
	"autocmd!
	"autocmd FileType cpp thing_here
"augroup end

"augroup testgroup
	"autocmd! " clear
	"autocmd BufWrite * :echom "Baz"
"augroup end
"
" To use `ALT+{h,j,k,l}` to navigate windows from any mode: >
"tnoremap <A-h> <C-\><C-N><C-w>h
"tnoremap <A-j> <C-\><C-N><C-w>j
"tnoremap <A-k> <C-\><C-N><C-w>k
"tnoremap <A-l> <C-\><C-N><C-w>l
"inoremap <A-h> <C-\><C-N><C-w>h
"inoremap <A-j> <C-\><C-N><C-w>j
"inoremap <A-k> <C-\><C-N><C-w>k
"inoremap <A-l> <C-\><C-N><C-w>l
"nnoremap <A-h> <C-w>h
"nnoremap <A-j> <C-w>j
"nnoremap <A-k> <C-w>k
"nnoremap <A-l> <C-w>l

"}}}
