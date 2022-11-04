" autocmd FileType sas     set ff=dos sw=3 ts=3 softtabstop=3 textwidth=120 expandtab
set ff=dos sw=3 ts=3 softtabstop=3 textwidth=120 expandtab
  
syn match   sasDirective   "//\s*\$s\>.*$"
syn region  sasDirective   start="/\*\s*\$s\>" end="\*/"
