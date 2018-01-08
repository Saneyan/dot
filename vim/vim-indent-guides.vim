"" Start vim-indent-guides automatically at startup
let g:indent_guides_enable_on_vim_startup=0

"" For odd number of tabs
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=#262626 ctermbg=255

"" For even number of tabs
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#3c3c3c ctermbg=255
