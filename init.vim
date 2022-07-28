"" Use Vim settings, rather then Vi settings (much better!).
"" This must be first, because it changes other options as a side effect.
set nocompatible

set modeline
set ttyfast

"" Hides the buffer instead of closing. Allows switch unsaved buffers.
set hidden

"" No backup and swap files
set nobackup
set noswapfile

" set column color to 80 chars
set colorcolumn=80

" set English language
set langmenu=none

" Use english for spellchecking, but don't spellcheck by default
if version >= 700
    set spl=en spell
    set nospell
endif


" Better modes.  Remeber where we are, support yankring
set viminfo=!,'100,\"100,:20,<50,s10,h,n~/.viminfo

"" Do not return to start of line
set nostartofline

"" Disable ALT keys access to menubar. Makes mappings work.
set winaltkeys=no

set history=500		" keep 500 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set number " show line numbers

"" set search ignorecase
set ignorecase
set smartcase
set incsearch		" do incremental searching
set hlsearch

"" Remaps search
nnoremap / /\v
vnoremap / /\v

"" All matches in a line are substituted instead of one
set gdefault

"" Automatically change working dir to current buffer
set autochdir

"" Disable bell
set vb

"" Set GUI Options and scrollbars
set guioptions=egmrLtTb

"" Remove the 'tear bla bla from menus'
set guioptions-=t


"" Set narrow linespace
set linespace=0

