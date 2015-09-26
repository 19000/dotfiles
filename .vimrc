" ------Vundle Stuff Below ----------- {{{
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

"" The following are examples of different formats supported.
"" Keep Plugin commands between vundle#begin/end.
"" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
"" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
"" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
"" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
"" The sparkup vim script is in a subdirectory of this repo called vim.
"" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

" Track the engine.
Plugin 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" ------Vundle Stuff End
" }}}

" Pathogen {{{
execute pathogen#infect()
syntax on
" }}}

" Basic Settings ----------------- {{{
set nu
set rnu
set showtabline=2
"set winheight=20
"set winminheight=5
"set winwidth=80
"set winminwidth=20
set ai
"set smartindent

"keep default tabstop=8
"set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
" ts sw sts 

" tw: prevent auto break line when a line exceed 78 characters.
set textwidth=0

set hlsearch
set incsearch

set showcmd

set wildmenu
set wildmode=longest:full,full

set tags=./tags,tags;

set cursorline
"hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
hi CursorLine  term=underline cterm=underline ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
"hi CursorLine term=underline cterm=underline guibg=Grey90
set history=1000

" statusline customize ----------------- {{{
set laststatus=2
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l/%L,%c%V%)\ %P

"set statusline+=%f\ -\ FileType:\ %y
"set statusline+=%=        " Switch to the right side
"set statusline+=\         " Add A Space
"set statusline+=%l        " Current line
"set statusline+=/         " Separator
"set statusline+=%L        " Total lines
" }}}
"
" }}}

" Foldmethod Settings --------------- {{{
set foldmethod=syntax
"nmap zr zR
"nmap zm zM

