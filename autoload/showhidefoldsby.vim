" showhidefoldsby.vim - Common library for vim-showhidefoldsby
" Maintainer: Rocco Caputo <https://github.com/rcaputo/vim-showhidefoldsby>
" Version: 0 (unreleased)
" vim: noexpandtab

" Avoid autoloading more than once.
if exists("g:loaded_showhidefoldsby") || &cp
	finish
endif
let g:loaded_showhidefoldsby = 1

" Not recursive: Uses script-local variables so another function can
" restore them.
function showhidefoldsby#SaveState()
	" Save the bell status, and turn off visual and audible bells.
	let s:saved_vb = &vb || 0
	let s:saved_tvb = &t_vb || ''
	let &vb = 1
	let &t_vb = ''

	" Remember the cursor's position in the file.
	let s:save_cursor = winsaveview()
	let s:save_winline = winline()
endfunction

" Not recursive: Uses script-local variables so another function can
" set them.  Destroys those variables when done.
function showhidefoldsby#RestoreState()
	" Restore the cursor's position on the line.
	call winrestview(s:save_cursor)
	unlet s:save_cursor

	let s:winline_off = winline() - s:save_winline

	while (s:winline_off < 0)
		" <C-Y>
		exec "normal \x19"
		let s:winline_off = s:winline_off + 1
	endwhile

	while (s:winline_off > 0)
		" <C-E>
		exec "normal \x05"
		let s:winline_off = s:winline_off - 1
	endwhile

	unlet s:save_winline
	unlet s:winline_off

	" Restore audible and visual bell.
	let &vb = s:saved_vb
	let &t_vb = s:saved_tvb
	unlet s:saved_vb
	unlet s:saved_tvb
endfunction
