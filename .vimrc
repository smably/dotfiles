"==============================================================================
" PLUGINS
"==============================================================================

call plug#begin('~/.vim/plugged')

" Reset Vim to sensible defaults
Plug 'tpope/vim-sensible'

" A few nice colorschemes
Plug 'morhetz/gruvbox'
Plug 'nanotech/jellybeans.vim'
Plug 'jordwalke/flatlandia'
Plug 'ajh17/Spacegray.vim'

" Airline status line
Plug 'bling/vim-airline'
Plug 'powerline/fonts'

" Show git additions/deletions in gutter
Plug 'airblade/vim-gitgutter'

" Show marks in gutter
Plug 'kshenoy/vim-signature'

" Multiple selections
Plug 'terryma/vim-multiple-cursors'

" Automatically set indentation options
Plug 'tpope/vim-sleuth'

" Automatic commenting and uncommenting
Plug 'tpope/vim-commentary'

" Show visual indication of indent levels
" FIXME not working for some reason
" Plug 'nathanaelkane/vim-indent-guides'
" Following plugin works but is slightly less pretty
Plug 'Yggdroot/indentLine'

" Highlight whitespace at the end of lines
Plug 'ntpeters/vim-better-whitespace'

" Allow expansion/contraction of highlighted regions
Plug 'terryma/vim-expand-region'

call plug#end()


"==============================================================================
" Plugin Configuration
"==============================================================================

" tpope/vim-sensible

" morhetz/gruvbox
set background=dark
silent! colorscheme gruvbox      " Fail silently if it doesn't exist

" nanotech/jellybeans.vim

" jordwalke/flatlandia

" ajh17/Spacegray.vim

" bling/vim-airline
let g:airline_powerline_fonts = 1

" powerline/fonts
" Note: if symbols don't show up properly, open fonts from powerline/fonts in
" the finder and install manually

" airblade/vim-gitgutter

" kshenoy/vim-signature
" Following gist code makes it play nicely with gitgutter
" https://gist.github.com/kshenoy/14f2c4ce7af28b54882b
" Should probably be pulled into its own repo and managed with Plug

" terryma/vim-multiple-cursors
" Seems to be broken when hitting A in visual mode

" tpope/vim-sleuth

" tpope/vim-commentary

" Yggdroot/indentLine

" ntpeters/vim-better-whitespace

" terryma/vim-expand-region
" use v to expand selection, ctrl+v to shrink
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

"==============================================================================
" General Configuration
"==============================================================================

set noswapfile
set nowritebackup
set nobackup

set number
set mouse=a
set ignorecase
set smartcase
set nowrap

set cursorline

" allow cursor to go one character past end of line in normal mode or anywhere
" in visual block mode
set virtualedit=block,onemore

" always show at least two lines at the bottom when scrolling
set scrolloff=2

" open new splits on the bottom and the right as God intended
set splitbelow
set splitright

" equalize split sizes when resizing
autocmd VimResized * wincmd =

" use undo dir (note: should not be under version control as it is local to
" each machine depending on files edited)
let s:undoDir = $HOME . '/.vimUndo'
if !isdirectory(s:undoDir)
  call mkdir(s:undoDir)
endif
set undofile
execute "set undodir=".s:undoDir

" disable automatic comments on newline
autocmd FileType * setlocal formatoptions-=r formatoptions-=o

" Uncomment to disable automatic wrapping of comments at 80 columns
" autocmd FileType * setlocal formatoptions-=c


"==============================================================================
" Key mappings
"==============================================================================

" do nothing when I hit Q by accident
nmap Q <nop>

" make :Q quit
cabbrev Q q

" make :W write
cabbrev W w

" make Y yank to end of line
nnoremap Y y$

" fast scrolling using control when in command mode (keeping the j/k paradigm)
map <C-j> <C-d>
map <C-k> <C-u>

" clear search highlighting when escape is pressed (wreaks havoc on terminals,
" unfortunately; GUI-only for now)
if has("gui_running")
  nnoremap <silent> <esc> :noh<return><esc>
endif

" use tab to navigate between splits
set winwidth=1
nmap <Tab> <c-w><c-w>
nmap <s-Tab> <c-w><s-w>

" use space to navigate between tabs
map <Space> gt
map <s-Space> gT

" maintain visual selection when changing indent
vmap > >gv
vmap < <gv

" maintain cursor position when yanking/putting in visual mode
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" use K to join current line with line above
nnoremap K kJ

" maintain cursor position when concatenating lines vertically
nnoremap J m`J``

" use arrow keys to scroll by on-screen lines
imap <up> <C-O>gk
imap <down> <C-O>gj
nmap <up> gk
nmap <down> gj
vmap <up> gk
vmap <down> gj

" don't move cursor one character back when exiting insert mode
inoremap <esc> <esc>l

" move cursor as far right as possible with $ (see virtualedit=onemore)
nnoremap $ $l

" insert blank line above/below with go/gO
nnoremap <silent>go :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent>gO :set paste<CR>m`O<Esc>``:set nopaste<CR>

"==============================================================================
" GUI Configuration
"==============================================================================
" FIXME should move to .gvimrc to load at correct time

if has("gui_running") " all this for gui use
  set guioptions-=r "remove scrollbars
  set guioptions-=R "remove scrollbars
  set guioptions-=l "remove scrollbars
  set guioptions-=L "remove scrollbars
  set guioptions-=T " Remove toolbars

  if has("gui_macvim") || has("gui_vimr")
    set nolazyredraw
    set lines=60
    set columns=120
    set guifont=Monaco:h12
    set guifont=Monaco\ for\ Powerline:h12
  endif
endif
