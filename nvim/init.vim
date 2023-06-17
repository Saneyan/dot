"
" init.vim - Vim configuration file
"
" @rev    G-1.0.0
" @update 2018-1-8 (inherited from G-0.6.0 updated on 2014-7-9)
" @author TADOKORO Saneyuki <saneyan@gfunction.com>
"
" Key bindings (Leader key is commma):
" [Normal mode]
"   Leader » t » n  Switch next tab
"   Leader » t » p  Switch previous tab
"   Leader » t » e  Open a new tab
"   Leader » t » c  Close a tab
"   Leader » w » v  Split window vertically
"   Leader » w » h  Split window horizontally
"   Leader » w » q  Quit current window
"   Leader » w » t  Toggle tab type
"   Leader » c      Toggle cursor highlighting
"   Leader » d      Toggle NERDTRee
"   Leader » n      Launch NERDTree
"   Leader » m      Launch OverCommandLine
"   Leader » o      Save
"
" [Insert mode]
"
" [Terminal mode]

" for neovim and legacy vim

" Local functions
source $HOME/.vim/functions.vim

" General settings
source $HOME/.vim/general.vim

" Key mapping
source $HOME/.vim/mapping.vim

" Tab type
source $HOME/.vim/tab-type.vim

" Cursor settings
source $HOME/.vim/color.vim

" Dein settings
source $HOME/.vim/dein.vim

" NERDTree settings
source $HOME/.vim/nerdtree.vim

" vim-indent-guides
source $HOME/.vim/vim-indent-guides.vim

" Terminal mode settings
source $HOME/.vim/terminal.vim

" IDE mode settings
source $HOME/.vim/ide.vim

"for neovim
if has('nvim')
  " Deoplete settings
  source $HOME/.vim/deoplete.vim

" for legacy vim
else

  " NeoComplcache settings
  source $HOME/.vim/neocomplcache.vim
endif

" Load local settings
if filereadable('local_setting.vim')
  source local_setting.vim
endif
