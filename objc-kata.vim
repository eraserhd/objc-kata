
map ,xt :call BuildAndRunTests()<CR>
function! BuildAndRunTests()
  echo "Building and running tests... "
  silent !make >/tmp/kata.log 2>&1
  if v:shell_error != 0
    cfile /tmp/kata.log
  else
    echon "OK"
  endif
endfunction

" vim:set sts=2 sw=2 ai et:
