" Insert a perl program header
" map \p :r ~/work/codes/perl_hdr<CR><ESC>:r !echo %<CR>O<Esc>ji#<Esc>kkkddGo
map \p :r ~/work/codes/perl_hdr<CR><ESC>:r !echo %:t<CR>I#<Space><Esc><CR>
"command HH r ~/work/codes/perl_hdr | r !echo % | norm! O<Esc>ji#<Esc>kkkddGo

