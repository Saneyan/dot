function! TerminalMode()
  "" NERDTree should be closed
  NERDTreeClose

  "" Redefine key mappings
  nnoremap <silent> <Leader>to :tabnew <BAR> :startinsert<CR>

  "" Startup first terminal
  terminal
endfunction
