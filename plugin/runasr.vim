function! runasr#ExeLine()
	let l:cline=getline('.')
	let l:cline=substitute(l:cline,'^"\{1,2}\|\s*','',0)
	let l:cmd='Rscript -e ' . shellescape(l:cline)
	let l:out=system(l:cmd)
	echo l:out
	""echo l:out
	""exe l:cmd
	""echo l:out
endfunction
""seq(1,100)

nnoremap <buffer> <CR> :call runasr#ExeLine()

function! runasr#ExeBlock(sfile)
	let l:lines=getline(a:firstline,a:lastline)
	let l:lines=array#ListSubstitute(l:lines,'^"\{,2}\|\s*','',0)
	exe '0sp ' a:sfile
	%d_
	0put = l:lines
	:w
	:bd
	let l:out=system('Rscript ' . a:sfile)
	return l:out
	""echo l:out
	""exe a:lines . 'new ' . a:ofile
endfunction
""vnoremap <buffer> <CR> :call runasr#ExeBlock('/tmp/sfile.tmp')
""cat(seq(1,100))
""1+1
""3+3
function! runasr#DisplayProperties()
	setlocal noswapfile nomodified
endfunction
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
""let out=runasr#ExeBlock() 
vnoremap <buffer> <silent> <CR> :call runasr#Displayer(runasr#ExeBlock('rscript.tmp'),'/tmp/fout.log',10)
