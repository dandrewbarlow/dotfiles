" Vim-Plug Plugins Section 
" Use :PlugInstall to install plugins
" ---------------------------------------------------------------------------
call plug#begin()

"Nerdtree file browser
Plug 'preservim/nerdtree'

" Asyncronous autocomplete
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

"Great looking status bar for vim
Plug 'bling/vim-airline'

"Gotta have my dracula colorscheme
"Plug 'dracula/vim',{'name':'dracula'}
"Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'Mofiqul/dracula.nvim'
Plug 'morhetz/gruvbox'

"Show file icons in nerdtree
Plug 'ryanoasis/vim-devicons'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'glepnir/dashboard-nvim'

" cheat.sh plugin
Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-cheat.sh'

" COQ code completion
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

call plug#end()

" Configuration 
" ---------------------------------------------------------------------------

" Set font
set guifont=JetBrainsMono-Regular

" Set Hybrid line numbers on startup
set nu rnu

" enable deoplete 
 let g:deoplete#enable_at_startup = 1

" Dracula Settings
if (has("termguicolors"))
 set termguicolors
endif
syntax enable
" colorscheme dracula
" let g:dracula_transparent_bg = 1


" set default fuzzy finder to telescope
let g:dashboard_default_executive="telescope"

"let g:dashboard_preview_command = 'cat'
let g:dashboard_preview_pipeline = 'lolcat'

let g:dashboard_custom_header = [
\ ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
\ ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
\ ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
\ ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
\ ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
\ ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
\]

" Shortcuts
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


" coc maps
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" ctrl-space -> autosuggest
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

