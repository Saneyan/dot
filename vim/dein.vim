""
" Load dein plugins
" @param array conf
"
function! AddPlugins(conf)
  call dein#begin(expand('~/.cache/dein'))
  for l:val in a:conf
    if type(l:val) == type([])
      call dein#add(l:val[0], l:val[1])
    else
      call dein#add(l:val)
    endif
  endfor
  call dein#end()
endfunction

call AddRuntimePath('~/.cache/dein/repos/github.com/Shougo/dein.vim')

call AddPlugins([
  \ 'Shougo/dein.vim',
  \ 'scrooloose/nerdtree',
  \ 'osyo-manga/vim-over',
  \ 'nathanaelkane/vim-indent-guides',
  \ 'elixir-lang/vim-elixir',
  \ 'leafgarland/typescript-vim',
  \ 'digitaltoad/vim-jade'
  \])

if has('nvim')
  call AddPlugins([
   \ 'Shougo/deoplete.nvim'
   \])
else
  call AddPlugins([
    \ 'Shougo/neocomplcache'
    \])
endif

if system('$HOME/bin/dmgr has "powerline" && echo -n "powerline"') == "powerline"
  call AddPlugins([
  \ 'alpaca-tc/alpaca_powertabline',
  \ ['Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim'}]
  \])
endif

"" Installation check
if dein#check_install()
  call dein#install()
endif

"" Let vim identify depending on a file type
filetype plugin indent on
