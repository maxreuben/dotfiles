"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"               
"                ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"                ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"                ██║   ██║██║██╔████╔██║██████╔╝██║     
"                ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║     
"                 ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"                  ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
"                
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ic "ignore case when searching
set smartcase "" Override the ignorecase option if searching for capital letters. This will allow you to search specifically for capital letters.
set hls is "highlight matching and incsearch (partial matching)
if has ("autocmd")
    " File type detection. Indent based on filetype. Recommended.
    filetype plugin indent on
endif

set ai "autoindent
set si "smartindent

set number "display line numbers
"set cursorline 
set clipboard=unnamedplus "copy to system clipboard
set history=1000 "Set the commands to save in history default number is 20.

"Enable auto completion menu after pressing TAB.
"set wildmenu

" Make wildmenu behave like similar to Bash completion.
"set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
"set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx 

let g:airline_theme='wal'
let g:airline_powerline_fonts = 1 
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tabline#enabled = 1

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

let g:conoline_auto_enable = 0 
"let g:conoline_use_colorscheme_default_normal=0 "use colorscheme colors (overwrites g:conoline_color_insert_light etc.
"let g:conoline_use_colorscheme_default_insert=0
let g:conoline_color_insert_light = 'ctermbg=grey ctermfg=black'
let g:conoline_color_insert_nr_light = 'ctermbg=grey ctermfg=black'
let g:conoline_color_visual_light = 'ctermfg=166'
let g:conoline_color_visual_nr_light = 'ctermfg=166'
  
" Have nerdtree ignore certain files and directories.
let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible' "sensible defaults such as backspace delete and scroll show lines above and below
Plug 'tpope/vim-sleuth' "adjusts 'shiftwidth' and 'expandtab' heuristically based on the current file
Plug 'junegunn/fzf.vim' 
Plug 'vim-airline/vim-airline' "cool statusline in pure vim
Plug 'vim-airline/vim-airline-themes' "statusline themes
Plug 'preservim/nerdtree' "tree-style side panel file manager
Plug 'rstacruz/vim-closer' "autoclose braces
Plug 'tpope/vim-endwise' "enclose if, else etc.
Plug 'junegunn/vim-easy-align' 
Plug 'ap/vim-css-color' "A very fast, multi-syntax context-sensitive color name highlighter
Plug 'tyru/open-browser.vim' 
Plug 'mg979/vim-visual-multi', {'branch': 'master'} "multi-line cursor
Plug 'dylanaraps/wal.vim' "Sync colors with pywal use g:airline_theme or colorscheme wal
Plug 'tpope/vim-fugitive' "Vim plugin for Git
Plug 'ctrlpvim/ctrlp.vim' "Full path fuzzy file,buffer,mru,tag finder for Vim
Plug 'matze/vim-move' "Map A-Arrows to move lines/blocks left/down/up/right
Plug 'miyakogi/conoline.vim' "Change cursorline as per insert/command mode
Plug 'mbbill/undotree'
Plug 'machakann/vim-highlightedyank'
call plug#end()

" If GUI version of Vim is running set these options.
if has('gui_running')
    colorscheme onedark
    let g:airline_theme='onedark'
endif

" MAPPINGS --------------------------------------------------------------- {{{

" Set the backslash as the leader key.
let mapleader = '\'

" Press \\ to jump back to the last cursor position.
"nnoremap <leader>\ ``

" Press \p to print the current file to the default printer from a Linux operating system.
" View available printers:   lpstat -v
" Set default printer:       lpoptions -d <printer_name>
" <silent> means do not display output.
nnoremap <silent> <leader>p :%w !lp<CR>

" Type jj to exit insert mode quickly.
inoremap jj <Esc>

"" Press the space bar to type the : character in command mode.
nnoremap <space> :
  
" Pressing the letter o will open a new line below the current one.
" Exit insert mode after creating a new line above or below the current line.
"nnoremap o o<esc>
"nnoremap O O<esc>
  
" Center the cursor vertically when moving to the next word during a search.
nnoremap n nzz
nnoremap N Nzz

" Yank from cursor to the end of line.
nnoremap Y y$
nnoremap ; :
vnoremap ; :

" Map the F5 key to run a Python script inside Vim.
" I map F5 to a chain of commands here.
" :w saves the file.
" <CR> (carriage return) is like pressing the enter key.
" !clear runs the external clear screen command.
" !python3 % executes the current file with Python.
nnoremap <f5> :w <CR>:!clear <CR>:!python3 % <CR>

" Resize split windows using arrow keys by pressing:
" CTRL+SHIFT+UP, CTRL+SHIFT+DOWN, CTRL+SHIFT+LEFT, or CTRL+SHIFT+RIGHT.
noremap <ESC>[1;6A <c-w>+
noremap <ESC>[1;6B <c-w>-
noremap <ESC>[1;6D <c-w>>
noremap <ESC>[1;6C <c-w><

" NERDTree specific mappings.
" Map the F3 key to toggle NERDTree open and close.
nnoremap <F3> :NERDTreeToggle<cr>
nnoremap <F4> :UndotreeToggle<CR>
 
"Following is to fix Ctrl+Arrow, vim-visual-multi not working in Alacritty
map <ESC>[1;5A <C-Up>
map <ESC>[1;5B <C-Down>
map <ESC>[1;5C <C-Right>
map <ESC>[1;5D <C-Left>
map! <ESC>[1;5A <C-Up>
map! <ESC>[1;5B <C-Down>
map! <ESC>[1;5C <C-Right>
map! <ESC>[1;5D <C-Left>

"change vim-move shortcuts to work
let g:move_map_keys = 0

vmap <ESC>[1;3B <Plug>MoveBlockDown 
vmap <ESC>[1;3A   <Plug>MoveBlockUp
nmap <ESC>[1;3B <Plug>MoveLineDown
nmap <ESC>[1;3A   <Plug>MoveLineUp

"Quit vim quicker
inoremap <C-s> <esc>:w<cr>                 " save files
nnoremap <C-s> <esc>:w<cr>
noremap <C-x> <esc>:wq!<cr>                " save and exit
nnoremap <C-x> :wq!<cr>
inoremap <C-q> <esc>:qa!<cr>               " quit xiscarxing changes
nnoremap <C-q> :qa!<cr>
" }}}
