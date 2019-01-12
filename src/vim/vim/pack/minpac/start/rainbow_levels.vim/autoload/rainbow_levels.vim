func! rainbow_levels#toggle() abort
	if rainbow_levels#is_on()
		call rainbow_levels#off()
	else
		call rainbow_levels#on()
	endif
endfunc

func! rainbow_levels#is_on() abort
	return exists('w:rainbow_levels_match_ids') && !empty(w:rainbow_levels_match_ids)
endfunc

func! rainbow_levels#off() abort
	while rainbow_levels#is_on()
		silent! call matchdelete(remove(w:rainbow_levels_match_ids, -1))
	endwhile
endfunc

func! rainbow_levels#on() abort
	let w:rainbow_levels_match_ids = []
	let l:level = 0

	while hlexists('RainbowLevel'.l:level)
		call rainbow_levels#match(l:level)
		let l:level += 1
	endwhile
endfunc

func! rainbow_levels#match(level) abort
	let l:group   = 'RainbowLevel'.a:level
	let l:pattern = rainbow_levels#pattern(a:level)
	call add(w:rainbow_levels_match_ids, matchadd(l:group, l:pattern, -10))
endfunc

func! rainbow_levels#pattern(level) abort
	if rainbow_levels#spaces_indentation()
		return rainbow_levels#spaces_pattern(a:level)
	endif

	if rainbow_levels#mixed_indentation()
		return rainbow_levels#mixed_pattern(a:level)
	endif

	return rainbow_levels#tabs_pattern(a:level)
endfunc

func! rainbow_levels#spaces_indentation() abort
	return &l:expandtab
endfunc

func! rainbow_levels#spaces_pattern(level) abort
	let l:start = a:level * &l:tabstop
	let l:end   = l:start + &l:tabstop - 1
	return '^ \{'.l:start.','.l:end.'}\S.*$'
endfunc

func! rainbow_levels#mixed_indentation() abort
	return &l:softtabstop > 0 && !&l:expandtab && &l:softtabstop < &l:tabstop
endfunc

func! rainbow_levels#mixed_pattern(level) abort
	let l:tabs = a:level / &l:softtabstop

	if a:level % &l:softtabstop
		let l:spaces = &l:softtabstop
	else
		let l:end    = &l:softtabstop - 1
		let l:spaces = '0,'.l:end
	endif

	return '^\t\{'.l:tabs.'} \{'.l:spaces.'}\S.*$'
endfunc

func! rainbow_levels#tabs_pattern(level) abort
	return '^\t\{'.a:level.'}\ *\S.*$'
endfunc

func! rainbow_levels#get_colors_file(dir) abort
	let l:colors_name = get(g:, 'colors_name', 'default')
	let l:colors_name = l:colors_name =~ 'base16' ? 'base16' : l:colors_name
	let l:colors_file = resolve(expand(a:dir.'/'.l:colors_name.'.vim'))

	if empty(glob(l:colors_file))
		let l:colors_file = resolve(expand(a:dir.'/default.vim'))
	endif

	return l:colors_file
endfunc
