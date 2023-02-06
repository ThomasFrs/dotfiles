"-------------
"---REMAPS----
"-------------
"   explanations 
" map (remap): recursive mapping
" noremap: non-recursive mapping (does not extend to other mappings)
" n: normal mode only
" v: visual and select mode
" c: command line
" o: operator-pending
" x: visual mode only
" s: select mode only
" i: insert mode only
" l: insert, command-line, regexp-search
" <leader>: leader key
" <silent>: show no message when key used

"   file saving
let mapleader = " "
nmap <Leader>q :q<CR> " close current window
nmap <Leader>w :w<CR> " save file
nmap <Leader>WQ :wa<CR>:q<CR> " save all windows content and quit
nmap <Leader>Q :qa!<CR> " exit vim without saving anything

"   remaping arrow keys
nnoremap j h
nnoremap k j
nnoremap l k
nnoremap ; l

"   page fast moving
nnoremap <C-d> <C-d>zz " half a page down and cursor at center
nnoremap <C-u> <C-u>zz " half a page up and cursor at center

"   window managing
nmap <C-w>v :wincmd v<CR>
nmap <C-w>h :wincmd s<CR>
nmap <C-w>j :wincmd h<CR>
nmap <C-w>k :wincmd j<CR>
nmap <C-w>l :wincmd k<CR>
nmap <C-w>; :wincmd l<CR>

"   tab managing
nmap <C-t>n :tabnew<CR>
nmap <C-t>c :tabclose<CR>
nmap <C-t>j :tabprevious<CR>
nmap <C-t>; :tabnext<CR>

"   terminal
map <F6> :let $VIM_DIR=expand('%:p:h')<CR>:terminal<CR>cd $VIM_DIR<CR>



"-------------
"---MACROS----
"-------------
" reloads .vimrc whenever we write
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

" allows reading of .pdf files
au BufRead *.pdf sil exe "!xdg-open " . shellescape(expand("%:p")) | bd | let &ft=&ft | redraw!

" toggle fullscreen with F11
fun! ToggleFullscreen()
	call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")
endf
map <silent> <F11> :call ToggleFullscreen()<CR>
autocmd VimEnter * call ToggleFullscreen()



"--------------
"---SETTINGS---
"--------------
filetype on "enable filetype detection

"   tabs
set tabstop=4 " number of spaces by tab when editing
set shiftwidth=4 " number of spaces by tab when formatting
set softtabstop=4 " deletes 4 spaces as tab
set expandtab " use spaces when tabbing
filetype indent on " adaptive indentation for different languages
"set colorcolumn=80 " column to avoid extending code length

"   buffer
set hidden " auto buffer in background for faster loading and prevents data loss
set noswapfile
"set nobackup

"   indent
set autoindent

"   search
set ignorecase "ignore capital letters during search
set showmode "show the current mode on last line
set showmatch "show matching words during a search
set nohlsearch " no higlight search results 
set incsearch " highlights word when searching "
set wildmenu "auto completion menu when pressing TAB
set wildmode=full ""list:longest, full wildmenu behaving like Bash completion

"   color coding
set nocompatible
syntax enable
syntax on " enable syntax highlighting with colorscheme
"hi Normal guibg=NONE ctermbg=NONE " normal mode 
"   cursor
set cursorline
hi CursorLine cterm=NONE ctermbg=darkgray ctermfg=white guibg=darkred guifg=white
hi LineNr ctermbg=NONE " current line number

"   scrolling and position
set number relativenumber
set laststatus=2 " always show status bar
set scrolloff=8 " stop scrolling when x lines from bottom"
set ruler " display current position of cursor

" za: fold/unfold, zM: fold all, zR: unfold all
set foldmethod=indent " defines which method used to fold
set nofoldenable " dont fold on start"
"   terminal
set termwinsize=30x0 " set terminal size
"set splitbelow " always split below
set mouse=a " enable mouse dragging



