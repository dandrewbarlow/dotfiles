" Andrew Barlow
" Vim Plugins
" Vim-Plug Plugins Section 
" Use :PlugInstall to install plugins
" ---------------------------------------------------------------------------
call plug#begin()

" Conquer of Completion
" https://github.com/neoclide/coc.nvim
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

"Nerdtree file browser
Plug 'preservim/nerdtree'
	" nerdtree plugins
	Plug 'Xuyuanp/nerdtree-git-plugin'
	Plug 'ryanoasis/vim-devicons'
	set encoding=UTF-8

" terminal inside vim
Plug 'kassio/neoterm'

" Asyncronous autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Allows shortcut commenting
" https://github.com/preservim/nerdcommenter
Plug 'preservim/nerdcommenter'

"Great looking status bar for vim
Plug 'bling/vim-airline'

" Gotta have my dracula colorscheme
Plug 'dracula/vim',{'name':'dracula'}

" golang vim plugin
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

" Configuration 
" ---------------------------------------------------------------------------

" Set Hybrid line numbers on startup
set nu rnu

" enable deoplete 
let g:deoplete#enable_at_startup = 1

" for nerd comments
filetype plugin on
let g:NERDCreateDefaultMappings = 1
let g:NERDSpaceDelims = 1
vmap <C-_> <plug>NERDCommenterToggle
nmap <C-_> <plug>NERDCommenterToggle


" Dracula Settings
if (has("termguicolors"))
 set termguicolors
endif
syntax enable
colorscheme dracula

" Shortcuts / Bindings
" ---------------------------------------------------------------------------

" Set NerdTree shortcut to control+n
nmap <C-n> :NERDTreeToggle<CR>

" Set ctrl-j & ctrl-k to 5 [j | k]
map <C-j> 5j
map <C-k> 5k

" inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
" inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" set ctrl-h and ctrl-l to switch tabs
map <C-h> <C-w>h
map <C-l> <C-w>l

" set ctrl-s to save the document
nmap <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>a

" terminal mode shortcuts
" http://vimcasts.org/episodes/neovim-terminal-mappings/
if has('nvim')
	tnoremap <C-Esc> <C-\><C-n>
endif