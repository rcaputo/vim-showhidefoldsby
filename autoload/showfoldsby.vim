" See showhidefoldsby.vim for master file header.
" vim: noexpandtab

" Avoid autoloading more than once.
if exists("g:loaded_showfoldsby")
	finish
endif
let g:loaded_showfoldsby = 1

function showfoldsby#HighlightGroup(group_name)
	call showhidefoldsby#SaveState()

	normal gg
	normal zM

	let l:lastline = -1
	let l:hlid = hlID(a:group_name)

	" We're in a new region as long as the current line number is not
	" the same as the previous one.  "zj" will no longer move the
	" current line number once we're at the last region.
	while l:lastline != line('.')
		if index(synstack(line('.'), col('.')), l:hlid) >= 0
			normal zo
		endif
		let l:lastline = line('.')
		normal zj
	endwhile

	call showhidefoldsby#RestoreState()
endfunction
