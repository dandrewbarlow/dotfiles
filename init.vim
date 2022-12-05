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


call plug#end()

" Configuration 
" ---------------------------------------------------------------------------

" COC language servers
let g:coc_global_extensions = [ 
	\'coc-clangd', 
	\'coc-css', 
	\'coc-go', 
	\'coc-html',
	\'coc-json', 
	\'coc-markdownlint', 
	\'coc-marketplace', 
	\'coc-pyright', 
	\'coc-r-lsp', 
	\'coc-rust-analyzer', 
	\'coc-sh', 
	\'coc-snippets', 
	\'coc-tailwindcss', 
	\'coc-tsserver', 
	\'coc-vimlsp' 
\]

" makes COC run cleaner
set updatetime=300

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

" Dashboard settings --------------------

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

" inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
" inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"


" set ctrl-h and ctrl-l to switch tabs
map <C-h> <C-w>h
map <C-l> <C-w>l

" set ctrl-s to save the document
nmap <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>a


" COC helper functions --------------------------------------------------

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" COC Mappings/etc --------------------

" many defaults taken from https://github.com/neoclide/coc.nvim

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"


" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

if has('nvim')
  " <c-space> -> autosuggest
  inoremap <silent><expr> <c-space> coc#refresh()

  " <c+esc> -> terminal escape 
  tnoremap <C-Esc> <C-\><C-n>
else
  " <c-space> -> autosuggest
  inoremap <silent><expr> <c-@> coc#refresh()
endif

