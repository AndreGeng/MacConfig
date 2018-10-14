" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
" source ~/.vimrc
"

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-scripts/bufexplorer.zip'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-commentary'
Plug 'w0rp/ale'
Plug 'terryma/vim-expand-region'
Plug 'terryma/vim-multiple-cursors'
Plug 'itchyny/lightline.vim'
Plug 'flazz/vim-colorschemes'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'
Plug 'Valloric/MatchTagAlways'
Plug 'Chiel92/vim-autoformat'
Plug 'henrik/vim-indexed-search'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'editorconfig/editorconfig-vim'
Plug 'kana/vim-textobj-line'
Plug 'tpope/vim-surround'
" fix: can't use vim command under chinese input source
Plug 'lyokha/vim-xkbswitch'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-snipmate'
" ncm2 complete source -- start
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'wellle/tmux-complete.vim'
Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
  \ }
" ncm2 complete source --end
" snippet -- start
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
" snippet --end
" gist -- start
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
" gist -- end
Plug 'sjl/gundo.vim'
" syntax -- start
Plug 'pangloss/vim-javascript'
Plug 'othree/html5.vim'
Plug 'mxw/vim-jsx'
" syntax -- end
call plug#end()

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" copy to system clipboard
set clipboard+=unnamedplus

" set lazyredraw, makes nvim smooth in tmux
set lazyredraw

" show number column
set number

" color scheme
set termguicolors
colorscheme evening
au FilterWritePre * if &diff | colorscheme apprentice | endif

" indent
set autoindent
" use whitespace insteadof tab
set expandtab

" set tab width
set softtabstop=2
set shiftwidth=2
set tabstop=2

" search
set ignorecase
set smartcase

" fold method
set foldmethod=syntax
nnoremap <Space> za

" diff ignore whitespace
set diffopt+=iwhite

" check one time after 4s of inactivity in normal mode
set autoread

au FocusGained,BufEnter,CursorHold * checktime

" git shortcut
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>dt :windo diffthis<CR>
nnoremap <leader>dc :windo diffoff<CR>
nnoremap <leader>du :diffupdate<CR>
nnoremap <leader>dg :diffget<CR>
nnoremap <leader>du :diffput<CR>

" smart way to close pane
nnoremap <leader>q :q<CR>

" setup nvim with python support
let g:python_host_prog = $HOME.'/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = $HOME.'/.pyenv/versions/neovim3/bin/python'

" map extension to filetype
autocmd BufEnter *.less.module :setlocal filetype=less
autocmd BufEnter *.wxml :setlocal filetype=html
autocmd BufEnter *.wxss :setlocal filetype=css

" Move a line of text using ALT+[jk]
nmap ∆ mz:m+<cr>`z
nmap ˚ mz:m-2<cr>`z
vmap ∆ :m'>+<cr>`<my`>mzgv`yo`z
vmap ˚ :m'<-2<cr>`>my`<mzgv`yo`z

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext 

"toggle quickfixlist/locationlist -- start
  function! GetBufferList()
    redir =>buflist
    silent! ls!
    redir END
    return buflist
  endfunction

  function! ToggleList(bufname, pfx)
    let buflist = GetBufferList()
    for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
      if bufwinnr(bufnum) != -1
        exec(a:pfx.'close')
        return
      endif
    endfor
    if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
    endif
    let winnr = winnr()
    exec(a:pfx.'open')
    if winnr() != winnr
      wincmd p
    endif
  endfunction

  " nmap <silent> <leader>l :call ToggleList("Location", 'l')<CR>
  " nmap <silent> <leader>q :call ToggleList("Quickfix", 'c')<CR>
  nmap <silent> <leader>l :call ToggleList("Location", 'l')<CR>
  nmap <silent> <leader>k :call ToggleList("Quickfix", 'c')<CR>
"toggle quickfixlist/locationlist -- end


" fold style
""""""""""""""""""""""""""""""
" => JavaScript section
"""""""""""""""""""""""""""""""
au FileType javascript call JavaScriptFold()
au FileType javascript setl fen
au FileType javascript setl nocindent

au FileType javascript imap <c-t> $log();<esc>hi
au FileType javascript imap <c-a> alert();<esc>hi

au FileType javascript inoremap <buffer> $r return 
au FileType javascript inoremap <buffer> $f // --- PH<esc>FP2xi

function! JavaScriptFold() 
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction

" plugin config --- start

" nerdtree mapping
let g:NERDTreeWinPos = "right"
map <leader>nn :NERDTreeToggle<cr>
map <leader>nf :NERDTreeFind<cr>
" enable ctrl+j/k to switch panel in nerdtree
let g:NERDTreeMapJumpNextSibling = '<Nop>'
let g:NERDTreeMapJumpPrevSibling = '<Nop>'
"fzf
nmap <leader>f :Files<CR>
"Ack
nmap <leader>a :Ack -i 

" expand region shortcut 
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)
" lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             ['fugitive', 'readonly', 'relativepath', 'modified', 'filetype'] ],
      \   'right': [ [ 'lineinfo' ], ['percent'] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': ' ', 'right': ' ' },
      \ 'subseparator': { 'left': ' ', 'right': ' ' }
      \ }
" autoformat
map <leader>af :Autoformat<CR>
" gv.vim
nnoremap <leader>gv :GV!<CR>
vnoremap <leader>gv :GV!<CR>

" ALE
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'javascript.jsx': ['eslint'],
\}

"Set this setting in vimrc if you want to fix files automatically on save.
"This is off by default.
" let g:ale_fix_on_save = 1
nmap <leader>lf :ALEFix<CR>

" tmux navigator: Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANTE: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" LSP
let g:LanguageClient_serverCommands = {
    \ 'javascript': [expand('`npm get prefix`/bin/javascript-typescript-stdio')],
    \ 'javascript.jsx': [expand('`npm get prefix`/bin/javascript-typescript-stdio')],
    \ }
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" xkbswitch
let g:XkbSwitchEnabled = 1

" plugin config -- end
