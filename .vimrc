unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim
filetype plugin indent on

set nocompatible
syntax on
set autoindent
set smartindent
set noexrc
set title

set textwidth=90
set autoread
set autowrite
set autowriteall
set writebackup
set breakindent showbreak=\ +
set history=2000
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.png,.jpg

set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set shiftround
set formatoptions+=j
set pastetoggle=<F2>

set number
set relativenumber
set cursorline
set ruler
set showcmd
set splitbelow
set splitright
set sidescrolloff=5
set display+=lastline
set spelllang=de,en,ru,nb
set complete +=kspell
let base16colorspace=256  " Access colors present in 256 colorspace"
set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors"
set background=dark
highlight ColorColumn ctermbg=236
let &colorcolumn=join(range(81,999),",")
let &colorcolumn="90,".join(range(120,999),",")

set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
scriptencoding utf-8

set ttyfast
set noshowmode
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
"set viminfo='100,f1'
set nowrap
set whichwrap=
set wrapscan
set linebreak
set matchpairs+=<:>
set showmatch
set mat=2

set ignorecase
set smartcase
set incsearch
set hlsearch
set grepprg=grep\ -nH\ $*
nnoremap <silent> <Return> :<C-u>nohlsearch<CR><C-l>
set nolazyredraw
set magic
set path+=include
set path+=/usr/local/include
set wildmenu
set wildignore +=*.pyc,*/env,*/_pycache,*.class,*.o,*.lo,*.so*,*.a,*.la*

set laststatus=2

let g:vim_tags_ignore_files = ['.gitignore']

