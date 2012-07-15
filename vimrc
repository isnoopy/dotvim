call pathogen#infect()
call pathogen#helptags()

set nocompatible	              " choose no compatility with legacy vi
syntax on
set encoding=utf-8
filetype plugin indent on
set hidden                      " do not need to save buffer
set history=1000                " Remember more commands and search history

""""""""""""""""""""""""""""""
" => Display
""""""""""""""""""""""""""""""

set background=dark
set t_Co=256
set number                      " display line number
set numberwidth=5 							" width 5 characters on the left

set laststatus=2                " always display status line
set showcmd                     " show partial command
set showmode                    " show the current mode
set showmatch                   " Show matching bracets
set scrolloff=5                 " keep 8 lines when scrolling
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/
hi ColorColumn ctermbg=grey guibg=lightgrey

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

"set wildignorecase              " make complete easiers

set cmdheight=2                        " Make command line two lines high
set visualbell                  " set visual bell 
set listchars=tab:▸\ ,eol:¬     " redfine invisible characters

if has ("gui_running")
  set guioptions-=T
	set guioptions-=L
	set guioptions-=r
  set t_Co=256
  colorscheme molokai
  set cursorline                  " display the line where the curso is
  set lines=100
  "set columns=171
else
  colorscheme molokai
endif

" redifine invisble characters colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

""""""""""""""""""""""""""""""
" => Whitespace
""""""""""""""""""""""""""""""

set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
"set expandtab                  " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode

""""""""""""""""""""""""""""""
" => Searching
""""""""""""""""""""""""""""""

set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " unless there is at least one capital letter
" clear the search highlights when hitting return
nnoremap <CR> :nohlsearch<cr> 



""""""""""""""""""""""""""""""
" => Indentation
""""""""""""""""""""""""""""""

" visual identation
vmap > >gv
vmap < <gv
vmap <Tab> >gv
vmap <S-Tab> <gv

""""""""""""""""""""""""""""""
" => Backup
""""""""""""""""""""""""""""""

" Store temporary files in a central spot
"set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
"set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.

silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile

""""""""""""""""""""""""""""""
" => REMAP
""""""""""""""""""""""""""""""

"" use comma as <Leader> key instead of backslash
let mapleader=","
" switching between current buffer and previous buffer
nnoremap <leader><leader> <c-^> 

"learn hjkl move instead of arrows keys
map <Left>  :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up>    :echo "no!"<cr>
map <Down>  :echo "no!"<cr>

"" Navigation window shortcuts
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

"" toggle invisble characters
nmap <leader>l :set list!<CR>

"" Edit the vimrc file
nmap <silent> ,ev :tabnew $MYVIMRC<CR>


""""""""""""""""""""""""""""""
" => FOLDS
""""""""""""""""""""""""""""""

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" Space will toggle folds
nnoremap <space> za
"" autosource the .vimrc file

autocmd! bufwritepost .vimrc source %

""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""

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

""""""""""""""""""""""""""""""
" => Autocmd
""""""""""""""""""""""""""""""
if has("autocmd")
  filetype plugin indent on
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

""""""""""""""""""""""""""""""
" => Command-T plugin
""""""""""""""""""""""""""""""

let g:CommandTMaxHeight = 15
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>

""""""""""""""""""""""""""""""
" => NERD Tree plugin
""""""""""""""""""""""""""""""

nmap <F2> :NERDTreeToggle<cr>


""""""""""""""""""""""""""""""
" => GUNDO plugin
""""""""""""""""""""""""""""""
nmap <F5> :GundoToggle<cr>

