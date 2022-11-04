set cindent
" Setting for verilog indent
let b:verilog_indent_modules = 2
let b:verilog_indent_width   = 2

set shiftwidth=2 softtabstop=2 tabstop=8 expandtab shiftround
"set textwidth=100 columns=100
set cursorline

" Highlight column 100
hi Bang ctermbg=grey guibg=grey
match Bang /\%>119v.*\%<121v/

" ============================================================
"  Mappings for Verilog coding
" ============================================================

" Read verilog templates
"command! HM :r ~/work/codes/v_module.v

" Insert a separating bar
map ;-  o<Esc>0Di// <Esc>69a-<Esc><CR>O<Esc>
" Insert a comment block
map ;* O<Esc>i/<Esc>69a*<ESC>o<CR><Esc>68a*<Esc>A/<Esc>kA<Space>

map ;t :set ts=8<CR>:set expandtab<CR>:retab<CR>:w<CR>:set ts=2<CR>
" Run emacs AUTOs in batch mode and save the file and retab it afterwards.
map ;a :w<CR>:!/usr/local/bin/emacs -batch % -l ~/.lisp/verilog-mode.el -f verilog-batch-auto<CR><CR>:e<CR>;t<CR>
map ;d :w<CR>:!/usr/local/bin/emacs -batch % -l ~/.lisp/verilog-mode.el -f verilog-batch-delete-auto<CR><CR>:e<CR>;t<CR>

" Insert // synopsys translate_off and //synopsys translate_on
"map \s O//<Space>synopsys translate_off<CR><CR>//<Space>synopsys translate_on<Esc>kO<Tab>

inoremap ,, <Space><=<Space>
"inoremap <A-=> <Space><=<Space>
"inoremap <A-,> <Space><= #1<Space>
"inoremap <A-0> <Space><= 1'b0;<CR>
"inoremap <A-1> <Space><= 1'b1;<CR>
"inoremap <A-p> 1'b0;
"inoremap <A-q> 1'b1;


" shortcuts for common structures
imap ;\; <Esc>0i<Space><Space>

imap ;n <CR>;\;input<Esc>15a<Space><Esc>a
imap ;N <CR>;\;input<Esc>7a<Space><Esc>a[:0]<Esc>bba
imap ;o <CR>;\;output wire<Esc>9a<Space><Esc>a
imap ;O <CR>;\;output wire [:0]<Esc>bba
imap ;or <CR>;\;output reg <Esc>9a<Space><Esc>a
imap ;oR <CR>;\;output reg  [:0]<Esc>bba
imap ;r <CR>;\;reg <Esc>10a<Space><Esc>a
imap ;R <CR>;\;reg  [:0]<Esc>bba
imap ;w <CR>;\;wire<Esc>10a<Space><Esc>a
imap ;W <CR>;\;wire [:0]<Esc>bba

