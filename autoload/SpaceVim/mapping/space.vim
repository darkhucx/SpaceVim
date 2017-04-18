function! SpaceVim#mapping#space#init() abort
    if s:has_map_to_spc()
        return
    endif
    nnoremap <silent><nowait> [SPC] :<c-u>LeaderGuide " "<CR>
    nmap <Space> [SPC]
    let g:_spacevim_mappings_space = {}
    let g:_spacevim_mappings_space.t = {'name' : '+Toggle editor visuals'}
    let g:_spacevim_mappings_space.a = {'name' : '+Applications'}
    let g:_spacevim_mappings_space.b = {'name' : '+Buffers'}
    nnoremap <silent> [SPC]bn :bnext<CR>
    let g:_spacevim_mappings_space.b.n = ['bnext', 'next buffer']
    nnoremap <silent> [SPC]bp :bp<CR>
    nnoremap <silent> [SPC]bN :bN<CR>
    let g:_spacevim_mappings_space.b.p = ['bp', 'previous buffer']
    let g:_spacevim_mappings_space.b.N = ['bN', 'previous buffer']
    let g:_spacevim_mappings_space.e = {'name' : '+Errors'}
    let g:_spacevim_mappings_space.B = {'name' : '+Global-uffers'}
    nnoremap <silent> [SPC]tn  :<C-u>set nu!<CR>
    let g:_spacevim_mappings_space.t.n = ['set nu!', 'toggle line number']
endfunction

function! SpaceVim#mapping#space#def(m, keys, cmd, desc, is_cmd) abort
    if s:has_map_to_spc()
        return
    endif
    if a:is_cmd
        let cmd = ':<C-u>' . a:cmd . '<CR>' 
        let lcmd = a:cmd
    else
        let cmd = a:cmd
        let feedkey_m = a:m =~# 'nore' ? 'n' : 'm'
        if a:cmd =~? '^<plug>'
            let lcmd = 'call feedkeys("\' . a:cmd . '", "' . feedkey_m . '")'
        else
            let lcmd = 'call feedkeys("' . a:cmd . '", "' . feedkey_m . '")'
        endif
    endif
    exe a:m . ' <silent> [SPC]' . join(a:keys, '') . ' ' . cmd
    if len(a:keys) == 2
        let g:_spacevim_mappings_space[a:keys[0]][a:keys[1]] = [lcmd, a:desc]
    elseif len(a:keys) == 1
        let g:_spacevim_mappings_space[a:keys[0]] = [lcmd, a:desc]
    endif
endfunction

function! s:has_map_to_spc() abort
    if !exists('s:flag')
        let s:flag = !empty(maparg('<space>', '',0,1))
    endif
    return s:flag
endfunction
