" Vim-Plug Plugins Section -----------------

call plug#begin()

Plug 'scrooloose/nerdtree'

Plug 'bling/vim-airline'

Plug 'dracula/vim',{'name':'dracula'}

Plug 'ryanoasis/vim-devicons'

call plug#end()

" Configuration ----------------------------

" Set Hybrid line numbers on startup
set nu rnu

" Dracula Settings
if (has("termguicolors"))
 set termguicolors
endif
syntax enable
colorscheme dracula

" Set NerdTree shortcut to control+n
nmap <C-n> :NERDTreeToggle<CR>
