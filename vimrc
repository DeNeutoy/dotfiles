" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible              " be iMproved, required
filetype off                  "

" set the runtime path to include Vundle and initialize.
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

" Good autocomplete
Plugin 'Valloric/YouCompleteMe'

" Nice filesystem browsing
Plugin 'scrooloose/nerdtree'

" Syntax checking (mostly useful for python)
Plugin 'scrooloose/syntastic'

" Git integration with vim
Plugin 'tpope/vim-fugitive'

" A nice interface for easily navigating an open window.
Plugin 'Lokaltog/vim-easymotion'

" All Plugins must be added before the following line.
call vundle#end()            " required

" Required to allow plugins.
filetype plugin indent on
syntax on

" Plugin Configuration.

" *** EasyMotion ***
" Use vim-like smart casing for easymotion searches.
let g:EasyMotion_smartcase = 1
" Don't highlight text apart from the jump characters.
let g:EasyMotion_do_shade = 0
" Use upper case target labels, but allow lower case jumps.
let g:EasyMotion_use_upper = 1
let g:EasyMotion_keys = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ;'
nmap <Leader>s <Plug>(easymotion-overwin-line)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>w <Plug>(easymotion-bd-wl)


" *** YouCompleteMe ***
" The preview window is what's on top, giving more information about the
" " possible completions.  This setting makes it go away when you leave insert
" " mode.
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_server_log_level='debug'
let g:ycm_python_binary_path='python'

" *** Syntastic ***
let g:syntastic_python_checkers=['mypy', 'pylint']
let g:syntastic_python_mypy_args='--ignore-missing-imports'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
" Use python3 to take advantage of type hints.
let g:syntastic_python_pylint_exec='~/anaconda3/bin/pylint'

" *** NerdTree ***
let NERDTreeShowBookmarks = 1
let NERDTreeMapOpenVSplit = 'v'
let NERDTreeMapOpenSplit = 's'
"if all we have left is the NERDTree, close it.
autocmd bufenter * if (winnr("$") == 1
                       \ && exists("b:NERDTreeType")
                       \ && b:NERDTreeType == "primary") | q | endif

let NERDTreeIgnore = ['\.pyc$', '\.swp$', '__pycache__[[dir]]']
let NERDTreeWinSize = 50


" Add a highlight group to look out for trailing whitespace.
" Thanks to: http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight TrailingWhitespace ctermbg=red guibg=red
autocmd colorscheme * highlight TrailingWhitespace ctermbg=red guibg=red
" 2match TrailingWhitespace /\s\+$/
" Explanation of the following: whitespace: \s , one or more: \+ ,
" current cursor position: \%# , negate: \@<! , end of line: $
autocmd InsertEnter * 2match TrailingWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * 2match TrailingWhitespace /\s\+$/
autocmd BufWinEnter * 2match TrailingWhitespace /\s\+$/

" The following apparently avoids a memory leak.
autocmd BufWinLeave * call clearmatches()

" Also highlight tab characters, which are evil.
set list
set listchars=tab:\ \ ,
highlight SpecialKey ctermbg=Red guibg=Red

" Automatically format comments when typing.  So if you type a long comment,
" vim will autowrap for you.
set formatoptions+=r
" Also continue a comment if inserting with 'O' directly under or over an
" existing comment.
set formatoptions+=o

" Allow lowercase to match uppercase search targets.
set smartcase

" Show partial commands in the command buffer as they are being typed
set showcmd

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" do not keep a backup file, use versions instead
set nobackup
" keep 50 lines of command line history
set history=50
" show the cursor position all the time
set ruler
" display incomplete commands
set showcmd
" do incremental searching
set incsearch
set hlsearch
set showmatch
" Why would you version stuff like this
set noswapfile

" Turn off infuriating beep noise on invalid command.
if has('autocmd')
        autocmd GUIEnter * set visualbell t_vb=
endif

" Root permission on a file inside vim.
cmap w!! w !sudo tee >/dev/null %

" Don't use Ex mode, use Q for formatting
map Q gq

" Get rid of annoying CTRL-U in insert mode.
imap <c-u> <nop>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else
" always set autoindenting on
  set autoindent

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis \ | wincmd p | diffthis
endif

" Leave some space at the bottom of the terminal when scrolling.
set scrolloff=4

set expandtab
set hlsearch
