
"NeoBundle Scripts-----------------------------
if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=/home/tsucchi/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('/home/tsucchi/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'

" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------
"

"-------- NeoBundle で設定しろって書いてあるやつここまで --------


let g:mapleader = ','

"----------------------------------------------------------------------------
" Unite.vim
"----------------------------------------------------------------------------
let g:unite_enable_start_insert=0 "Inhibit to be the input mode when start unite
" Show a buffer list
noremap <silent><Leader>ub : <C-u>Unite buffer<CR>
" Show a file list
noremap <silent><Leader>uf : <C-u>UniteWithBufferDir -buffer-name=files file<CR>
" Show a list of used recently
noremap <silent><Leader>ur : <C-u>Unite file_mru<CR>
" Show a yanked list
noremap <silent><Leader>uy : <C-u>Unite -buffer-name=register register<CR>
" Show a list of file and buffer
noremap <silent><Leader>uu : <C-u>Unite buffer file_mru<CR>
" Show all of list
noremap <silent><Leader>ua : <C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
" Show git conflicts
noremap <silent><Leader>ug : <C-u>Unite git-conflict<CR>

"
" Perl
"
"NeoBundle 'vim-perl/vim-perl', {
"                \ 'autoload': { 'filetypes': 'perl' }
"              \ }
"NeoBundle 'hotchpotch/perldoc-vim', {
"                \ 'autoload': { 'filetypes': 'perl' }
"              \ }
"NeoBundle 'c9s/perlomni.vim', {
"                \ 'autoload': { 'filetypes': 'perl' }
"              \ }
""NeoBundle 'moznion/corelist.vim', {
""                \ 'autoload': { 'filetypes': 'perl' }
""              \ }
"NeoBundle 'moznion/perl-module-version.vim', {
"                \ 'autoload': { 'filetypes': 'perl' }
"              \ }
"NeoBundle 'moznion/vim-cpanfile', {
"                \ 'autoload': { 'filetypes': 'cpanfile' }
"              \ }
"NeoBundle 'moznion/syntastic-cpanfile', {
"                \ 'autoload': { 'filetypes': 'cpanfile' }
"              \ }
"NeoBundle 'motemen/xslate-vim', {
"                \ 'autoload': { 'filetypes': 'xslate' }
"              \ }
"NeoBundle 'moznion/plenv.vim', {
"                \ 'autoload': { 'filetypes': 'perl' }
"              \ }
"NeoBundle 'moznion/vim-plack', {
"                \ 'autoload': { 'filetypes': 'plack' }
"              \ }
"


" ------------------- 雑多な設定 --------------------
set encoding=utf-8

" 想定される改行コードの指定する
set fileformats=unix,dos,mac

" ハイライトを有効化する
syntax enable

" 挿入モードでTABを挿入するとき、代わりに適切な数の空白を使う
set expandtab
"
" 新しい行を開始したとき、新しい行のインデントを現在行と同じにする
set autoindent
"
" ファイル形式の検出の有効化する
" ファイル形式別プラグインのロードを有効化する
" ファイル形式別インデントのロードを有効化する
filetype plugin indent on


set ignorecase
set incsearch
set hlsearch
