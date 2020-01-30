"" These key mappings are for default setting.
"" They're redefinable in another config files.

" Terminal settings
tnoremap <Leader><ESC> <C-\><C-n>
tnoremap <silent> <C-n> <C-\><C-n> :tabnext <BAR> :call <SID>insertModeOnTerminal()<CR>
tnoremap <silent> <C-p> <C-\><C-n> :tabprevious <BAR> :call <SID>insertModeOnTerminal()<CR>
tnoremap <silent> <Leader>te <C-\><C-n> :tabnew +:terminal <BAR> :call <SID>insertModeOnTerminal()<CR>
tnoremap <silent> <Leader>tc <C-\><C-n> :tabclose <BAR> :call <SID>insertModeOnTerminal()<CR>
tnoremap <silent> <Leader>tv <C-\><C-n> :vsp +:terminal <BAR> :call <SID>insertModeOnTerminal()<CR>
tnoremap <silent> <Leader>th <C-\><C-n> :sp +:terminal <BAR> :call <SID>insertModeOnTerminal()<CR>

" Normal settings
nnoremap <silent> <C-n> :tabnext<CR>
nnoremap <silent> <C-p> :tabprevious<CR>
nnoremap <silent> <Leader>ee :tabnew<CR>
nnoremap <silent> <Leader>ec :tabclose<CR>
nnoremap <silent> <Leader>ev :vsp<CR>
nnoremap <silent> <Leader>eh :sp<CR>
nnoremap <silent> <Leader>eq :q<CR>

"" Save command
nnoremap <silent> <Leader>o :w<CR>

"" Toggle NERDTree
nnoremap <silent> <Leader>d :NERDTreeToggle<CR>

"" Launch NERDTree
nnoremap <silent> <Leader>n :NERDTree<CR>

"" Vim over
nnoremap <silent> <Leader>m :OverCommandLine<CR>

func! s:insertModeOnTerminal()
    startinsert!
endfunc

func! s:maybeInsertMode(direction)
    stopinsert
    execute "wincmd" a:direction
    execute "call <SID>insertModeOnTerminal()"
endfunc

" Window navigation function
" Make ctrl-h/j/k/l move between windows and auto-insert in terminals
func! s:mapMoveToWindowInDirection(direction)
    execute "tnoremap" "<silent>" "<C-" . a:direction . ">" "<C-\\><C-n>" ":call <SID>maybeInsertMode(\"" . a:direction . "\")<CR>"
    execute "nnoremap" "<silent>" "<C-" . a:direction . ">" ":wincmd " . a:direction . "<CR>"
endfunc

for dir in ["h", "j", "l", "k"]
    call s:mapMoveToWindowInDirection(dir)
endfor

