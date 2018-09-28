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

" smart way to close pane
nnoremap <leader>q :q<CR>

" setup nvim with python support
let g:python_host_prog = '/Users/andregeng/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/Users/andregeng/.pyenv/versions/neovim3/bin/python'

" map extension to filetype
autocmd BufEnter *.less.module :setlocal filetype=less
autocmd BufEnter *.wxml :setlocal filetype=html
autocmd BufEnter *.wxss :setlocal filetype=css

" Move a line of text using ALT+[jk]
nmap ∆ mz:m+<cr>`z
nmap ˚ mz:m-2<cr>`z
vmap ∆ :m'>+<cr>`<my`>mzgv`yo`z
vmap ˚ :m'<-2<cr>`>my`<mzgv`yo`z

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

" plugin config -- end
