call pathogen#infect()
call pathogen#helptags()

set nocompatible                " choose no compatility with legacy vi
syntax on
filetype plugin indent on
set hidden                      " do not need to save buffer
set history=1000                " Remember more commands and search history


" ----------------------------------------------------------------------------
"  Text Formatting
" ----------------------------------------------------------------------------

set autoindent             " automatic indent new lines
set smartindent            " be smart about it
inoremap # X<BS>#
set nowrap                 " do not wrap lines
set softtabstop=2          " yep, two
set shiftwidth=2           " ..
set tabstop=4
set expandtab              " expand tabs to spaces
set nosmarttab             " fuck tabs
set formatoptions+=n       " support for numbered/bullet lists
"set textwidth=80           " wrap at 80 chars by default
set virtualedit=block      " allow virtual edit in visual block ..
set encoding=utf-8


" ----------------------------------------------------------------------------
"  Completion
" ----------------------------------------------------------------------------

" set wildmode=list:longest
" set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
" set wildignore+=*vim/backups*
" set wildignore+=*sass-cache*
" set wildignore+=*DS_Store*
" set wildignore+=vendor/rails/**
" set wildignore+=vendor/cache/**
" set wildignore+=*.gem
" set wildignore+=log/**
" set wildignore+=tmp/**
" set wildignore+=*.png,*.jpg,*.gif

"set wildignorecase              " make complete easiers


" ----------------------------------------------------------------------------
"  Whitespace
" ----------------------------------------------------------------------------

set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
"set expandtab                  " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode


" ----------------------------------------------------------------------------
"  Searching
" ----------------------------------------------------------------------------

set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " unless there is at least one capital letter

" clear the search highlights when hitting return
nnoremap <CR> :nohlsearch<cr> 


" ----------------------------------------------------------------------------
"  UI
" ----------------------------------------------------------------------------

set background=dark
set t_Co=256
set ruler                  " show the cursor position all the time
set noshowcmd              " don't display incomplete commands
set nolazyredraw           " turn off lazy redraw
set number                 " line numbers
set wildmenu               " turn on wild menu
set wildmode=list:longest,full
set ch=2                   " command line height
set backspace=2            " allow backspacing over everything in insert mode
set whichwrap+=<,>,h,l,[,] " backspace and cursor keys wrap to
set shortmess=filtIoOA     " shorten messages
set report=0               " tell us about changes
set nostartofline          " don't jump to the start of line when scrolling
set numberwidth=5          " width 5 characters on the left

set showmode               " show the current mode
set scrolloff=5            " keep 8 lines when scrolling

"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/
hi ColorColumn ctermbg=grey guibg=lightgrey

set cmdheight=2                        " Make command line two lines high
set listchars=tab:▸\ ,eol:¬     " redfine invisible characters

if has ("gui_running")
  set guioptions-=T
  set guioptions-=L
  set guioptions-=r
  set t_Co=256
  colorscheme molokai
  set cursorline                  " display the line where the curso is
  set lines=100
else
  colorscheme molokai
endif

" redifine invisble characters colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59


" ----------------------------------------------------------------------------
" Visual Cues
" ----------------------------------------------------------------------------

set showmatch              " brackets/braces that is
set mat=5                  " duration to show matching brace (1/10 sec)
set incsearch              " do incremental searching
set laststatus=2           " always show the status line
set ignorecase             " ignore case when searching
set visualbell             " shut the fuck up


" ---------------------------------------------------------------------------
"  Strip all trailing whitespace in file
" ---------------------------------------------------------------------------

function! StripWhitespace ()
    exec ':%s/ \+$//gc'
endfunction
map ,s :call StripWhitespace ()<CR>


" ----------------------------------------------------------------------------
"  Visual Indentation
" ----------------------------------------------------------------------------

vmap > >gv
vmap < <gv
vmap <Tab> >gv
vmap <S-Tab> <gv


" ----------------------------------------------------------------------------
"  Backup
" ----------------------------------------------------------------------------

" Store temporary files in a central spot
"set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
"set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp


" ----------------------------------------------------------------------------
"  Turn Off Swap Files 
" ----------------------------------------------------------------------------

set noswapfile
set nobackup
set nowb

" ----------------------------------------------------------------------------
"  Persistent Undo keeps undo history across sessions, by storing in file.
" ----------------------------------------------------------------------------

" silent !mkdir ~/.vim/backups > /dev/null 2>&1
" set undodir=~/.vim/backups
" set undofile


" ----------------------------------------------------------------------------
"  Remapping
" ----------------------------------------------------------------------------

" lead with ,
let mapleader = ","

" exit to normal mode with 'jj'
inoremap jj <ESC>


" reflow paragraph with Q in normal and visual mode
nnoremap Q gqap
vnoremap Q gq

" sane movement with wrap turned on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" switching between current buffer and previous buffer
nnoremap <leader><leader> <c-^> 

"learn hjkl move instead of arrows keys
" map <Left>  :echo "no!"<cr>
" map <Right> :echo "no!"<cr>
" map <Up>    :echo "no!"<cr>
" map <Down>  :echo "no!"<cr>

"" Navigation window shortcuts
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

"" toggle invisble characters
nmap <leader>l :set list!<CR>

"" Edit the vimrc file
nmap <silent> ,ev :tabnew $MYVIMRC<CR>


" ----------------------------------------------------------------------------
"  Folds
" ----------------------------------------------------------------------------

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" Space will toggle folds
nnoremap <space> za


" ----------------------------------------------------------------------------
"  Statusline
" ----------------------------------------------------------------------------

if has("statusline") && !&cp
  set laststatus=2  " always show the status bar

  " Start the status line

  set statusline=\ %{fugitive#statusline()}
  set statusline+=%F\ %m\ %r

  " Add fugitive

  " Finish the statusline
	set statusline+=%p%% 
  set statusline+=\ Line:\ %l/%L\ 
  set statusline+=\ Buf:\ #%n
endif


" ----------------------------------------------------------------------------
"  Autocmd
" ----------------------------------------------------------------------------

if has("autocmd")
  filetype plugin indent on

  autocmd! bufwritepost .vimrc source % " autosource the .vimrc file

  augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line("$") |
          \   exe "normal g`\"" |
          \ endif

  augroup END

	augroup myfiletypes
		"clear old autocmds in group
		autocmd!
		"for ruby, autoindent with two spaces, always expand tabs
		autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et
		autocmd FileType python set sw=4 sts=4 et
	augroup END

else
  set autoindent		" always set autoindenting on
endif


" ----------------------------------------------------------------------------
"  NERD Tree plugin
" ----------------------------------------------------------------------------

nmap <F2> :NERDTreeToggle<cr>


" ----------------------------------------------------------------------------
"  GUNDO plugin
" ----------------------------------------------------------------------------

nmap <F5> :GundoToggle<cr>
