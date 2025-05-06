syntax match VimwikiKeywordTODO /\<TODO\>/
highlight VimwikiKeywordTODO cterm=bold ctermfg=Red

syntax match VimwikiKeywordURGENT /\<URGENT\>/
highlight VimwikiKeywordURGENT cterm=underline,bold ctermfg=DarkRed ctermbg=black

syntax match VimwikiKeywordDONE /\<DONE\>/
highlight VimwikiKeywordDONE cterm=bold ctermfg=DarkGreen

syntax match VimwikiKeywordWAITING /\<BUG\>/
highlight VimwikiKeywordWAITING cterm=underline,bold ctermfg=Yellow

syntax match VimwikiKeywordINPROGRESS /\<INPROGRESS\>/
highlight VimwikiKeywordINPROGRESS cterm=bold ctermfg=Blue

syntax match VimwikiKeywordFIXED /\<FIXED\>/
highlight VimwikiKeywordFIXED cterm=bold ctermfg=DarkCyan

syntax match VimwikiKeywordXXX /\<ETA\>/
highlight VimwikiKeywordXXX cterm=underline,bold ctermfg=DarkYellow

syntax match VimwikiKeywordNOT /\<NOT\>/
highlight VimwikiKeywordNOT cterm=underline,bold ctermfg=Red

syntax match VimwikiKeywordNO /\<NO\>/
highlight VimwikiKeywordNO cterm=underline,bold ctermfg=Red

syntax match VimwikiKeywordNO /\<ERROR\>/
highlight VimwikiKeywordNO cterm=underline,bold ctermfg=DarkRed

syntax match VimwikiKeywordNB /\<NB\>/
highlight VimwikiKeywordNB cterm=bold ctermfg=DarkYellow

syntax match VimwikiKeywordOK /\<OK\>/
highlight VimwikiKeywordOK cterm=bold ctermfg=DarkGreen ctermbg=black

syntax match VimwikiKeywordRESULT /\<RESULT\>/
highlight VimwikiKeywordRESULT cterm=bold ctermfg=DarkCyan ctermbg=black

syntax match VimwikiKeywordINOTES /\<NOTE\>/
highlight VimwikiKeywordINOTES cterm=bold ctermfg=Blue

" highlight the pattern nnnnwwwnn where n is a number and w is a word
syntax match VimwikiDate /\<\d\{4}[a-zA-Z]\{3}\d\{2}\>/
highlight VimwikiDate cterm=underline ctermfg=DarkCyan
" syntax match VimwikiDate /\d{4}\w{3}\d{4}/ "containedin=ALL
" highlight VimwikiDate cterm=bold,underline ctermfg=DarkCyan

" single and triple code background colours
highlight VimwikiCode ctermbg=black ctermfg=magenta
highlight VimwikiCodeBlockBackground cterm=bold ctermbg=25 guibg=#2E2E2E

" NB the autocommands below are not working as expected
" Set up fenced code block syntax highlighting for common languages in Vimwiki
augroup VimwikiCodeBlockHighlight
  autocmd!
  autocmd FileType vimwiki highlight link vimwikiCode VimwikiCode
  autocmd Syntax vimwiki syntax include @markdown syntax/markdown.vim
  autocmd FileType vimwiki syntax region vimwikiCode start=/```bash/ end=/```/ keepend
  autocmd FileType vimwiki syntax region vimwikiCode start=/```python/ end=/```/ keepend
  autocmd FileType vimwiki syntax region vimwikiCode start=/```markdown/ end=/```/ keepend
  " Apply custom background color to code blocks
  autocmd FileType vimwiki highlight link vimwikiCode VimwikiCode
  "
  " autocmd FileType vimwiki syntax region VimwikiCodeBlock matchgroup=VimwikiCodeBlockBackground start=/```/ end=/```/ keepend
  " autocmd FileType vimwiki highlight link VimwikiCodeBlock VimwikiCodeBlockBackground
augroup END

" Custom highlight for table headers in markdown
highlight MarkdownTableHeader guifg=#FFA500 guibg=#2E2E2E ctermfg=214 ctermbg=235

" Match the first row in tables (assuming headers are defined there)
syntax match MarkdownTableHeader /|.*|/ containedin=markdownTable,markdownCodeBlock keepend

syntax match GanttBar /\v\[\#{1,}[-#]*\]/ containedin=ALL
highlight GanttBar cterm=bold ctermfg=DarkCyan


" Define a bunch of keywords and their highlight colors
let s:keywords = {
      \ 'PLANNING': 'DarkCyan',
      \ 'DATE': 'Blue',
      \ 'NAME': 'Yellow',
      \ 'TASK': 'Yellow',
      \ 'COMMENTS': 'Yellow',
      \ 'LOCATION': 'Yellow'
      \ }

for [kw, color] in items(s:keywords)
  execute 'syntax match VimwikiKeyword' . kw . ' /\<' . kw . '\>/'
  execute 'highlight VimwikiKeyword' . kw . ' ctermfg=' . color . ' cterm=bold'
endfor