set hidden
set backup
set backupskip=/tmp/*,*.gpg,/dev/shm/*
set backupdir=$HOME/.vim/backup
set backupcopy=auto
set undofile
set undodir=$HOME/.vim/undo

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" moving up and down work as you would expect
nnoremap <silent> j gj
nnoremap <silent> k gk

" helpers for dealing with other people's code
nmap 2<leader>t :set ts=2 sts=2 sw=2 noet<cr>
nmap 2<leader>s :set ts=2 sts=2 sw=2 et<cr>
nmap 4<leader>t :set ts=4 sts=4 sw=4 noet<cr>
nmap 4<leader>s :set ts=4 sts=4 sw=4 et<cr>
nmap 8<leader>t :set ts=8 sts=8 sw=8 noet<cr>
nmap 8<leader>s :set ts=8 sts=8 sw=8 et<cr>

" need the date?
iab DATE <C-R>=strftime("%B %d, %Y (%A, %H:%Mh)")<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => automatic commands

" display indentation guides
" Smoothen the color
hi SpecialKey   guifg=darkgray      ctermfg=darkgray
"set list listchars=tab:▸·,trail:·,extends:»,precedes:«,nbsp:×,eol:¬
set list listchars=tab:\|·,trail:·,extends:»,precedes:«,nbsp:×,eol:¬
" convert spaces to tabs when reading file
autocmd! bufreadpost *.{cpp} set noexpandtab | retab!
" convert tabs to spaces before writing file
autocmd! bufwritepre *.{cpp} set expandtab | retab!
" convert spaces to tabs after writing file (to show guides again)
autocmd! bufwritepost *.{cpp} set noexpandtab | retab!

" Strip leading space
autocmd BufWritePre <buffer> %s/\s\+$//e
autocmd FileType gitcommit set spell spelllang=en
autocmd FileType text,mail setl fo=tcqwanj scrolloff=5
autocmd FileType sh,php,perl,python map <F3> :!./%<CR>
autocmd FileType make set noexpandtab
" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
autocmd FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79
autocmd Filetype python nmap <F4> :!python % <CR>
autocmd FileType perl map <F4> :!perl %<CR>
autocmd FileType rust nmap <F3> :!cargo check <CR>
autocmd FileType rust nmap <F4> :!cargo run <CR>
autocmd FileType tex map <F3> :!okular "%:r".pdf<CR>
autocmd FileType tex map <F4> :!pdflatex %<CR>
autocm  FileType java set ts=4 st=4 sw=4 keywordprg=javadoc_keyword_search
autocmd FileType html set formatoptions+=tl
autocmd FileType html,xhtml map <F4> :!xdg-open %<CR>
autocmd FileType css set smartindent
let g:html_use_css = 1

" Go to the last cursor location when a file is opened, unless this is a
" git commit (in which case it's annoying)
au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") && &filetype != "gitcommit" |
        \ execute("normal `\"") |
    \ endif

" Toggle between FOO.c and FOO.h
autocmd FileType c,cpp nnoremap <C-h> :call HeaderToggle()<CR>
function! HeaderToggle()
  let ext = expand("%:t:e")
  if ext == 'c'
    find %:t:r.h
  else
    find %:t:r.c
  endif
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
silent! call writefile([], '')
" In restricted mode, this fails with E145: Shell commands not allowed in rvim
" In non-restricted mode, this fails with E482: Can't create file <empty>
if (v:errmsg =~# '^E482:')
  " netrw - Filebrowser
  let g:netrw_banner=0
  let g:netrw_browse_split=0
  let g:netrw_altv=1
  let g:netrw_liststyle=3
  let g:netrw_list_hide=netrw_gitignore#Hide()
  let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
endif

" Ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-t>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
"let g:UltiSnipsJumpBackwardTrigger="<c-p>"

" Syntaxchecker/Linter
set statusline +=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
autocmd FileType tex let g:syntastic_check_on_open = 0
autocmd FileType tex let g:syntastic_auto_loc_list = 0
autocmd FileType tex let g:syntastic_always_populate_loc_list = 0
let g:tex_flavor = "latex"

" Rust
let g:rustfmt_autosave = 1
let g:rust_conceal = 1
let g:rust_conceal_mod_path = 0
let g:rust_conceal_pub = 1
let g:rust_recommended_style = 1
" 1 fold open default 2 fold closed default
let g:rust_fold = 1
let g:cargo_makeprg_params = 'build'
let g:syntastic_rust_checkers = ['cargo']
let g:rust_keep_autopairs_default = 0

let g:vimwiki_list = [{'path': '~/notes', 'path_html': '~/.hnotes'}]
let g:vimwiki_folding = 'list'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Keybindings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Switch between the last two files
nnoremap <Leader><Leader> <c-^>
nnoremap <leader>t :TagbarToggle<CR>
nnoremap <F1> :set spell!<CR>
nnoremap <Leader>n :drop ./notes.txt<CR>
iabbrev DATE <C-R>=strftime("%B %d, %Y (%A, %H:%Mh)")<CR>

" Compile and run keymappings -- F3 run :: F4 build
if filereadable("Makefile")
	autocmd FileType cpp,cc,c map <F4> :!make <CR>
else
	autocmd FileType c map <F4> :make %:r CFLAGS="-Wall -Wextra -pedantic -std=c11 -lmbedcrypto -lbsd"<CR>
	"	autocmd FileType cc,cpp map <F4> :make %:r CFLAGS="-Wall -Wextra -pedantic -std=c++11"<CR>
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Unicode!
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Greek {{{1
map! <C-v>GA Γ
map! <C-v>DE Δ
map! <C-v>TH Θ
map! <C-v>LA Λ
map! <C-v>XI Ξ
map! <C-v>PI Π
map! <C-v>SI Σ
map! <C-v>PH Φ
map! <C-v>PS Ψ
map! <C-v>OM Ω
map! <C-v>al α
map! <C-v>be β
map! <C-v>ga γ
map! <C-v>de δ
map! <C-v>ep ε
map! <C-v>ze ζ
map! <C-v>et η
map! <C-v>th θ
map! <C-v>io ι
map! <C-v>ka κ
map! <C-v>la λ
map! <C-v>mu μ
map! <C-v>xi ξ
map! <C-v>pi π
map! <C-v>rh ρ
map! <C-v>si σ
map! <C-v>ta τ
map! <C-v>ps ψ
map! <C-v>om ω
map! <C-v>ph ϕ
" Math {{{1
map! <C-v>ll →
map! <C-v>hh ⇌
map! <C-v>kk ↑
map! <C-v>jj ↓
map! <C-v>= ∝
map! <C-v>~ ≈
map! <C-v>!= ≠
map! <C-v>!> ⇸
map! <C-v>~> ↝
map! <C-v>>= ≥
map! <C-v><= ≤
map! <C-v>0  °
map! <C-v>ce ¢
map! <C-v>*  •
map! <C-v>co ⌘
map! <C-v>fa ∀
map! <C-v>pa ∂
map! <C-v>ex ∃
map! <C-v>ne ∄
map! <C-v>el ∈
map! <C-v>an ∧
map! <C-v>or ∨
map! <C-v>is ∩
map! <C-v>IS ⋂
map! <C-v>un ∪
map! <C-v>UN ⋃
map! <C-v>in ∫
map! <C-v>di ∖
map! <C-v>:= ≔
map! <C-v>li ℓ
map! <C-v>IN ∞
map! <C-v>cm ✔

set clipboard+=unnamedplus