"set foldtext=MyFoldText()
"function MyFoldText() " {{{
  "let line = getline(v:foldstart)
  "let sub = substitute(line, '/\*\|\*/\|{{{\d\=', '', 'g')
"  }}}
  "return v:folddashes . sub
"endfunction
" }}}

function! NeatFoldText() "{{{
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
" }}}
set foldtext=NeatFoldText()

" Vimscript file settings ---------------------- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

set nofoldenable
" }}}

" Basic Mappings ----------------- {{{
nnoremap <Leader>n :set nu! rnu!<CR>

" Window {{{
nnoremap \q :close!<cr>
nnoremap <C-Tab> :bn<cr>
nnoremap <S-Tab> :bp<cr>
"nmap <C-j> <C-W>j
"nmap <C-k> <C-W>k
"nmap <C-h> <C-W>h
"nmap <C-l> <C-W>l
nnoremap <c-\><c-t> :tabe<cr>
nnoremap <c-\><c-\><c-t> :tabe 

nnoremap gr gT
nnoremap <C-l> gt
nnoremap <C-h> gT

" }}}

" Command {{{
nnoremap !! :!

" Search {{{
nnoremap / /\v\c
vnoremap / /\v\c
"cnoremap %s/ %smagic/
"cnoremap \>s/ \>smagic/

nnoremap \/ :vimgrep /\v\c/gj ./**/*<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><C-f>i
"count search pattern
nnoremap \\/ :%s//\0/g<cr>
" }}}

"audo fill pwd
"cnoremap %% <C-R>=expand('%:h').'/'<cr>
"cnoremap %% <C-R>=expand('%:p:h').'/'<cr>
"cnoremap \|\| <space>\| view -

nnoremap \cd :cd %:p:h<CR>:pwd<CR>
nnoremap \sh :cd %:p:h<CR>:sh<CR>
nnoremap \tm :cd %:p:h<CR>:!tmux attach \|\| tmux<CR>
nnoremap \\tm :cd %:p:h<CR>:!tmux<CR>

nnoremap \ct :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

"vmap \g :%!git show  
"nmap \g :tabe<cr>:%!git show 
cnoremap W!! w !sudo tee >/dev/null %

nnoremap \\g :Gstatus<CR>

" }}}

"use <c-o> instead of these imap
"imap <c-e> <esc>A
"imap <c-a> <esc>I
"imap <c-j> <Left>
"imap <c-k> <Right>
nnoremap \w :cw<cr>
"nnoremap \\\ :tabe ~/.vimrc<cr>
nnoremap \\\ :tabe $MYVIMRC<cr>
" this mapping make vi behave awkward when starting
"nnoremap <esc> :noh<return><esc>
nnoremap \<esc> :noh<cr>

nnoremap <F8> :NERDTreeToggle<CR>

set pastetoggle=<F7>

" System Clipboard {{{
nnoremap \y $v0"+y
nnoremap \\y ggVG"+y
nnoremap \p "+P
vnoremap \p "+p
vnoremap \y "+y
" }}}

nnoremap * *N
" vnoremap * y/\V<C-R>"<CR>N  " This fail when contain '/'
vnoremap * y/\V<C-R>=substitute(g:get_visual_selection(), '\/', '\\\/', 'g')<CR><CR>N

"nnoremap : q:i

" Test Settings ------------------------ {{{
"nmap - viw
"nmap = vaw
"nmap <C--> ddp
"nmap <C-=> kddpk
" TODO. Batch Move Lines In Selection Mode.
"nmap _
"nmap +
"inoremap <S-u> <ESC>vawUea
"inoremap <C-u> <ESC>vUa
inoremap <C-u> <ESC>vawUea
nnoremap <C-u> bvUe

"vnoremap ' <esc>`>a'<esc>`<i'<esc>
"vnoremap " <esc>`>a"<esc>`<i"<esc>
" }}}


inoremap jk <ESC>
inoremap <esc> <nop>
nnoremap s F
vnoremap s F

" Nop Keys ---------------- {{{
"nnoremap h <nop>
"nnoremap l <nop>
"nnoremap w <nop>
"nnoremap e <nop>
"nnoremap b <nop>
"inoremap <C-h> <nop>
" }}}

"" Simulate SublimeText2 Output
"
"" unnamed buffer (need :q! to close)
" nnoremap \<space> <c-w>n<c-w>L:%!python #<cr>
"
"" use tmp file to avoid :q! when close
" nnoremap \<space> :w \| :silent execute "!python % > /tmp/output.vim.out" \| :belowright 20split + /tmp/output.vim.out<cr>

" }}}

" Plugin Settings {{{
" Settings for Syntastic (python syntax checker) ------ {{{
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"" let g:syntastic_auto_loc_list = 1
"" These not needed in Passive Mode
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 1

" Syntax Checkers & Style Checkers
" let g:syntastic_quiet_messages = { "type": "style" }

let g:syntastic_java_checkers = []
let g:syntastic_javascript_checkers = ['jshint']

" Remove Python Checkers For Test.
"let g:syntastic_python_checkers = []

let g:syntastic_mode_map = {
    \ "mode": "passive",
    \ "active_filetypes": ["ruby", "php"],
    \ "passive_filetypes": ["puppet"] }
" }}}

" Solarized Vim Theme Settings --------- {{{
"syntax enable
"set background=light
"let g:solarized_termtrans=1
"let g:solarized_termcolors=256
"let g:solarized_contrast="high"
"let g:solarized_visibility="high"
"colorscheme solarized
" }}}
"
"filetype plugin indent on {{{
" filetype plugin on
" [PLUGIN] pydiction config. necessary.
" let g:pydiction_location = '/home/user/.vim/bundle/pydiction/complete-dict'
" }}}

" Jedi Config {{{
let g:jedi#popup_on_dot = 0
" }}}

" UltiSnips {{{
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsListSnippets="<c-l>" 

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" }}}

" MarkdownPreview.vim{{{
let g:mkdp_path_to_chrome = "open -a Google\\ Chrome"
" let g:mkdp_path_to_chrome = "/Applications/Google\\ Chrome.app/Contents/MacOS/Google\\ Chrome"
" }}}

" }}}

" Jump to last cursor position unless it's invalid or in an event handler {{{
augroup vimrcEx
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END
" }}}

" auto save & restore session {{{
fu! SaveSess()
  execute 'mksession! ' . $HOME . '/.session.vim'
endfunction

fu! RestoreSess()
if filereadable($HOME . '/.session.vim')
  execute 'so ' . $HOME . '/.session.vim'
  if bufexists(1)
    for l in range(1, bufnr('$'))
      if bufwinnr(l) == -1
        exec 'sbuffer ' . l
      endif
    endfor
  endif
endif
syntax on
endfunction

autocmd VimLeave * call SaveSess()
" this makes a mess when open multiple vi
"autocmd VimEnter * call RestoreSess()
" }}}

" Test Area {{{
function! g:get_visual_selection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

" Code Below Is Nonsense? {{{
let g:AutoOpenWinManager = 1
nnoremap <silent> <C-F8> :WMToggle<cr>
" }}}

"autocmd FileType python     :iabbrev <buffer> iff if:<left>

" sort S1 Poll Result. TODO: convert to function
"%normal J
"%!sort --field-separator='(' -n --key=2 -r

" }}}

" Auto Toggle Comments {{{
" Auto Toggle Comments In Python ---------------------- {{{
function! TogglePythonCommentLines(linenum)
  let currentline = getline(a:linenum)

  " line starts with '#'
  if match(currentline, '\v^[ \t]*\#') !=# -1
    let currentline = substitute(currentline, '\v^([ \t]*)\#*[ \t]*', '\1', '')
    call setline(a:linenum, currentline)
  else
    let currentline = substitute(currentline, '\v^[ \t]*', '\0# ', '')
    call setline(a:linenum, currentline)
  endif
endfunction

function! TogglePythonComment()
  call TogglePythonCommentLines('.')
endfunction

augroup python_quick_comment
  autocmd!
  autocmd FileType python nnoremap <buffer> - :call TogglePythonComment()<CR>
  autocmd FileType python vnoremap <buffer> - :call TogglePythonComment()<CR>
augroup END
" }}}

" Auto Toggle Comments In Vimscript ---------------------- {{{
function! ToggleVimCommentLines(linenum)
  let currentline = getline(a:linenum)

  " line starts with '"'
  if match(currentline, '\v^[ \t]*\"') !=# -1
    let currentline = substitute(currentline, '\v^([ \t]*)\"*[ \t]*', '\1', '')
    call setline(a:linenum, currentline)
  else
    let currentline = substitute(currentline, '\v^[ \t]*', '\0" ', '')
    call setline(a:linenum, currentline)
  endif
endfunction

function! ToggleVimComment()
  call ToggleVimCommentLines('.')
endfunction

augroup vim_quick_comment
  autocmd!
  autocmd FileType vim nnoremap <buffer> - :call ToggleVimComment()<CR>
  autocmd FileType vim vnoremap <buffer> - :call ToggleVimComment()<CR>
augroup END
" }}}

" Auto Toggle Comments In C, Java, Javascript ---------------------- {{{
function! ToggleCCommentLines(linenum)
  let currentline = getline(a:linenum)

  " line starts with '//'
  if match(currentline, '\v^[ \t]*\/\/') !=# -1
    let currentline = substitute(currentline, '\v^([ \t]*)\/\/*[ \t]*', '\1', '')
    call setline(a:linenum, currentline)
  else
    let currentline = substitute(currentline, '\v^[ \t]*', '\0// ', '')
    call setline(a:linenum, currentline)
  endif
endfunction

function! ToggleCComment()
  call ToggleCCommentLines('.')
endfunction

augroup c_quick_comment
  autocmd!
  autocmd FileType c,javascript,java nnoremap <buffer> - :call ToggleCComment()<CR>
  autocmd FileType c,javascript,java vnoremap <buffer> - :call ToggleCComment()<CR>
augroup END
" }}}

" Auto Toggle Comments In Shellscript ---------------------- {{{
function! ToggleShellCommentLines(linenum)
  let currentline = getline(a:linenum)

  " line starts with '#'
  if match(currentline, '\v^[ \t]*\#') !=# -1
    let currentline = substitute(currentline, '\v^([ \t]*)\#*[ \t]*', '\1', '')
    call setline(a:linenum, currentline)
  else
    let currentline = substitute(currentline, '\v^[ \t]*', '\0# ', '')
    call setline(a:linenum, currentline)
  endif
endfunction

function! ToggleShellComment()
  call ToggleShellCommentLines('.')
endfunction

augroup shell_quick_comment
  autocmd!
  autocmd FileType sh nnoremap <buffer> - :call ToggleShellComment()<CR>
  autocmd FileType sh vnoremap <buffer> - :call ToggleShellComment()<CR>
augroup END
" }}}
 
" }}}

" Run Current File <Space> {{{
function! PotionShowBytecode() " Example from Learn Vimscript The Hard Way {{{
    " Get the bytecode.
    let bytecode = system(g:potion_command . " -c -V " . bufname("%") . " 2>&1")

    " Open a new split and set it up.
    vsplit __Potion_Bytecode__
    normal! ggdG
    setlocal filetype=potionbytecode
    setlocal buftype=nofile

    " Insert the bytecode.
    call append(0, split(bytecode, '\v\n'))
endfunction " }}}

function! RunPythonSplitWindow()
  write
  let l:out = system("python " . bufname("%") . " 2>&1")

  let l:consoleName = '__Python_Out__'
  let l:nr = bufwinnr(l:consoleName)
  if l:nr ==# -1
    " execute 'vsplit ' . l:consoleName
    execute 'belowright split ' . l:consoleName
  else
    execute l:nr . 'wincmd w'
  endif

  normal! ggdG
  setlocal filetype=pythonoutput
  setlocal buftype=nofile
  nnoremap <buffer> q :q<CR>
  nnoremap <buffer> <space> :q<CR>

  call append(0, split(l:out, '\v\n'))
endfunction

augroup python_quick_run
  autocmd!
  " autocmd FileType python nnoremap <buffer> <space> :w\|:!python %<cr>
  autocmd FileType python nnoremap <buffer> <space> :call RunPythonSplitWindow()<CR>
augroup END

augroup c_quick_run
  autocmd!
  autocmd FileType c nnoremap <buffer> <space> :cd %:p:h<CR>:w\|:!gcc %&&./a.out<cr>
augroup END

augroup java_quick_run
  autocmd!
  " autocmd FileType java nnoremap <buffer> <space> :cd %:p:h<CR>:w \| :!javac -classpath ./:./stdlib.jar:./algs4.jar % && java -ea -classpath ./:./stdlib.jar:./algs4.jar %< 

  " This works for packaged class
  autocmd FileType java nnoremap <buffer> <space> :w \| :!javac % && java %:r<CR>
augroup END

augroup scheme_quick_run
  autocmd!
  autocmd FileType scheme nnoremap <buffer> <space> :w <bar> :!scheme < %<cr>
augroup END

augroup sql_quick_run
  autocmd!
  autocmd FileType sql nnoremap <buffer> <space> :w\|:!mysql -tTv -hlocalhost -uroot < %<cr>
augroup END

augroup javascript_quick_run
  autocmd!
  autocmd FileType javascript nnoremap <buffer> <space> :w\|:!node %<cr>
augroup END
" }}}

" Vim script manual shortcut {{{
" Disabled {{{
"augroup vim_manual_shortcut
"  autocmd!
"  autocmd FileType vim nnoremap <buffer> K viw"ay:h <C-r>a<CR>
"  autocmd FileType vim vnoremap <buffer> K "ay:h <C-r>a<CR>
"
"  autocmd FileType txt nnoremap <buffer> K viw"ay:h <C-r>a<CR>
"  autocmd FileType txt vnoremap <buffer> K "ay:h <C-r>a<CR>
"augroup END
" }}}

nnoremap K viw"ay:h <C-r>a<CR>
vnoremap K "ay:h <C-r>a<CR>
nnoremap <Leader>K viw"ay:h <C-r>a
vnoremap <Leader>K "ay:h <C-r>a
" }}}
 
" The following maps the F8 key to toggle between hex and binary (while also setting the 
" noeol and binary flags, so if you :write your file, vim doesn't perform unwanted conversions.

nnoremap <F7> :call HexMe()<CR>

let $in_hex=0
function! HexMe()
  setlocal binary
  setlocal noeol
  if $in_hex>0
    :%!xxd -r
    "echom "HEX OFF"
    let $in_hex=0
  else
    :%!xxd
    echom "HEX ON"
    let $in_hex=1
  endif
endfunction
