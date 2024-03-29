
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


" Lua config bc dashboard plugin is written by someone allergic to
" documentation with a passion for refactoring

" TODO insert emoji expressing my frustration

lua <<EOF
  local home = os.getenv('HOME')
  local db = require('dashboard')
  -- macos
  -- db.preview_command = 'cat | lolcat -F 0.3'
  -- linux
  -- db.preview_command = 'ueberzug'
  --
  db.preview_file_path = home .. '/.config/nvim/static/neovim.cat'
  db.preview_file_height = 11
  db.preview_file_width = 70
  db.custom_header = {
    '',
    '',
    '⣀⣤⣤⣄⣀⣠⣤⣤⣤⣤⣤⣀⣀⣀⣀⣀⣤⣤⣤⣤⣤⣤⣄⣀⣀⣀⣠⣤⣤⣤⣤⣤⣄⣀⣀⣤⣤⣀',
    '⣸⣿⣿⣛⠙⣛⣿⣿⣿⣿⣿⣛⡛⠙⣛⣛⣿⣿⣿⣿⣿⣿⣛⠛⠋⠛⣛⣻⣿⣿⣿⣿⣛⡛⣛⣿⣿⡏',
    '⢹⣇⣹⣿⣿⣿⣍⡀⠀⢈⣩⣽⡿⠿⣿⣯⣉⡁⠀⠀⠈⣉⣹⣿⡷⣿⣿⣉⡁⠀⢀⣭⣿⠿⣿⣅⢸⣇',
    '⠈⣿⣯⡁⠀⠉⣻⣿⣿⣿⣋⠁⠀⠀⠀⠈⢙⣻⣷⣶⣿⣛⠉⠀⠀⠀⢉⣹⣿⣿⣟⡉⠀⠀⠈⣹⣿⡁',
    '⣼⡏⠙⢿⣦⡾⠋⠁⠈⠙⠻⢿⣶⣤⣴⡾⠟⠋⠁⠀⠉⠛⠿⣦⣴⡾⠟⠋⠁⠀⠉⠻⢷⣤⣾⠏⢹⣇',
    '⢹⣇⣴⠟⠙⠻⣦⣄⠀⢀⣠⣶⠟⠛⠿⣷⣦⣄⡀⢀⣠⣶⠿⠋⠉⠻⢷⣦⣀⠀⢀⣴⡿⠛⢿⣄⣸⡟',
    '⠀⣿⣏⠀⠀⠀⢈⣹⣿⣿⣋⠀⠀⠀⠀⠈⣙⣿⣿⣿⣭⡀⠀⠀⠀⠀⠀⢈⣻⣿⣿⡁⠀⠀⠀⣻⣿⡀',
    '⣼⡏⠻⣦⣀⣴⠟⠋⠀⠈⠛⢷⣦⣠⣴⠿⠋⠁⠀⠉⠛⢿⣷⣤⣀⣠⡶⠟⠉⠀⠉⠻⣶⣄⣼⠟⢹⡇',
    '⢹⣇⢀⣼⣿⣧⡀⠀⠀⢀⣠⣶⠟⠛⢷⣦⣀⠀⠀⠀⠀⢀⣬⡿⠿⣿⣦⣀⠀⠀⠀⣠⣾⠿⣧⡀⢸⡇',
    '⠸⣿⡾⠋⠀⠙⠻⣦⣴⠿⠋⠀⠀⠀⠀⠈⠙⠿⣦⣤⡾⠟⠉⠀⠀⠈⠙⢿⣷⣤⣾⠟⠁⠀⠘⢿⣼⠇',
    '⢀⣿⣷⡄⠀⣠⡾⠟⠙⢷⣦⡀⠀⠀⠀⣀⣴⡾⠛⠙⠻⣶⣄⡀⠀⠀⣠⣴⠿⠻⢿⣶⣄⠀⢀⣾⣿⡆',
    '⣼⡏⠈⣻⣿⡋⠀⠀⠀⠀⠉⠻⣷⣴⡾⠛⠁⠀⠀⠀⠀⠀⠙⣻⣶⣿⡋⠁⠀⠀⠀⠙⢿⣷⣿⠃⢸⡇',
    '⢹⣇⣼⠟⠙⠿⣦⣀⠀⣠⣴⠾⠋⠉⠛⢷⣦⣀⠀⢀⣠⣴⠿⠋⠁⠙⠻⣶⣄⡀⢀⣴⡾⠛⢿⣦⣸⡿',
    '⢠⣿⡇⠀⠀⠀⢈⣿⣿⣯⡁⠀⠀⠀⠀⠀⣈⣽⡿⣿⣏⡀⠀⠀⠀⠀⠀⠀⣹⣿⣿⣍⠀⠀⠈⣻⣿⠁',
    '⢸⡟⠻⣦⣠⣾⠟⠁⠀⠉⠻⢷⣤⣠⣴⠾⠛⠉⠀⠀⠙⠻⢷⣤⣀⣤⣶⠟⠋⠁⠀⠙⢷⣤⣼⠟⢹⣇',
    '⢿⣇⣠⡿⠻⣦⣀⠀⠀⣀⣤⡶⠟⠛⠻⢶⣤⣀⠀⠀⢀⣠⣴⡾⠛⠿⣶⣄⡀⠀⢀⣤⡾⠟⠿⣦⣼⡟',
    '⢠⣿⣿⡀⠀⢈⣹⣿⢿⣯⣁⠀⠀⠀⠀⠀⣉⣿⣿⢿⣿⣍⡁⠀⠀⠀⢀⣩⣿⣷⣿⣍⡀⠀⢀⣹⣿⡃',
    '⢸⡇⣘⣿⣿⣿⣍⡀⠀⠈⣙⣻⣶⣶⣾⣟⣋⠉⠀⠀⠈⣉⣛⣿⣶⣾⣟⣋⡁⠀⠈⣙⣿⣾⣿⡋⣸⡿',
    '⢸⣿⣿⣥⣠⣬⣽⣿⣿⣿⣿⣯⣥⣤⣭⣭⣿⣿⣷⣿⣿⣿⣭⣭⣀⣬⣭⣿⣿⣿⣿⣿⣭⣥⣭⣿⣿⣅',
    '⠈⠛⠛⠛⠉⠉⠛⠛⠛⠛⠛⠋⠉⠉⠉⠛⠛⠛⠛⠛⠛⠛⠛⠋⠉⠙⠛⠛⠛⠛⠛⠛⠛⠉⠙⠛⠛⠉',
    '',
    '',
  }
  db.custom_center = {
      {icon = '  ',
      desc = 'Recently latest session                  ',
      shortcut = 'SPC s l',
      action ='SessionLoad'},
      {icon = '  ',
      desc = 'Recently opened files                   ',
      action =  'Telescope oldfiles',
      shortcut = 'SPC f h'},
      {icon = '  ',
      desc = 'Find  File                              ',
      action = 'Telescope find_files find_command=rg,--hidden,--files',
      shortcut = 'SPC f f'},
      {icon = '  ',
      desc = 'Open Personal dotfiles                  ',
      action = 'Telescope dotfiles path=' .. home ..'/.dotfiles',
      shortcut = 'SPC f d'},
    }
EOF

