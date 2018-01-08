""
" Add runtime path
" @param string path
"
function! AddRuntimePath(path)
  if has('vim_starting')
    execute 'set runtimepath+=' .a:path
  endif
endfunction

""
" Define variable and set default value if not exists
" @param string name
" @param any val
"
function! SetDefault(name, val)
  if !exists(a:name)
    execute "let " .a:name ."=" .a:val
  endif
endfunction
