syntax on
"
"Below lines refer to timestamp.vim plugin
"let g:timestamp_modelines = '%'
let g:timestamp_automask = "*.sas"
let g:timestamp_regexp = '\v\C%(<Last %([cC]hanged?|[Mm]odified):\s+)@<=.*$' 
"let g:timestamp_regexp = '\v\c%(Last %(Modified):\s+)@<=\d{4}-\a{3}-\d{2}'
"let g:timestamp_rep = '%Y-%b-%d'
"let g:timestamp_regexp = '\v\C%(<Last %([cC]hanged?|[Mm]odified):\s+)@<=\a+ \d{2} \a+ \d{4} \d{2}:\d{2}:\d{2} [AP]M|TIMESTAMP'
let g:timestamp_rep = '%a %d %b %Y %I:%M:%S '
"let g:timestamp_rep = '%m-%d-%Y %X'
"
behave xterm
"set expandtab
set showcmd
set winaltkeys=no
set mousemodel=extend
set noswapfile 
set autoread
set autowrite
set iskeyword+=.
set iskeyword+=&
set fileformats=dos,unix
set backspace=indent,eol,start
set ts=3
set autoindent
set shiftwidth=3
set expandtab
set ignorecase
set number
set clipboard=autoselect
set smartcase
set hlsearch
set modeline
set modelines=29
set guifont=Lucida_Console:h8:cANSI
color elflord
"
command! QL :s/^\(\w\+\)\s\+\(.*\)$/"\1" = "\2"/
command! Auto r ~/autoexec.sas
command! Atlas r ~/atlas.sas
command! B set lines=55 | set columns=115 
command! B1 set lines=45 | set columns=105 
command! B2 set lines=55 | set columns=115 
command! C close
command! G split %:r.log
command! Ls split %:r.lst
command! Lo split %:r.log
command! URL s#\\#/#g | s/ /%20/gc
command! H1 r ~/header1.sas
command! H2 r ~/header2.sas
command! VL r ~/vega_libraries.sas
command! VO r ~/vega_options.sas
command! OP r ~/basic_options.sas
command! NL r ~/neptune_libraries.sas
command! NO r ~/neptune_options.sas
command! SK r ~/set_key.sas
command! Nova r ~/nova.sas
command! Neptune r ~/neptune.sas
command! QL split s/^\(\d\d\) = \(.*\)$/"\1" = "\2"/
command! Sa split %:r.sas
command! Signon r ~/signon.sas
command! Mod r ~/mod.sas
command! Prompt r ~/signon_prompt.sas
"command! H3 r ~/header3.sas
augroup sascode
	au GuiEnter,BufEnter *.sas,*.log,*.lst		set makeprg=sas\ -nosplash\ -sysin\ %\ -log\ %:r.log\ -print\ %:r.lst
	au GuiEnter,BufEnter *.sas,*.log,*.lst,*.cnt		setf sas
	au GuiEnter,BufEnter *.sas,*.log,*.lst,*.cnt		set ff=dos
	au GuiEnter *.sas,*.log,*.lst,*.cnt		set lines=70 | set columns=150
	au GuiEnter,BufEnter *.sas,*.log,*.lst,*.cnt		color elflord
	au GuiEnter *.sas,*.log,*.lst,*.cnt		set autoindent
augroup END
"
"
augroup scripts
	au GuiEnter *.pl,*.sh,*.js 		:set makeprg=perl\ %
	au GuiEnter *.pl,*.sh,*.js 		color elflord
	au GuiEnter *.pl,*.sh,*.js		set ts=4
	au GuiEnter *.pl,*.sh,*.js		set ff=dos
	au GuiEnter *.pl,*.sh,*.js		set shiftwidth=4
	au GuiEnter *.pl,*.sh,*.js		set lines=60 | set columns=140
augroup END
"
augroup textfiles
	au GuiEnter *.txt,*.TXT		set wrapmargin=10
	au GuiEnter *.txt,*.TXT		color ron
	"au GuiEnter,BufEnter  *.txt,*.TXT		set ff=dos
	au GuiEnter *.txt,*.TXT		set textwidth=90
	au GuiEnter *.txt,*.TXT		set lines=60 | set columns=100
	au GuiEnter *.txt,*.TXT		set autoindent
augroup END  

augroup config
	au GuiEnter .profile,*rc 		color ron
	au GuiEnter .profile,*rc		set lines=60 | set columns=140
