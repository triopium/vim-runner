function! runasr#ExeLine()
	let l:cline=getline('.')
	let l:cline=substitute(l:cline,'^"\{1,2}\|\s*','',0)
	let l:cmd='Rscript -e ' . shellescape(l:cline)
	let l:out=system(l:cmd)
	echo l:out
	return l:out
endfunction
""nnoremap <buffer> <leader><CR> :call runasr#ExeLine()

function! runasr#Displayer(output)
	""Display the output
	let l:bfnr=bufwinnr(a:output)
	if l:bfnr > 0
		exe l:bfnr . "wincmd w"
		exe 'e ' . a:output
		set nomod
		1d_
		w
	else
		exe 'sp ' . a:output
		set nomod
		1d_
		w
	endif
endfunction
>>>>>>> fbe97d414312ec9c7bdeb84e6e27256e1b637c37

function! runasr#ExeBlock(sfile,outfile) range
	""Construct script file
	let l:lines=getline(a:firstline,a:lastline)
	let l:lines=array#ListSubstitute(l:lines,'^"\{,2}\|\s*','',0)
	exe '0sp ' a:sfile
	%d_
	0put = l:lines
	:w
	:bd
	""Run constructed script file
	let l:out=system('Rscript ' . a:sfile)
	exe 'redir! >' . a:outfile
		silent echo l:out
	redir END
	let l:outfile=a:outfile
	call runasr#Displayer(l:outfile)
endfunction
vnoremap <buffer> <silent> <CR> :call runasr#ExeBlock('/tmp/sfile.tmp','/tmp/rlog.log')<CR>
""seq(1,100)
""x<-seq(1,10)
""x
function! runasr#ExeFile(outfile)
	let l:bname=bufname('%')
	let l:out=system('Rscript ' . l:bname)
	exe 'redir! >' . a:outfile
		silent echo l:out
	redir END
	let l:outfile=a:outfile
	call runasr#Displayer(l:outfile)
endfunction
nnoremap <buffer> <leader><CR> :call runasr#ExeFile()

