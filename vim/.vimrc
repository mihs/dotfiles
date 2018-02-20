set nocompatible               " be iMproved

" Airline displays the list of buffers (using bufferline)
" no need for bufferline to display the buffers itself
let g:bufferline_echo = 0

" Pathogen
execute pathogen#infect()

" disable the start screen
set shortmess+=I

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Enable syntax highlighting
syntax on

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Display line numbers on the left
set number

" Indentation settings for using 2 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4
set softtabstop=4
set expandtab

" Indent with tabs size 8 for go
autocmd Filetype go setlocal tabstop=4 noexpandtab shiftwidth=4 softtabstop=4

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Color scheme
set background=dark
colorscheme wombat256mod

" Navigate between buffers C-j/k
nnoremap <c-j> :bn<CR>
nnoremap <c-k> :bp<CR>

" Last status always visible
set laststatus=2

" Incremental search (display results while typing)
set incsearch
set hlsearch
nnoremap <silent><leader>/ :nohlsearch<CR>

" allow buffer change in the same window when the current buffer is not saved
set hidden

" timeout for ESC to prevent lags
set notimeout
set ttimeout
set timeoutlen=50

" Disable wrapping
set nowrap

" Keep x lines on the screen when scrolling
set scrolloff=3

" Backup and recovery files
set directory=~/.vimbackup//
set backupdir=~/.vimbackup

" Command mode completion list
set wildmenu
set wildmode=list:longest,full

" Strip trailing whitespace at the end of the line before saving the buffer.
function! StripTrailingWhitespace()
  " If there is trailing whitespace, the current position will be moved.
  " Saving the current position for restoring it later.
  normal mZ
  let l:chars = col("$")
  %s/\s\+$//e
  " Displaying a message in case there was whitespace in the file.
  " If the saved position (line and column) is different than the current position
  if (line("'Z") != line(".")) || (l:chars != col("$"))
    echo "Trailing whitespace stripped\n"
  endif
  normal `Z
endfunction

autocmd BufWritePre *.h,*.c,*.cpp,*.java,*.scala,*.hpp,*.s,*.i,*.coffee,*.iced,*.js,*.hbs,*.rb,*.py :call StripTrailingWhitespace()

" Toggle nerdtree
nnoremap <c-n> :NERDTreeToggle<CR>

" Visual guide for wrapping long text
if exists('+colorcolumn')
  set colorcolumn=78
  highlight ColorColumn ctermbg=8
endif

" Show some invisible characters
set list
set lcs=trail:.,tab:.,,nbsp:.

" Code completion for Java using Eclim
let g:EclimCompletionMethod = 'omnifunc'
