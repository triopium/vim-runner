"PARSE CURRENT LINE AS VIMCOMMAND:
function! runasvim#ParseLineAsCommand()
	let l:curline=getline('.')
	let l:curline=substitute(l:curline,'^"*\|\s*','',0)
	let l:choice=confirm("Run following line:\n" . l:curline,"&run\n&cancel",2)
	if l:choice==1
		exe l:curline
	endif
endfunction
""example mapping
""nnoremap <leader><CR> :call runasvim#ParseLineAsCommand()<CR>

"PARSE SELECTION AS VIMCOMMAND:"
function! runasvim#ParseSelectionAsCommand() range
	let l:lines=getline(a:firstline,a:lastline)
	let l:lines=array#ListSubstitute(l:lines,'^"\{,2}\|\s*','',0)
	let l:tlines=join(l:lines,"\n") . "\n"
	let l:choice=confirm("Run following lines:\n" . l:tlines,"&run\n&cancel",2)
	if l:choice==1
		exe l:tlines
	endif
endfunction
""example mapping
""vnoremap <leader><CR> :call runasvim#ParseSelectionAsCommand()<CR>
