" Andrew Barlow
"
" Neovim init file
"
" COC language server settings and startup dashboard settings moved to other
" files due to large size
"
" Vim-Plug Plugins Section 
" Use :PlugInstall to install plugins
" ---------------------------------------------------------------------------
call plug#begin()

" coc autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" nerdtree plugins
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
set encoding=UTF-8

" https://github.com/preservim/nerdcommenter
Plug 'preservim/nerdcommenter'

"Nerdtree file browser
Plug 'preservim/nerdtree'

" shows git changes in left gutter
Plug 'airblade/vim-gitgutter'

"Great looking status bar for vim
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"Gotta have my dracula colorscheme
Plug 'Mofiqul/dracula.nvim'
Plug 'morhetz/gruvbox'

"Show file icons in nerdtree
Plug 'ryanoasis/vim-devicons'

" golang vim plugin
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" telescope (a fzf plugin) & dependencies
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  

" fuzzy file finder w/ ctrl-p
Plug 'ctrlpvim/ctrlp.vim'

" startup dashboard
Plug 'glepnir/dashboard-nvim'

" cheat.sh plugin
Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-cheat.sh'

" dims inactive windows
Plug 'sunjon/shade.nvim'

" processing support
Plug 'sophacles/vim-processing'

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
" let g:deoplete#enable_at_startup = 1

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


" Lua configuration seems to be a standard rather than an option for many
" plugins these days

lua <<EOF

-- insert lua here

require'shade'.setup({
  overlay_opacity = 50,
  opacity_step = 1,
  keys = {
    brightness_up    = '<C-Up>',
    brightness_down  = '<C-Down>',
    toggle           = '<Leader>s',
  }
})

EOF



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

" inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
" inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"


" set ctrl-h and ctrl-l to switch tabs
map <C-h> <C-w>h
map <C-l> <C-w>l

" set ctrl-s to save the document
nmap <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>a

if has('nvim')
  " <c-space> -> autosuggest
  inoremap <silent><expr> <c-space> coc#refresh()

  " <c+esc> -> terminal escape 
  tnoremap <C-Esc> <C-\><C-n>
else
  " <c-space> -> autosuggest
  inoremap <silent><expr> <c-@> coc#refresh()
endif

source ~/.config/nvim/coc.vim
source ~/.config/nvim/dashboard.vim

