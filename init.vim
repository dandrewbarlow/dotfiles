" Vim-Plug Plugins Section 
" Use :PlugInstall to install plugins
" ---------------------------------------------------------------------------
call plug#begin()

"Nerdtree file browser
Plug 'preservim/nerdtree'

" nerdtree plugins
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
set encoding=UTF-8

" Asyncronous autocomplete
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

" https://github.com/preservim/nerdcommenter
Plug 'preservim/nerdcommenter'

"Great looking status bar for vim
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"Gotta have my dracula colorscheme
"Plug 'dracula/vim',{'name':'dracula'}
"Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'Mofiqul/dracula.nvim'
Plug 'morhetz/gruvbox'

"Show file icons in nerdtree
Plug 'ryanoasis/vim-devicons'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" telescope & dependencies
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  

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

" vim-airline settings
" smart tab line
let g:airline#extensions#tabline#enabled = 1
" theme (https://github.com/vim-airline/vim-airline/wiki/Screenshots)
let g:airline_theme='deus'


" Set Hybrid line numbers on startup
set nu rnu

" enable deoplete 
let g:deoplete#enable_at_startup = 1

" Dracula Settings
if (has("termguicolors"))
 set termguicolors
endif

syntax enable
"
" ? for some reason this plays bad on osx
colorscheme dracula
" let g:dracula_transparent_bg = 1

" for nerd comments
filetype plugin on
let g:NERDCreateDefaultMappings = 1
let g:NERDSpaceDelims = 1
vmap <C-_> <plug>NERDCommenterToggle
nmap <C-_> <plug>NERDCommenterToggle

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

" Shortcuts / Bindings
" ---------------------------------------------------------------------------

" Set NerdTree shortcut to control+n
nmap <C-n> :NERDTreeToggle<CR>

tnoremap <Esc> <C-\><C-n>

" Set ctrl-j & ctrl-k to 5 [j | k]
nmap <C-j> 5j
nmap <C-k> 5k
vmap <C-j> 5j
vmap <C-k> 5k

vmap <C-j> 5j
vmap <C-k> 5k

inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" set ctrl-h and ctrl-l to switch tabs
map <C-h> <C-w>h
map <C-l> <C-w>l

" set ctrl-s to save the document
nmap <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>a


" coc maps
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)

" honestly forget what this is for; coc stuff from here:
" http://vimcasts.org/episodes/neovim-terminal-mappings/
" inoremap <silent><expr> <TAB>
      " \ pumvisible() ? "\<C-n>" :
      " \ <SID>check_back_space() ? "\<TAB>" :
      " \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

if has('nvim')
  " ctrl-space -> autosuggest
  inoremap <silent><expr> <c-space> coc#refresh()

  " terminal escape with ctrl+escape
  tnoremap <C-Esc> <C-\><C-n>
else
  " ctrl-space -> autosuggest
  inoremap <silent><expr> <c-@> coc#refresh()
endif

