" File: dubs_syntastic_wrap.vim
" Author: Landon Bouma (landonb &#x40; retrosoft &#x2E; com)
" Last Modified: 2015.01.27
" Project Page: https://github.com/landonb/dubs_syntastic_wrap
" Summary: Syntastic wrapper
" License: GPLv3
" -------------------------------------------------------------------
" Copyright © 2015 Landon Bouma.
" 
" This file is part of Dubsacks.
" 
" Dubsacks is free software: you can redistribute it and/or
" modify it under the terms of the GNU General Public License
" as published by the Free Software Foundation, either version
" 3 of the License, or (at your option) any later version.
" 
" Dubsacks is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty
" of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
" the GNU General Public License for more details.
" 
" You should have received a copy of the GNU General Public License
" along with Dubsacks. If not, see <http://www.gnu.org/licenses/>
" or write Free Software Foundation, Inc., 51 Franklin Street,
"                     Fifth Floor, Boston, MA 02110-1301, USA.
" ===================================================================

" ------------------------------------------
" About:

" A simple wrapper around Syntastic.
"
" In a window, type Ctrl-e to run Syntastic on the buffer
" and open the location list if their are errors, and type
" Ctrl-e again to close the location list.

if exists("g:plugin_dubs_syntastic_wrap") || &cp
  finish
endif
let g:plugin_dubs_syntastic_wrap = 1

" ------------------------------------------------------
" On-the-fly Syntax Checking with Syntastic
" ------------------------------------------------------

" See: https://github.com/scrooloose/syntastic
"      http://www.vim.org/scripts/script.php?script_id=2736

" :SyntasticInfo
" :SyntasticCheck
" :SyntasticReset

" Defaults that the source readme suggests
"   :help syntastic
"
" FIXME: This affects the filename and line/column numbers...
"        is there a way for both to live happily together?
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
" Auto-open :Error(s) window when errors are detected.
let g:syntastic_auto_loc_list = 1
" Stick detected errors into location-list.
let g:syntastic_always_populate_loc_list = 1

" Automatically check files on open and save,
" but only in 'active' mode (set next).
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

" See also per-buffer version, so each project can have its own checkers:
"autocmd FileType python if stridx(expand("%:p"), "/some/path/") == 0 |
"  \ let b:syntastic_checkers = ["pylint"] | endif
"autocmd FileType javascript let b:syntastic_mode = "active"
"
" If you don't like files being automatically linted when opened or
" saved, it's easy to use Ctrl-e to run the checker and then again
" to hide its output, so we indicate all filetypes as passive.
let g:syntastic_mode_map = {
      \ "mode": "passive",
      \ "active_filetypes": [],
      \ "passive_filetypes": ["python", "javascript", "html", "rst"] }
" Hint: Use :SyntasticToggleMode to switch between 'active' and 'passive'.

" Python3...
" FIXME: Will need to do this according to project,
"        or better yet use virtualenv somehow...
let g:syntastic_python_python_exec = "/usr/bin/python3"

" Choose which checker to use (of many for same file type).
"   let g:syntastic_<filetype>_checkers = ['<checker-name>']
" Python: flake8, pyflakes, pylint, (native) python, and many more.
" Chained: let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
" Aggregate errors from multiple checkers:
"let g:syntastic_aggregate_errors = 1
" And uniquely identify the output from each checker:
"let g:syntastic_id_checkers = 1

" *** Syntax Checkers.
"
" For complete list, see:
"   https://github.com/scrooloose/syntastic/wiki/Syntax-Checkers
" What's configured here is for dubsacks, i.e., based on [lb]'s
" preferences and experience with different projects (e.g., not
" all projects will lint cleanly).
" You may want to tweak this for yourself.
" MAYBE: Move the config from here to the style_guard and let it
"        change with each project. Ya know, a virtualenv for Vim.

" The default Python checker is 'pylint'. But if you're looking at
" a project that doesn't conform to today's best practices, the output
" will likely make you cry. So instead, use just the basic Python
" executable and check basic syntax.
" FIXME: Configure this on a pre-project basis...
"        maybe using a .dubsrc file in the hierarchy?
" Python checkers: flake8, frosted, mypy, pep257, pep8, prospector,
"                  py3kwarn, pyflakes, pylama, pylint, python
let g:syntastic_python_checkers = ['python']

