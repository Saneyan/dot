"" Tab stops
let g:current_tab_stops = 2
let g:current_tab_type = 'soft'
execute 'set shiftwidth=' .g:current_tab_stops
execute 'set tabstop=' .g:current_tab_stops

""
" Convert to no expand tab and retab specific tabstops.
" @param number tabstops
"
function! ConvertToNoExpandTab(tabstops)
  execute 'set noexpandtab | retab! ' .a:tabstops
endfunction

""
" Convert to expand tab and retab specific tabstops.
" @param number tabstops
"
function! ConvertToExpandTab(tabstops)
  execute 'set expandtab | retab! ' .a:tabstops
endfunction

""
" Toggle tab type.
"
function! ToggleTabType()
  if g:current_tab_type == 'soft'
    let g:current_tab_type = 'hard'
  else
    let g:current_tab_type = 'soft'
  endif
  call ConvertToNoExpandTab(g:current_tab_stops)
endfunction

""
" Modify tabstops
" @param number tabstops
"
function! ModifyTabStops(tabstops)
  let g:current_tab_stops = a:tabstops
  execute 'set shiftwidth=' .g:current_tab_stops
  execute 'set tabstop=' .g:current_tab_stops
  call ConvertToNoExpandTab(g:current_tab_stops)
endfunction

"" Convert spaces to tabs when reading file
autocmd bufreadpost * call ConvertToNoExpandTab(g:current_tab_stops)

"" Convert tabs to spaces before writing file
autocmd bufwritepre * if g:current_tab_type == 'soft' | call ConvertToExpandTab(g:current_tab_stops) | endif

"" Convert spaces to tabs after writing file (to show guides again)
autocmd bufwritepost * call ConvertToNoExpandTab(g:current_tab_stops)