" Tab completion
set wildmenu "Turn on WiLd menu
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,*.rbc,*.class,.svn,test/fixtures/*,vendor/gems/*

"Set magic on, for regular expressions
set magic

" Backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start
set whichwrap+=<,>,[,],h,l

"" set filetype check on
filetype plugin indent on
syntax on

"" Set colorschemes
set background=dark
colorscheme distinguished

""Minimal number of screen lines to keep above and below the cursor.
set scrolloff=3

set expandtab

""setting about indent
set autoindent
set smartindent

" No extra space when join lines
set nojoinspaces

"" Wrap text
set showbreak=...
set linebreak
set formatoptions=qrn1

" Display invisible characters.
" Use the same symbols as TextMate for tabstops and EOLs
"set listchars=eol:?,tab:>-,trail:~,extends:>,precedes:<
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set nolist

" add to autocomplete the dictionary
set complete+=k

" for XSL / CSS - completition works great
set iskeyword+=-,:

""setting about old window resizing behavior when open a new window
set winfixheight
"" not let all windows keep the same height/width
set noequalalways

"" Highlight current line and set color
set cursorline

"" Allow cursor to be positioned anywhere in block select mode
set virtualedit=block

"" Use Unix format for files
"set sessionoptions+=unix,slash,localoptions
set sessionoptions=buffers,curdir,folds,help,winpos,winsize,tabpages,unix,slash,localoptions

"" Disable code folding
set nofoldenable

" Remember cursor position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" Status line
set laststatus=3


"""""""""""""""""""""""""""""""""""""""
"""""""""""""  Functions  """""""""""""
"""""""""""""""""""""""""""""""""""""""

" Creates a session
function! MakeSession()
    let b:sessiondir = $HOME
    let b:sessionfile = b:sessiondir . '/.session.vim'
    exe "mksession! " . b:sessionfile

endfunction

" Updates a session, BUT ONLY IF IT ALREADY EXISTS
function! UpdateSession()
    if argc()==0
        let b:sessiondir = $HOME
        let b:sessionfile = b:sessiondir . "/.session.vim"
        "if !(filereadable(b:sessionfile))
        ":call MakeSession()
        "endif
        exe "mksession! " . b:sessionfile
        echo "updating session"
    endif
endfunction

" Loads a session if it exists
function! LoadSession()
    if argc() == 0
        let b:sessiondir = $HOME
        let b:sessionfile = b:sessiondir . "/.session.vim"
        if (filereadable(b:sessionfile))
            exe 'source ' b:sessionfile
        else
            echo "No session loaded."
        endif
    else
        let b:sessionfile = ""
        let b:sessiondir = ""
    endif
endfunction

au VimEnter * :call LoadSession()
au VimLeave * :call UpdateSession()

"<home> toggles between start of line and start of text
imap <khome> <home>
nmap <khome> <home>
inoremap <silent> <home> <C-O>:call Home()<CR>
nnoremap <silent> <home> :call Home()<CR>
function! Home()
    let curcol = wincol()
    normal ^
    let newcol = wincol()
    if newcol == curcol
        normal 0
    endif
endfunction


" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
set diffexpr=MyDiff()
function! MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    let eq = ''
    let cmd = 'diff'
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
                \ | wincmd p | diffthis
endif


"" Word count functions
let g:word_count="<unknown>"
fun! WordCount()
    return g:word_count
endfun
function! UpdateWordCount()
    let lnum = 1
    let g:word_count = 0
    while lnum <= line('$')
        let g:word_count = g:word_count + len(split(getline(lnum)))
        let lnum = lnum + 1
    endwhile
    return g:word_count
endfunction

augroup WordCounter
    au! BufRead,BufNewFile,BufEnter,CursorHold,CursorHoldI,InsertEnter,InsertLeave * call UpdateWordCount()
augroup END

" how eager are you? (default is 4000 ms)
set updatetime=500


"""""""""""""""""""""""""""""""""""""""
"""""""""" Plugin Parameters """"""""""
"""""""""""""""""""""""""""""""""""""""

"" NERDTree Parameters
"" Quit on opening files from the tree
let NERDTreeQuitOnOpen=0

" Highlight the selected entry in the tree
let NERDTreeHighlightCursorline=1

"" Open NERDTree in same dir
let NERDTreeChDirMode=1

"" Show hidden files by default
let NERDTreeShowHidden=1

"Command-T configuration
let g:CommandTMaxHeight=10
let g:CommandTMatchWindowAtTop=1


" Jekyll
let g:jekyll_post_suffix = "md"


"" Ack configuration
au BufNewFile,BufReadPost *.js let g:ackprg="ack --ignore-dir=node_modules -H --nocolor --nogroup --column"


""""""""""""""""""""""""""""""""""""""
"""""""""""" Key Mappings """"""""""""
""""""""""""""""""""""""""""""""""""""

"" These mappings override any mapping made by plugins and are called after
"" all plugins. Be careful.
function! AfterMappings()

    " These mappings are used when set selectmode=mouse,key,cmd (Select Mode).
    nnoremap <C-Left> b
    vnoremap <C-S-Left> b
    nnoremap <C-S-Left> gh<C-O>b
    inoremap <C-S-Left> <C-\><C-O>gh<C-O>b

    vnoremap <C-S-Right> w
    nnoremap <C-Right> w
    nnoremap <C-S-Right> gh<C-O>w
    inoremap <C-S-Right> <C-\><C-O>gh<C-O>w

    " Map NERDComment toggle to work on select-mode
    vmap <leader>c<space> :call NERDComment(1, 'toggle')<CR>

endfunction
"" Call mapping function
au VimEnter * :call AfterMappings()

"" Fast find selected text
map , y/<C-R>"/<cr>

"" Inserts hard tab in INSERT mode
inoremap <leader><Tab> <C-V><Tab>

"" Make enter useful in normal & visual mode (match tags and brackets)
nmap <C-CR> %
vmap <C-CR> %

"" Strip all trailing whitespace in the current file
nnoremap <silent> <leader>W :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
"" Do the same to all open buffers
nnoremap <silent> <leader>WW :bufdo let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>


"" Edits vimrc file
map <leader>e :e $HOME/.config/nvim/init.vim<CR>


"" Creates new empty buffer
nmap <C-N> :enew<CR>

"" Cycles between windows
nnoremap <leader><tab> <C-W>w

"" Cycles between buffers
map <silent> <C-tab> :buffer #<CR>

"" Toggles NERDTree
imap <silent> <F1> <esc>:NERDTreeFind<CR>
nmap <silent> <F1> :NERDTreeFind<CR>

"" List/Next/Previous buffers
map <silent> <F3> <esc>:bp<CR>
imap <silent> <F3> <C-O>:bp<CR>
map <silent> <F4> <esc>:bn<CR>
imap <silent> <F4> <C-O>:bn<CR>

"" Toggle between Wrap and no Wrap lines
map <F5> :set nowrap!<CR> :set wrap?<CR>
imap <F5> <C-O>:set nowrap!<CR>

"" Toggle between display line endings
map <silent> <F6> :set nolist!<CR>
imap <silent> <F6> <C-O>:set nolist!<CR>


"" Closes buffer
nmap <C-x> :Bclose<CR>

"" Remaps Shift + v to select line without newline char in visual mode
nnoremap <leader>v 0vg_

"" Closes current window
nnoremap <M-w> <C-w>c<esc>

"" Pressing < or > will let you indent/unident selected lines
vnoremap < <gv
vnoremap > >gv

" Unimpaired configuration
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

"" Split vertical window and switch to it
nnoremap <leader>s <C-w>v<C-w>l

"" Split horizontal window and switch to it
nnoremap <leader>h :split<CR>

"" Taglist Toggle
map <silent> <leader>tl :TagbarToggle<CR>


"" Search word under cursor
nnoremap , /<C-R><C-W><CR>N

"" Clear highlight
nnoremap <silent> <leader><space> :noh<CR>

"" Make cursor move as expected with wrapped lines (in insert mode only with Ctrl key)
nnoremap <silent> <Up> gk
nnoremap <silent> <Down> gj
inoremap <silent> <C-Up> <C-O>gk
inoremap <silent> <C-Down> <C-O>gj

"" Inserts file name without extension into text
inoremap \fn <C-R>=expand("%:t:r")<CR>

"" Changes line filetype endings
map <leader>fu :set ff=unix<CR>
map <leader>fd :set ff=dos<CR>
map <leader>fm :set ff=mac<CR>

"" Remaps J to gJ to join lines without spaces
map J gJ

"" Replace
nnoremap <leader>r :%s/\v/<left>

""Reload VIM
map <silent> <leader>V :source ~/.config/nvim/init.vim<CR>:filetype detect<CR>:exe ":echo 'config reloaded'"<CR>

""Use sudo to open/edit a file
cmap w!! w !sudo tee % >/dev/null

" paste from system clipboard
nnoremap <leader>p :set paste<CR>"+p<CR>:set nopaste<CR>

" yank to system clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y"



" Map \g to Gundo
nnoremap <leader>g :GundoToggle<CR>


set completeopt=menu,menuone,noselect,noinsert
set synmaxcol=250

" Terraform
let g:terraform_fmt_on_save=0

function! s:fzf_root()
    let dir = trim(system("git rev-parse --show-toplevel 2> /dev/null"))
    echom dir
    if !empty(dir)
      execute 'FZF' dir
      return
    endif
  FZF
endfunction

" FZF
nmap <C-P> :call <SID>fzf_root() <CR>
let g:fzf_layout = { 'down': '20%' }


" Disable quote concealing in JSON files
let g:vim_json_conceal=0

"Lualine
lua require('init')
"Go
lua require('lsp')
" Completion
lua require('comp')
" Completion
lua require('copilot')

" Cue TS
lua require('treesitter')


" trigger `autoread` when files changes on disk
  set autoread
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" notification after file change
  autocmd FileChangedShellPost *
    \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None


"CtrlSF

let g:ctrlsf_default_view_mode = 'compact'
let g:ctrlsf_default_root = 'project'
let g:ctrlsf_auto_focus = {
    \ "at": "start"
\ }

nmap <C-F>f <Plug>CtrlSFPrompt
nmap <C-F>p <Plug>CtrlSFCCwordPath
