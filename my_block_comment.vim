"my_block_comment.vim
"comment a block of code using /* */

" nmap <silent> <unique> <Leader>bx <ESC>:call <SID>ComBlk()<CR>
" vmap <silent> <unique> <Leader>bx <ESC>:call <SID>ComBlk()<CR>
nmap <silent> <Leader>bc <ESC>:call <SID>ComBlk()<CR>
vmap <silent> <Leader>bc <ESC>:call <SID>ComBlk()<CR>

function! <SID>ComBlk()
  let y1 = line("'<")
  let y2 = line("'>")

  let line1 = getline(y1)
  let line2 = getline(y2)
  if line1 =~ "/*" && line2 =~ "*/"
    call cursor(y2, 0)
    exe "norm! dd\<Esc>"
    call cursor(y1, 0)
    exe "norm! dd\<Esc>"
  else
    call cursor(y2, 0)
    exe "norm! o\<Esc>|0C*/"
    call cursor(y1, 0)
    exe "norm! O\<Esc>|0C/*\<Esc>"
  endif

endfunc

