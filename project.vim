
map ,xt :call BuildAndRunTests()<CR>
function! BuildAndRunTests()
  echo "Building and running tests... "
  silent !make >/tmp/kata.log 2>&1
  if v:shell_error != 0
    set errorformat=
      \%f:%l:%c:{%*[^}]}:\ error:\ %m,
      \%f:%l:%c:{%*[^}]}:\ fatal\ error:\ %m,
      \%f:%l:%c:{%*[^}]}:\ warning:\ %m,
      \%f:%l:%c:\ error:\ %m,
      \%f:%l:%c:\ fatal\ error:\ %m,
      \%f:%l:%c:\ warning:\ %m,
      \%f:%l:\ error:\ %m,
      \%f:%l:\ fatal\ error:\ %m,
      \%f:%l:\ warning:\ %m
    cfile /tmp/kata.log
  else
    echon "OK"
  endif
endfunction

" vim:set sts=2 sw=2 ai et:
