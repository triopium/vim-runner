function! runasr#ExeLine()
	let l:cline=getline('.')
	let l:cline=substitute(l:cline,'^"\{1,2}\|\s*','',0)
	let l:cmd='Rscript -e ' . shellescape(l:cline)
	let l:out=system(l:cmd)
	echo l:out
	return l:out
endfunction
""seq(1,100)

""nnoremap <buffer> <CR> :call runasr#ExeLine()

function! runasr#ExeBlock(sfile,outfile) range
	let l:lines=getline(a:firstline,a:lastline)
	let l:lines=array#ListSubstitute(l:lines,'^"\{,2}\|\s*','',0)
	exe '0sp ' a:sfile
	%d_
	0put = l:lines
	:w
	:bd
	let l:out=system('Rscript ' . a:sfile)
	""""let l:rlog='rlog.log'
	""""silent exe 'redir! > ' . l:rlog
	exe 'redir! >' . a:outfile
		silent echo l:out
	redir END
	let l:bfnr=bufwinnr(a:outfile)
	if l:bfnr > 0
		exe l:bfnr . "wincmd w"
		exe 'e ' . a:outfile
	else
		exe 'sp ' . a:outfile
	endif
	""call runasr#Display('/tmp/rlog.log')
	""let l:sout=@a
	""echo l:sout
	""call runasr#Displayer(l:sout,'/tmp/rlog.log',10)
endfunction
vnoremap <buffer> <silent> <CR> :call runasr#ExeBlock('/tmp/sfile.tmp','/tmp/rlog.log')<CR>
""seq(1,100)
""1+1
""3+3
