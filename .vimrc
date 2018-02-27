call plug#begin('~/.vim/plugged')


Plug 'tpope/vim-sensible'

Plug 'scrooloose/syntastic'
Plug 'valloric/youcompleteme'
Plug 'ervandew/supertab'
Plug 'tpope/vim-commentary'

Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'sjl/gundo.vim'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'tomasr/molokai'
Plug 'itchyny/lightline.vim'

Plug 'pangloss/vim-javascript'
Plug 'hail2u/vim-css3-syntax'
Plug 'groenewege/vim-less'
Plug 'elzr/vim-json'
Plug 'mxw/vim-jsx'
Plug 'othree/html5.vim'
Plug 'plasticboy/vim-markdown'

call plug#end()

syntax on
filetype plugin indent on
set fileformats=unix,dos,mac

set nocompatible
set noincsearch
set nohlsearch
set foldclose=
set mouse=a

set background=dark
set t_Co=256
let g:rehash256 = 1
let molokai_original = 0
colorscheme molokai

set encoding=utf-8
set guifont=mononoki\ Nerd\ Font\ 12

set noerrorbells
set novisualbell
set shortmess=atI

set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set shiftround
set autoindent
set nosmartindent

set nobackup
set noswapfile

set ruler
set cursorline
set showcmd
set showmatch
set matchtime=5
set ignorecase
set smartcase
set list
set number
set history=100
set clipboard+=unnamed
set lazyredraw

set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
" No | on window borders:
set fillchars+=vert:\ 
set matchpairs+=<:>
set complete=.,w,b,i,t,u
set backspace=indent,eol,start
set formatoptions=tcrqn
set iskeyword+=_,$,@,%,#

set guioptions-=T
set guioptions-=m
set guioptions-=r
set guioptions-=L
set guioptions-=e
set guioptions+=c

set wildmenu
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png,*/tmp/*,*.so,*.swp,*.zip
set wildmode=list:longest,full

set splitbelow
set splitright

set laststatus=2

" HTML Indentation:
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

" Tagbar:
nmap <F8> :TagbarToggle<CR>
nmap <F9> :NERDTreeFind<CR>
nmap <F10> :NERDTreeToggle<CR>
nmap <F7> :SyntasticToggleMode<CR>

" Syntastic:
let g:syntastic_javascript_checkers = [ 'eslint' ]
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'

" Tern for vim:
let g:tern_map_keys=1

" CtrlP:
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40
" set your own custom ignore settings
let g:ctrlp_custom_ignore = {
    \ 'dir': '\.git$\|\.hg$\|\.svn$\|^bower_\|dist$\|node_modules$\|3rd-party$\|project_files$\|test\|^t$',
    \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$'
    \ }


" NERDTree
let g:NERDTreeHijackNetrw = 1
au VimEnter NERD_tree_1 enew | execute 'NERDTree '.argv()[0]
autocmd BufEnter * lcd %:p:h
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'


augroup reload_vimrc
    autocmd!
    autocmd bufwritepost $MYVIMRC nested source $MYVIMRC
augroup END

" Lightline
let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive',
      \   'filename': 'LightlineFilename',
      \   'fileformat': 'LightlineFileformat',
      \   'filetype': 'LightlineFiletype',
      \   'fileencoding': 'LightlineFileencoding',
      \   'mode': 'LightlineMode',
      \   'ctrlpmark': 'CtrlPMark',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
      \ }

function! LightlineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightlineFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let branch = fugitive#head()
      return branch !=# '' ? mark.branch : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP' && has_key(g:lightline, 'ctrlp_item')
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0


colorscheme molokai
" molokai fixes:
hi VertSplit       guifg=#808080 guibg=#1B1D1E