" Js default is empty because there's standard Linux JavaScript engine.
" jslint can be very complaining if your code isn't the most compliant,
" so we just jshint just to check syntax.
" FIXME: Again, use a .dubsrc file or something to configure per-project...
"        or does syntastic have some similar way of per-project configuring?
"
" JavaScript checkers: closurecompiler, eslint, flow, gjslint (Closure Linter),
"                      jscs, jshint, jsl, jslint, jsxhint
"let g:syntastic_javascript_checkers = ['jslint']
let g:syntastic_javascript_checkers = ['jshint']
" It's not necessary to set the path like this:
"  let g:syntastic_javascript_jshint_exec = "/usr/local/bin/jshint"

" MAYBE: reStructuredText: rst2pseudoxml, rstcheck
" MAYBE: css checker: csslint, phpcs, prettycss, recess
" MAYBE: html checker: jshint, tidy, validator*, w3* 
" MAYBE: less checker: lessc, recess
" MAYBE: sass checker: sass, sassc
" MAYBE: handlebars checker: handlebars
" MAYBE: json checker: jsonlint, jsonval
" MAYBE: bash checker: bashate, checkbashisms, sh, shellcheck

" Disable style messages (see :help syntastic_quiet_messages):
"let g:syntastic_quiet_messages = { "type": "style" }

" To navigate errors, try :help :lnext and :help :lprev.

" Dubsacks Syntastic Mappings
" ^^^^^^^^^^^^^^^^^^^^^^^^^^^

" In Vim, you can map Ctrl-Shift-to special keys and numbers,
" but not to alphabet characters, so we could map Syntastic
" show/hide to two separate Ctrl-<letter> commands, or we
" could just use a toggler and map it to one.

nnoremap <C-E> :SyntasticToggle(0)<CR>
inoremap <C-E> <C-O>:SyntasticToggle(0)<CR>
"cnoremap <C-E> <C-C>:SyntasticToggle(0)<CR>
"onoremap <C-E> <C-C>:SyntasticToggle(0)<CR>

command -bang -nargs=* SyntasticToggle
  \ :call <SID>SyntasticToggle(<bang>0)
function! <SID>SyntasticToggle(forced)
  let l:is_llist_showing = IsLocationListBuffer()
          \ || IsLocationList(winbufnr(winnr()+1))
  if (l:is_llist_showing == 1 && a:forced != 1) || a:forced == -1
    " Already showing and not being forced open, or being forced closed.
    if l:is_llist_showing == 1
      " Note: If the cursor is in the Location List, it'll move to
      "       the parent window; if in the parent window, it'll close
      "       the Location List window.
      SyntasticReset
    endif
  elseif (l:is_llist_showing == 0 && a:forced != -1) || a:forced == 1
    " Not showing and not being forced-hidden, or being forced to show
    if l:is_llist_showing == 0
      SyntasticCheck
    endif
  endif
endfunction

" What a hack. The :ls command indicates [Location List] or [Quickfix List],
" but there's no other way to access that information, as far as I know.
" Fortunately, some sneaky Vimmer wrote code to just parse the :ls output.
"
" Adapted from:
"  http://vertuxeltes.blogspot.com/2013/10/vim-distinguish-location-list-from.html
" [lb] made it so you can pass buffer number to fcn.

" FIXME: Move this to an autoload utility, eh.

fun! IsLocationListBuffer()
  " Return 1 if the current buffer contains a location list.
  " Return 0 otherwise.
  if &ft != 'qf'
    return 0
  endif
  silent let buffer_list = GetBufferListOutputAsOneString()
  let l:quickfix_match = matchlist(
    \ buffer_list, '\n\s*\(\d\+\)[^\n]*\[Quickfix List\]')
  if empty(l:quickfix_match)
    " no match and ft==qf: current buffer contains a location list
    return 1
  endif
  let quickfix_bufnr = l:quickfix_match[1]
  return quickfix_bufnr == bufnr('%') ? 0 : 1
endfun

"command -bang -nargs=* SyntasticToggle
"  \ :call <SID>SyntasticToggle(<bang>0)
"function! <SID>SyntasticToggle(forced)
"command -nargs=* IsLocationListBuffer
"  \ :call IsLocationListBuffer(<args>)
fun! IsLocationList(buffernr)
  " Return 1 if the current buffer contains a location list.
  " Return 0 otherwise.
  if getbufvar(a:buffernr, "&filetype") != 'qf'
    return 0
  endif
  silent let buffer_list = GetBufferListOutputAsOneString()
  let l:locationlist_match = matchlist(
    \ buffer_list,
    \ '\n\s*' . a:buffernr . '[^\n]*\[Location List\]')
  return empty(l:locationlist_match) ? 0 : 1
endfun

fun! GetBufferListOutputAsOneString()
  " Return the ':ls' output as one string.  Call it with ':silent'
  " to suppress the normal ls output.
  let buffer_list = ''
  redir =>> buffer_list
  ls
  redir END
  return buffer_list
endfun

