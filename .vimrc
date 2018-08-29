set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'fatih/vim-go'
Plugin 'dgryski/vim-godef'
Plugin 'Blackrush/vim-gocode'
Plugin 'Valloric/YouCompleteMe'
call vundle#end()
filetype plugin indent on
" set cursorline

" set background=dark
set backspace=indent,eol,start
set backup
set nu
set backupdir=~/.vim/backup
" set directory=~/tmp
set encoding=utf8
" set fileencoding=prc
set fileencodings=utf8,cp936,big5
" autocmd BufNewFile * set fileencoding=cp936
set hidden
set history=4000
set hlsearch
" set imactivatekey=C-space
set nrformats=hex
set path=.,/usr/include,/usr/include/c++/3.4.4/,/usr/X11R6/include,/usr/qt/3/include,/usr/kde/3.3/include,,
set ruler
set tabstop=4
set tag+=~/.vim/systags,tags;
set shiftwidth=4
set showmatch
set smartindent
set whichwrap=b,s,h,l,<,>,[,]
set wildmenu
set wildcharm=<C-Z>
set wrap
set expandtab


set statusline=[%02n]\ %f\ %(\[%M%R%H]%)%=\ %4l,%02c%2V\ %P%*
set statusline+=\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]
set statusline+=[%{&fileformat}] " file format
set statusline+=[ASCII=\%03.3b] "ASCII码值
set laststatus=2

if has("gui_running")
	if has("win32")
		set guifont=新宋体:h12
	else
		set guifont=新宋体\ 10
	endif
	set columns=128 lines=36
endif

syntax on
filetype plugin on

let OmniCpp_MayCompleteDot = 0
let OmniCpp_MayCompleteArrow = 0

source $VIMRUNTIME/menu.vim

map <F4> :emenu <C-Z>
map! <F4> <C-O>:emenu <C-Z>

inoremap <C-F> <C-X><C-F>
inoremap <C-L> <C-X><C-L>
imap <C-W><C-W> <C-O><C-W><C-W>
nmap <C-N> :tnext<cr>
nmap <C-P> :tprev<cr>

function! SwitchExt()
	let ext = expand("%:e")
	let swi = []
	if ext =~ '\c^\(c\|cpp\)$'
		let swi = split(glob(expand("%<") . ".[hH]"), "\n")
	elseif ext =~ '\c^h$'
		let swi = split(glob(expand("%<") . ".{[cC],[cC][pP][pP]}"), "\n")
	endif
	if len(swi) == 0
		return expand("%")
	else
		return swi[0]
	endif
endfunction

nmap <F12> :execute "hide edit " . SwitchExt()<cr>
augroup filetype
    autocmd! BufRead,BufNewFile BUILD set filetype=blade
augroup end

if filereadable(expand("~/.vim/.vimrc.bundles"))
    source ~/.vim/.vimrc.bundles
endif
"NERDTree快捷键
nmap <F2> :NERDTree  <CR>
""" NERDTree.vim
let g:NERDTreeWinPos="left"
let g:NERDTreeWinSize=25
let g:NERDTreeShowLineNumbers=1
let g:neocomplcache_enable_at_startup = 1

if has("autocmd")
      au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
