function! runasr#ExeLine()
	let l:cline=getline('.')
	let l:cline=substitute(l:cline,'^"\{1,2}\|\s*','',0)
	let l:cmd='Rscript -e ' . shellescape(l:cline)
	let l:out=system(l:cmd)
	echo l:out
	return l:out
endfunction
""seq(1,100)

nnoremap <buffer> <CR> :call runasr#ExeLine()

function! runasr#ExeBlock(sfile) range
	let l:lines=getline(a:firstline,a:lastline)
	let l:lines=array#ListSubstitute(l:lines,'^"\{,2}\|\s*','',0)
	exe '0sp ' a:sfile
	%d_
	0put = l:lines
	:w
	:bd
	let l:out=system('Rscript ' . a:sfile)
	""let l:rlog='rlog.log'
	""silent exe 'redir! > ' . l:rlog
	redir @a
		silent echo l:out
	redir END
	return @a
endfunction
vnoremap <buffer> <silent> <CR> :calf runasr#ExeBlock('/tmp/sfile.tmp')
"
""seq(1,100)
""1+1
""3+3

function! runasr#Displayer(output,fname,lines)
	if bufexists(a:fname)
		let l:bfnr=bufwinnr(a:fname)
		if  l:bfnr > 0
			exe l:bfnr . "wincmd w"
			%d_
			0put = a:output
			w
		else
			exe  a:lines . 'new ' a:fname
			%d_
			0put = a:output
			w
		endif
	else
		if filereadable(a:fname)
			exe a:lines . 'sp ' a:fname
			%d_
			0put = a:output
			w
		else
			exe a:lines . 'sp ' a:fname
			%d_
			0put = a:output
			w
		endif
	endif
endfunction
""call runasr#Displayer(runasr#ExeBlock('/tmp/rscript.tmp'),'/tmp/rscript.log',10)
