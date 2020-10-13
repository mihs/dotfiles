set nocompatible               " be iMproved

call plug#begin(stdpath('data') . '/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'ekalinin/Dockerfile.vim'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'flazz/vim-colorschemes'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'fatih/vim-go'
Plug 'michaeljsmith/vim-indent-object'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'Shougo/echodoc.vim'

" Initialize plugin system
call plug#end()

" Airline displays the list of buffers (using bufferline)
" no need for bufferline to display the buffers itself
let g:bufferline_echo = 0

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
autocmd Filetype go setlocal tabstop=8 noexpandtab shiftwidth=8 softtabstop=8

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
set directory=~/.nvimbackup//
set backupdir=~/.nvimbackup

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
  set colorcolumn=98
  highlight ColorColumn ctermbg=8
endif

" Show some invisible characters
set list
set lcs=trail:.,tab:.,,nbsp:.

let g:LanguageClient_serverCommands = {
    \ 'go': ['gopls'],
    \ 'python': ['pyls']
    \ }

" this is done by vim-go
autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()

function SetLSPShortcuts()
  nnoremap <leader>gd :call LanguageClient#textDocument_definition()<CR>
  nnoremap <leader>gr :call LanguageClient#textDocument_rename()<CR>
  nnoremap <leader>gf :call LanguageClient#textDocument_formatting()<CR>
  nnoremap <leader>gt :call LanguageClient#textDocument_typeDefinition()<CR>
  nnoremap <leader>gx :call LanguageClient#textDocument_references()<CR>
  nnoremap <leader>ga :call LanguageClient_workspace_applyEdit()<CR>
  nnoremap <leader>gc :call LanguageClient#textDocument_completion()<CR>
  nnoremap <leader>gh :call LanguageClient#textDocument_hover()<CR>
  nnoremap <leader>gs :call LanguageClient_textDocument_documentSymbol()<CR>
  nnoremap <leader>gm :call LanguageClient_contextMenu()<CR>
endfunction()

augroup LSP
  autocmd!
  autocmd FileType go call SetLSPShortcuts()
augroup END

" disable gopls in vim-go
let g:go_gopls_enabled = 0

" disable completion in vim-go
" let g:go_code_completion_enabled = 1
let g:go_code_completion_enabled = 0

let g:deoplete#enable_at_startup = 1
" let g:deoplete#delimiters = ['/','.']
" let g:deoplete#sources#go = 'vim-go'
" let g:deoplete#keyword_patterns = {}
" let g:deoplete#keyword_patterns._ = '[a-zA-Z_]\k*\(?'

" call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })

" FZF
nnoremap <silent> <C-p> :FZF<CR>

" To use echodoc, you must increase 'cmdheight' value.
set cmdheight=2
let g:echodoc_enable_at_startup = 1
" let g:echodoc#type = 'floating'
