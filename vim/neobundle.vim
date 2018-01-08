""
" Load and fetch plugins for NeoBundle
" @param array conf
"
function! InitPlugins(conf)
  let l:fetch = get(a:conf, 'fetch', [])
  let l:load = get(a:conf, 'load', [])

  call neobundle#begin(expand('~/.vim/bundle/'))
  "" Fetch plugins
  if l:fetch != []
    for l:val in l:fetch
      execute 'NeoBundleFetch "' .l:val .'"'
    endfor
  endif

  "" Load plugins
  for l:val in l:load
    if type(l:val) == type([])
      execute 'NeoBundle "' .l:val[0] .'", ' string(l:val[1])
    else
      execute 'NeoBundle "' .l:val .'"'
    endif
    unlet l:val
  endfor
  call neobundle#end()
endfunction

call AddRuntimePath('~/.vim/bundle/neobundle.vim/')

call InitPlugins({
  \ 'fetch': [
  \   'Shougo/neobundle.vim'
  \ ],
  \ 'load': [
  \   'Shougo/neocomplcache',
  \   'scrooloose/nerdtree',
  \   'osyo-manga/vim-over',
  \   'nathanaelkane/vim-indent-guides',
  \   'elixir-lang/vim-elixir',
  \   'leafgarland/typescript-vim',
  \   'digitaltoad/vim-jade'
  \ ]
  \})

if system('$HOME/bin/dmgr has "powerline" && echo -n "powerline"') == "powerline"
  call InitPlugins({
  \ 'load': [
  \   'alpaca-tc/alpaca_powertabline',
  \   ['Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim'}]
  \ ]
  \})
endif
