set nocompatible

syntax on
filetype plugin indent on
set autoindent

set textwidth=90
set autoread
set autowrite
set breakindent showbreak=\ +
set history=2000
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.png,.jpg

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab
set shiftround
set pastetoggle=<F2>

set ruler
set relativenumber
set number
set cursorline
set showcmd
set splitbelow
set splitright
set display+=lastline
set spelllang=de,en,ru,nb
let base16colorspace=256  " Access colors present in 256 colorspace"
set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors"
set background=dark
highlight ColorColumn ctermbg=236
let &colorcolumn=join(range(81,999),",")
let &colorcolumn="90,".join(range(120,999),",")

set encoding=utf-8

set ttyfast
set noshowmode
" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set ignorecase
set smartcase
set incsearch
set hlsearch
nnoremap <silent> <Return> :<C-u>nohlsearch<CR><C-l>
set nolazyredraw
set magic

set showmatch
set mat=2

set laststatus=2

let g:vim_tags_ignore_files = ['.gitignore']

set backup
set backupskip=/tmp/*,*.gpg
set backupdir=$HOME/.vim/backup
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <C-h> :call WinMove('h')<cr>
map <C-j> :call WinMove('j')<cr>
map <C-k> :call WinMove('k')<cr>
map <C-l> :call WinMove('l')<cr>

" Window movement shortcuts
" move to the window in the direction shown, or create a new window
function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction

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
autocmd FileType make set noexpandtab
" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
autocmd FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

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


" GIT commit specific
autocmd FileType gitcommit set spell spelllang=en
" Treating mail
autocmd FileType text,mail setl fo=tcqwanj

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" netrw - Filebrowser
let g:netrw_banner=0
let g:netrw_browse_split=0
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" Surround - comment out
"let g:surround_47 = "/* \r */"

"let g:delimitMate_expand_cr = 2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Keybindings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Switch between the last two files
nnoremap <Leader><Leader> <c-^>

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

"""""""""""""""""""""""""
"      Plugins          "
"""""""""""""""""""""""""

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

" Tagbar
nnoremap <leader>t :TagbarToggle<CR>

" Rust
let g:rustfmt_autosave = 1

" Ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-t>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
"let g:UltiSnipsJumpBackwardTrigger="<c-p>"
