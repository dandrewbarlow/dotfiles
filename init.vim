" Vim-Plug Plugins Section 
" ---------------------------------------------------------------------------
call plug#begin()

"Nerdtree file browser
Plug 'scrooloose/nerdtree'

" Asyncronous autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

"Great looking status bar for vim
Plug 'bling/vim-airline'

"Gotta have my dracula colorscheme
Plug 'dracula/vim',{'name':'dracula'}

"Show file icons in nerdtree
Plug 'ryanoasis/vim-devicons'

call plug#end()

" Configuration 
" ---------------------------------------------------------------------------

" Set font
set guifont=Mononoki\ Nerd\ Font\ Mono\ Regular

" Set Hybrid line numbers on startup
set nu rnu

" enable deoplete 
 let g:deoplete#enable_at_startup = 1

" Dracula Settings
if (has("termguicolors"))
 set termguicolors
endif
syntax enable
colorscheme dracula

" Shortcuts
" ---------------------------------------------------------------------------

" Set NerdTree shortcut to control+n
nmap <C-n> :NERDTreeToggle<CR>

" Set ctrl-j to up arrow and ctrl-k to down arrow
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"