"imap ;m module <CR>();<Esc>ba;nclk,;nrst_n,<CR><Space><Space><Esc>o<CR>endmodule<Esc>6kA
imap ;m module (;nclk,;nrst_n,<CR>);<CR>endmodule<CR><Esc>k^%$i
imap ;ac ;\;always @(*)<CR>begin<CR>end<Esc>>>o
imap ;ad ;\;always @(posedge clk)<CR>
imap ;as ;\;always @(posedge clk or negedge rst_n)<CR>if (~rst_n)<CR>;<CR>else<CR>;<Esc>2ki
imap ;b <CR>begin<CR>end<Esc>>>o
imap ;B <Space>begin<CR>end<Esc>O
imap ;cc case ()<CR>endcase<Esc>O
imap ;cx casex ()<CR>endcase<Esc>O
imap ;cz casez ()<CR>endcase<Esc>O
"imap ;f for ();b
imap ;f for ();B
imap ;I if () begin<CR>end else begin<CR>end<Esc>2k0f(a
imap ;i if ()<CR>;<CR>else<Esc>2k$i
imap ;g ;\;generate<CR>endgenerate<Esc><Tab>O<Tab>
imap ;s ;\;assign<Space>
imap ;t ;\;task _t_;<CR>begin<CR>end<CR>endtask<CR><ESC>4k$i
imap ;u ;\;function ;<CR>begin<CR>end<CR>endfunction<CR><ESC>4k$i
imap ;l ;\;initial begin<CR>end<Esc>O
imap ;e ;\;event<Esc>3a<Space><Esc>a_e_
imap ;p ;\;localparam<Tab>
imap ;P ;\;parameter <Tab>

map ;b obegin<CR>end<Esc>O

" ============================================
" Shortcuts for making changes
" ============================================

" remove extra spaces at the end of lines
map ;s :%s/\s\+$//<CR>

" For port mapping of a instance
map ;i :s/^\(\s*\)\(.*\),/\1.\2 (\2),<CR>
" Change port declarations to port list. '\\|' is used for '\|'
map ;p :call PortList()<CR>

function! PortList() range
  let l:range = a:firstline . ', ' . a:lastline
  let l:ln = a:firstline 

  while l:ln <= a:lastline
    call cursor(l:ln, 0)
    if getline(l:ln) =~ '\(\<input\|\<output\|\<inout\)\s*\(\[.*\]\)\?\s*\(\w*\);.*'
      s#\(\<input\|\<output\|\<inout\)\s*\(\[.*\]\)\?\s*\(\w*\);.*#\3,                             \2#
      s#\%31c\s*##
      s#\s*,#,#
    endif
    let l:str = getline(".")
    if l:str =~ '\['
      if l:str =~ '-1:'
	s#-1.*##
      else
	if l:str =~ '\d\+:'
	  s#\d\+:.*#\=submatch(0) + 1
	else
	  s#:.*#+1#
	endif
      endif
      s#\[#// #
    else
      s#\s*$##
    endif
    let l:ln += 1
  endwhile

  if a:firstline != a:lastline
    let l:ln = a:lastline
    let l:rplcdone = 0
    while l:ln >= a:firstline
      call cursor(l:ln, 0)
      if ((getline(".") =~ ',') && !l:rplcdone)
	s/,/ /
	let l:rplcdone = 1
      endif
      if getline(".") =~ '^\s*$'
	normal! dd
      endif
      let l:ln -= 1
    endwhile
  endif
endfunction

" Change output port declarations to wire/reg declarations
map ;w :s/output/wire/<CR>
map ;r :s/output/reg /<CR>

"" " Replace ! with ~ (except !=), replace && with &, replace || with |. 
"" map \! :%s/!\([^=]\)/\~\1/g<CR>
"" map \& :%s/&&/\&/g<CR>
"" map \| :%s/\|\|/\|/g<CR>
"" " map \& :execute ReplaceOperators()<CR>
"" " function ReplaceOperators()
"" "   %s/!\([^=]\)/\~\1/g
"" "   %s/&&/\&/g
"" "   %s/\|\|/\|/g
"" " endfunction

"" " to make the following changes
"" " input  [4:0]  signal_name;  // change it to the following line
"" " input  [ 4:0] signal_name;
"" " :s/\[\(\d\):\(.*\)\] /[ \1\2]/
"" map \a :%s/\[\(\d\):\(.*\)\] /[ \1:\2]/<CR>

" Change .pinname (xx) to .PINNAME (xx)
map ;uU :s/\.\w\+\s*(/\U&/g<CR>

" Find instantiation
map ;m /);<Enter>%


" ======================================================================
"  Abbriviations
" ======================================================================
abbr alwyas always
abbr alwasy always
abbr edn end
abbr ei else if
abbr zz 1'b0
abbr oo 1'b1
abbr dispaly display

" Usage <Leader>bc
source ~/.vim/my_scripts/my_block_comment.vim


" ===============================
" Temporary mappings
" ===============================

" For fixing negative IOPATH delay in SDF files
" map \fd1 :%s/IOPATH\(.*\)(-.*) /IOPATH\1(0:0:0) /<CR>
" map \fd2 :%s/IOPATH\(.*\)(-.*))/IOPATH\1(0:0:0))/<CR>
" map \r\ :s/\//\\\//g<CR>