"--------------
"---PLUGINS----
"--------------
"	vim plugins using vim plug (.vim/autoload/plug.vim)
" :PlugInstall
" :PlugUpdate 
" :PlugClean
filetype plugin on
call plug#begin('~/.vim/autoload/') " dir where plugins are stored
Plug 'vimwiki/vimwiki' " markdown syntax, notes, todos, file link
Plug 'vim-airline/vim-airline' " bottom info bar
Plug 'vim-airline/vim-airline-themes' " bottom info bar colors
Plug 'rafi/awesome-vim-colorschemes' " vim color schemes
Plug 'preservim/nerdtree' " file explorer tree
Plug 'junegunn/goyo.vim' " lighter vim interface for note-taking
Plug 'jiangmiao/auto-pairs' " multiple brackets, parantheses, etc.
Plug 'octol/vim-cpp-enhanced-highlight' " C++ enhanced hilighting
Plug 'derekwyatt/vim-fswitch' " switch between .c and .h
Plug 'kshenoy/vim-signature' " vim bookmarks
Plug 'yegappan/grep' " content search through different files
Plug 'mileszs/ack.vim' " search tool 
Plug 'preservim/nerdcommenter' " comments lines automatically
Plug 'fholgado/minibufexpl.vim' " multiple buffer opened
Plug 'nathanaelkane/vim-indent-guides' " vertical indentation bars
Plug 'Yggdroot/indentLine' " vertical indentation lines
Plug 'sheerun/vim-polyglot' " syntax language pack
Plug 'maxboisvert/vim-simple-complete' " keyword completion
"Plug 'tpope/vim-fugitive' " allows for git commands from vim terminal
"Plug 'matze/vim-move' " move lines visually
call plug#end()

"   vimwiki
let g:vimwiki_list = [{'path': '~/OneDrive/personnel/software/git/Vimwiki',
			\'syntax': 'markdown',
			\'ext': '.md'}]

"   vim airline & vim airline theme
let g:airline_theme='onedark'
let g:airline#extensions#whitespace#enabled=0
let g:airline_powerline_fonts=1 " enable powerline fonts
set noshowmode " dont show things like --INSERT--

"   awesome vim colorschemes
colorscheme onedark " happy_hacking

"   nerdtree
nnoremap <Leader>x :NERDTreeToggle %<CR> " toggle NerdTree
let NERDTreeShowHidden=1 " show hidden files
let NERDTreeWinSize=32 " min pannel width to 32 columns
let NERDTreeMinimalUI=1 " dont display help information
let NERDTreeAutoDeleteBuffer=1 " automatically delete file buffer

"   goyo
" :Goyo to toggle

" vim fswitch
syntax keyword cppSTLtype initializer_list
nmap <silent> <Leader>sw :FSHere<CR> " switch between .c and .h

"   vim signature
" :help g:SignatureMap
" m<letter>: put/remove a bookmark
" m-: delete all bookmarks

"   nerdcommenter
" :help nerdcommenter.txt
" cc: comment line
" cu: uncomment line

"   minibufexpl  
map <Leader>bl :MBEToggle<CR> " toggle buffer view
map <Leader>; :MBEbn<CR> " move one buffer right
map <Leader>j :MBEbp<CR> " move one buffer left
"autocmd VimEnter * MBEToggle " Toggle minibufexpl on start


"   vim-indent-guides
"let g:indent_guides_enable_on_vim_startup=1 " launch on startup
"let g:indent_guides_start_level=2 " display from 2nd level onward
"let g:indent_guides_guide_size=1 " width
"let g:indent_guides_auto_colors = 0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=lightgray
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=black

"   indentLine
let g:indentLine_char='┊'
let g:indentLine_first_char='┊'
let g:indentLine_color_term = 239
let g:indentLine_showFirstIndentLevel=1

"   vim simple complete
set complete-=t
set complete-=i " doesnt require enter to jump line