augroup END
"
"
" see http://www.naglenet.org/vim/
" http://www.vim.org/htmldoc/pi_expl.html#g:explDateFormat
let g:MYDATE=strftime("%m-%d-%Y")
let g:MYTIME=strftime("%m-%d-%Y %X")
iab YDATE <C-R>=strftime("%Y-%b-%d %X")<CR>
map ,L mz1G/Last Modified: /e+1<CR>CYDATE<ESC>
map ,K mz1G/PROGRAM: /e<Esc>"%p<ESC>
augroup thermal
   " Remove all thermal autocommands
	"see http://www.naglenet.org/vim/
   au!
   " When writing a file:
   "   For *.tak, *.sin and *.inp files change the "Last Modified:1998-Oct-15 10:04:48 MDT
   "   current date and time in "year-month-date time" format.
   autocmd BufWritePre *.tak,*.sin,*.inp norm ,L
augroup END
"
ab (o (obs=10)<Esc>
ab (O (obs=&obs.)<Esc>
ab (r rename=( = )
ab CN %let COMPUTERNAME=%sysget(COMPUTERNAME);
ab MA %MACRO 
ab ME %MEND;
ab EN %END;
ab _te _temporary_
ab DOI %DO I=1 %TO &ni.;
ab DOJ %DO J=1 %TO &nj.;
ab DOK %DO K=1 %TO &nk.;
ab DOY %DO YEAR=&A. %TO &B.;
ab DOQ %DO q=1 %TO 4;
ab DOM %DO M=1 %TO 12;
ab doi do i=1 to ; end;
ab doj do j=1 to ; end;
ab dom do m=1 to 12;  end;
ab dtab proc SQL;<CR><tab>describe table dictionary.tables;<CR>select  memname, nobs format=comma11., nvar, memlabel from dictionary.tables<CR>where libname="" and index(memname, ) and index(memname,'05');<CR>quit; <Esc>
ab dcol proc SQL noprint;<CR><tab>describe table dictionary.columns;<CR>select name length=18, type length=6, length, npos, format length=12, label<CR>from dictionary.columns<CR>where libname="IP" and index(memname,'05');<CR>quit;<Esc>
ab Fi filename b "<esc>A";<esc>
ab FI filename b "<esc>A";<esc>
ab fmtlib proc format fmtlib library=CMS;<CR><tab>select $;run;<Esc>
ab li libname 
ab LI libname LIB "<esc>A"; %LET LIB=%SYSFUNC(PATHNAME(LIB)); %PUT LIB=&LIB.;<ESC>:s/LIB/
ab TI Title "<esc>A";<esc>
ab Ti Title "<esc>A";<esc>
ab PC proc contents data=<esc>A;<esc>
ab PP proc print data=<esc>A (obs=10);<CR>run;<Esc>
ab fi filename<Esc>
ab open %let dsid=%sysfunc(open(&DSN.)));<CR>%let LABEL=%sysfunc(attrc(&dsid,LABEL));<CR>%let NOBS=%sysfunc(attrn(&dsid,NOBS));<CR>%let rc=%sysfunc(close(&DSID.));<ESC>
ab OD ODS HTML FILE="&PATH./ .htm"  HEADTEXT="<title>&&list&j..</title>" style=normal;<Esc>
ab PDF options orientation=landscape;<CR>ODS PDF FILE="&PATH./ .pdf";<Esc>
ab ODC ODS HTML CLOSE;<Esc>
ab PTH %LET WORK=%SYSFUNC(PATHNAME(WORK)); %PUT WORK=&WORK.;<ESC>
ab LP %LET WORK=%SYSFUNC(PATHNAME(WORK)); %PUT WORK=&WORK.;<ESC>
ab pc proc contents data=&syslast.;<CR>run;<ESC>
ab pcomp proc compare base=&DSN1 compare=&DSN2. LISTBASEVAR BRIEFSUMMARY CRITERION=.1;<CR>title "Comparing Data Sets &DSN1 and &DSN2: Brief Report";<CR>run;<esc>
ab pcat proc catalog catalog=CMS.formats;<CR><tab>modify  .formatc (desc='');<CR> contents ;run;<Esc>
ab pcopy proc copy in=source out=xptout memtype=data;<CR> select;<CR> run;<Esc>
ab pdat proc datasets nolist library= ;<CR><tab>modify ;<CR>label <CR>;<CR>run;<Esc>
ab pfor proc format;<CR><tab>value ;run;<Esc>
ab pfor2 proc format library=;<CR><tab>value ;run;<Esc>
ab pfor3 proc format library= cntlin=&syslast.;<CR>run;<Esc>
ab pfor4 proc format fmtlib library=CMS;<CR><tab>select $;run;<Esc>
ab pfreq proc freq data=&syslast;<CR><tab>tables / norow nocol nopercent missing;<CR>run;<Esc>
ab pfreq2 proc freq noprint data=&syslast.;<CR><tab>tables / norow nocol nopercent missing out= ;<CR>run;<Esc>
ab phist proc univariate data=&syslast. noprint;<CR>var ;<CR>class(order=freq);<CR>histogram /nrows=4 ncols=2 intertile=1 cfill=cyan vscale=count vaxis=0 4 8 12 vaxislabel=' ' midpoints=0 to 30 by 5;<CR> inset sum='Total:' (4.1) / noframe position=ne height=2 font=swissxb; 
ab pimp proc import datafile="&path.\&dsn..xls" out=&dsn;<CR>sheet="&sheet.";<CR>getnames=yes;<CR>run;<Esc>
ab pipelib libname out1 SASESOCK ":PIPE1" TIMEOUT=5000000;<CR>
ab popt proc options option=work define value;<CR>run;<Esc>
ab popt2 proc options short;<CR>run;<Esc>
ab pp proc print noobs data=&syslast. (obs=20);<CR>run;<Esc>
ab PP proc print noobs data=<esc>A (obs=20);<CR>run;<esc>
ab ppr proc printto print="&path.\report.lst";<CR>run;<Esc>
ab pprn proc printto print="&path.\report.lst" new; run;<Esc>
ab prank proc rank groups=  data=  out= ;<CR>var ;<CR>ranks ;<CR>run;<Esc>
ab prep proc report nowd data=&syslast.;<CR><tab>columns ;<CR> define / display format= " ";<CR>define / computed format= " ";<CR> compute ;<CR><CR>endcomp;<CR>quit;<CR>run;<Esc>
ab prep2 proc report nowd data=Counts_&A._&B.;<CR>columns Year Nrol, Count;<CR>define year /group;<CR>define Nrol /across format= $Aged_or_Dis.;<CR>define Count/analysis sum format=comma7. ' ';<CR>quit;<CR>run;<Esc>
ab psum proc summary noprint nway missing data=&syslast.;<CR>var ;<CR>class / missing;<CR>output out= sum=;<CR>run;<Esc>
ab psql proc SQL;<CR><tab>select * into :<CR>from  <Esc>
ab psort proc sort data=&syslast. ;<CR><tab>by ;<CR>run;<CR><Esc>
ab psort2 proc sort nodupkey data=&syslast. out= ;<CR><tab>by ;<CR>run;<Esc>
ab ptab proc tabulate data=&syslast.;<CR><tab>var ;<CR>class ;<CR>tables * , ;<CR>run;<Esc>
ab ptran proc transpose data=&syslast.  out= ;<CR>run;<Esc>
ab ptran2 proc transpose data=&syslast.  out=&syslast._t  name=  prefix=  ;<CR>run;<Esc>
ab puni proc univariate noprint data=&syslast.;<CR>var ;<CR>output out=pctls pctlpts=20 40 pctlpre=Test1_ Test2_ pctlname=P20 P40;run;<Esc>
ab pexp proc export data= &lib..&DSN OUTFILE="&PATH./&DSN..csv"  replace;<CR>run;<Esc>
ab rsub RSUBMIT TASK1 WAIT=NO;<CR><Esc>
ab rsub1 RSUBMIT TASK1 WAIT=NO;<CR><Esc>
ab rsub2 RSUBMIT TASK1 WAIT=NO SASCMD='sas -WORK "E:\SAS Temporary Files"';<CR><Esc>

" 



" change Y to yank to end of line
map Y y$<Esc>
"
" insert LINE in Normal mode
map <S-Space> o<Esc>
"
" insert <Space> in Normal mode
map <Space> a<Space><Esc>
"
"
"F1=SAS SOURCE, REWIND
map <F1>  <Esc>:b sas<CR>
imap <F1>  <Esc>:b sas<CR>
"S-F1=source ~/.vimrc
map <S-F1> :source ~/.vimrc<Esc>
imap <S-F1> <Esc>:source ~/.vimrc<Esc>
"
"
"F2=SAVE
map <F2> :w<Esc>
imap <F2> <Esc>:w<Esc>
"S-F2=Insert Date
map <S-F2> :r!date /T<CR>\|kJ
imap <S-F2> <Esc>:r!date /T<CR>\|kJ
"
"

"F3=LOG file, REWIND, NEXT
map <F3>  <Esc>:b log<CR>:/ERR<CR>
imap <F3> <Esc>:b log<CR>:/ERR<CR>
"S-F3 double-quote a WORD
map <S-F3> Bi"<Esc>Ea"<Esc>
imap <S-F3> <Esc>Bi"<Esc>Ea"<Esc>
"
"
"
"F4=LST file, REWIND, 2 NEXT
map <F4> <Esc>:b lst<CR>
imap <F4> <Esc>:b lst<CR>
"
"S-F4=double spaces to single spaces
map <S-F4> <Esc>:s/\s\+/ /g<Esc>
imap <S-F4> <Esc>:s/\s\+/ /g<Esc>i
"
"
"
"F5 COPY TO CLIPBOARD
map <F5> "*y
imap <F5> <Esc>"*y
"S-F5 CUT TO CLIPBOARD
map <S-F5> "*d
imap <S-F5> <Esc>"*d
"
"
"F6=Insert ** at beginning of current line
map <F6> I**<Esc>
imap <F6> <Esc>I**<Esc>
"S-F6=Delete ** at beginning of current line
map <S-F6> 0xx<Esc>
imap <S-F6> <Esc>0xx<Esc>
"
"
"F7=Insert # at beginning of current line
map <F7> I#<Esc>
imap <F7> <Esc>I#<Esc>
"S-F7=Delete # at beginning of current line
map <S-F7> 0x<Esc>
imap <S-F7> <Esc>0x<Esc>
"
"
"F8=Insert /* at beginning of current line
map <F8> I/*<Esc>
imap <F8> <Esc>I/*<Esc>
map <S-F8> A*/<Esc>
imap <S-F8> <Esc>A*/<Esc>
"
"
"F9=PASTE CLIPBOARD
map <F9> "*p
imap <F9> <Esc>"*p
"F9=REPLACE WITH CLIPBOARD, 
map <S-F9> "*Pl"_dE
imap <S-F9> <Esc>"*Pl"_dE
"
"
"F10=REPLACE Word, starting from any char position in word except last char
map <F10> ebPl"_de
imap <F10> <Esc>ebPl"_de
"S-F10=REPLACE WORD, 
map <S-F10> ebPl"_dE
imap <S-F10> <Esc>ebPl"_dE
"
"
"F11=REPLACE REMAINDER of Word, starting from any char position in word
map <F11> "_deP
imap <F11> <Esc>"_deP
"map <F11> {j{^v}gq "FORMAT PARAGRAPH
"imap <F11> <Esc>{j{^v}gq{j>>
"imap <F11> <Esc>{j{^v}gq
"
"S-F11 double-quote a word
map <S-F11> bi"<Esc>ea"<Esc>
"
"F12=Yank Word
map <F12> vawy<Esc>
imap <F12> <Esc>vawy<Esc> 
"S-F12=Add to buffer A
map <S-F12> vaw"Ay<Esc> 
imap <S-F12> <Esc>vaw"Ay<Esc>
"
"
map <M-`> <Esc>:w<Esc>:make<CR>\|:b log<CR>:/ERR<CR>
imap <M-`> <Esc>:w<Esc>:make<CR>\|:b log<CR>:/ERR<CR>
nmap ` :w<Esc>:make<CR>\|<Esc>:b log<CR>:/ERR<CR>
imap ` <Esc>:w<Esc>:make<CR>\|:b log<CR>:/ERR<CR>
nmap <C-\> ye
nmap <C-`> p
" replace word with unnamed register, delete into black hole!
nmap _ Pl"_de
nmap - ct_
"Alt `,1,2,3 runs, switches between source, log, lst, args
map <M-1> <Esc>:rewind<CR>:args<CR>
map <M-2> <Esc>:rewind<CR>:next<CR>:args<CR>/ERROR<CR>
map <M-3> <Esc>:rewind<CR>:2 next<CR>:args<CR>/ERROR<CR>
map <M-q> <Esc>:wqall<CR>
map <M-w> <Esc>:wall<CR> n
map <M-z> <PageDown>
map <M-a> <PageUP>
"
"	F1		F2 	  	F3		F4	
"   SAS 	SAVE	LOG		LST		
"	.vimrc	!date	qqW		spaces
"
"	F5		F6		F7		F8
"	Copy	**		#		/*
"	Cut		xx		x		*/
"
"	F9		F10		  F11	   F12
"	Paste	Repl ww	  Repl w   Yank ww
"	Repl "*	Repl W	  qqw	   Yank to A

"TIPS
"  REMOVE ^M - :%s/^M$//g BE SURE YOU MAKE the ^M USING "CTRL-V CTRL-M" NOT BY TYPING "CARROT M"! 
"  REMOVE TABS - :retab
"  This tip is inspired by tip #72 which titled 'Remove unwanted empty lines'. 
"  :g/^$/d 
"  ================== 
"  Well, if the line contains <Space> and <Tab> 
"  :g/^\s*$/d 



