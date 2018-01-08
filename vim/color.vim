colorscheme desert
syntax on

hi CursorLine cterm=underline ctermbg=NONE ctermfg=NONE
hi CursorColumn cterm=NONE ctermbg=NONE ctermfg=NONE

"" Colorize special keys
highlight SpecialKey term=underline ctermfg=024 guifg=darkgray

augroup CursorLine
  "au VimEnter,WinEnter,BufWinEnter * if &l:buftype != 'terminal' | setlocal cursorline | endif
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave,BufWinLeave * setlocal nocursorline
augroup END

augroup CursorColumn
  "au VimEnter,WinEnter,BufWinEnter * if &l:buftype != 'terminal' | setlocal cursorcolumn | endif
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorcolumn
  au WinLeave,BufWinLeave * setlocal nocursorcolumn
augroup END
