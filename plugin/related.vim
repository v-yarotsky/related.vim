if exists("g:loaded_related")
  finish
endif

if !has("ruby")
  echohl ErrorMsg
  echon "Sorry, Related requires ruby support."
  finish
endif

let g:loaded_related = 1

let ruby_module = fnameescape(globpath(&runtimepath, 'lib/related.rb'))
exe 'rubyfile ' . ruby_module

function! s:GetRelatedFile()
  :ruby Related.open_related_file
endfunction

function! s:RunRelatedTest()
  :ruby Related.run_test
endfunction

command! RelatedOpenFile :call <SID>GetRelatedFile()
command! RelatedRunTest  :call <SID>RunRelatedTest()

finish

