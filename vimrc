" to override vim's initializations
set nocompatible
" colorscheme desert
colorscheme default

" both required for vimwiki
filetype plugin on
syntax enable
" syntax on

set mouse=a
set autoread
"
set encoding=utf-8
set backspace=2 " make backspace work like most other programs

" Number lines and cursor line
set number relativenumber
set ruler
set cursorline
set signcolumn=yes

" when opening new buffer, (??)
set hidden

" Bracket matching
set showmatch
set matchtime=5

" Indent by 2 spaces (no tabs) by default
set expandtab
set softtabstop=2
set shiftwidth=2
set autoindent

" Copy/paste to system clipboard
vnoremap <C-c> "*y
vnoremap <C-x> "*d
vnoremap <C-v> "*p

" Search settings
set hlsearch
set incsearch
set ignorecase
set fileignorecase
set foldopen-=search " Don't open folds when searching
hi Search cterm=NONE ctermfg=DarkMagenta ctermbg=LightYellow

" Search settings
set wildmenu
set wildmode=longest:full,full
set wildignorecase " requireds to set ignorecase to fully work
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set wildignore+=*.class,*.pyc,*/node_modules/*,*.o
set showcmd

" Allow some space either side (vertically) of the cursor when scrolling
set scrolloff=2

" title NB it'll be overwritten by in tmux
set title
set titlestring=VIM:\ %-25.55F\ %a%r%m titlelen=70

" Always show the status line
set laststatus=2
set statusline=%F\

" Sensible split directions
set splitbelow
set splitright

" Make Y behave like C and D
nnoremap Y y$

" S to join (free J up)
nnoremap S J

" % is awkward
nnoremap <Tab> %
onoremap <Tab> %
vnoremap <Tab> %

" Backspace to go to the first character of the line above
nnoremap <BS> -

" Nice invisibles
set listchars=tab:▸\ ,eol:¬

" F1 for buffer list
nnoremap <F1> :ls<CR>

" Disable swap file creation
set noswapfile

" C-s to save in insert mode
inoremap <C-s> <esc>:w<CR>gi

" Scroll around in insert mode
inoremap <C-e> <C-x><C-e>
inoremap <C-y> <C-x><C-y>

" Default K is annoying
vnoremap K <Nop>

" Autocomplete (only search current buffer)
set complete=.

" Make folds easier to see
" set foldcolumn=1

" gitgutter signcolumn
" highlight! link SignColumn LineNr
" highlight SignColumn guibg=Red ctermbg=Red

filetype plugin indent on
" Tabs and spaces
" au FileType c setl et sw=4 sts=4
" au FileType cpp setl et sw=2 sts=2
" au FileType make setl noet sw=4 ts=4 sts=4
" au FileType java setl et sw=4 sts=4
au FileType python setlocal expandtab shiftwidth=4 softtabstop=4 commentstring=#%s formatoptions+=cro
au FileType rust setlocal expandtab shiftwidth=4 softtabstop=4

" Don't interpret "vim: ..." commit messages as modelines
autocmd FileType gitrebase setlocal nomodeline
autocmd FileType gitcommit setlocal nomodeline

au BufRead,BufNewFile *.sh set filetype=sh
au BufRead,BufNewFile *.py set filetype=python
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.nix set filetype=nix
au BufRead,BufNewFile *.vim set filetype=vim

" set clipboard+=unnamed  " use the clipboards of vim and win
set clipboard=unnamedplus  " use the clipboards of vim and win
set go+=a " Visual selection automatically copied to the clipboard

let mapleader=","

autocmd BufWritePre * :%s/\s\+$//e " remove trailing whitespaces on save

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'https://github.com/ctrlpvim/ctrlp.vim.git'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jmcantrell/vim-virtualenv'
Plug 'LnL7/vim-nix'
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'https://github.com/junegunn/fzf.vim.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/tpope/vim-eunuch.git'
Plug 'https://github.com/airblade/vim-gitgutter.git'
" Plug 'APZelos/gitline.vim'
Plug 'Eliot00/git-lens.vim'
" Plug 'ryu-ichiroh/vim-cspell', {'tag': 'v0.7'}
Plug 'github/copilot.vim'
Plug 'https://github.com/DanBradbury/copilot-chat.vim.git'
Plug 'dense-analysis/ale'
Plug 'prabirshrestha/vim-lsp'
Plug 'vimwiki/vimwiki'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
call plug#end()



" Section: fzf_vim
nnoremap <leader>P :Files<CR>
nnoremap <leader>B :Buffers<CR>
" use Ag silversearch to fuzzy search within folder files
nnoremap <leader>g :Ag<CR>
" make RG fold for narrow pages
let g:rg_command = 'rg --vimgrep --no-heading --smart-case'
nnoremap <leader>r :Rg<CR>
" make it bigger
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" Section: ALE configuration
let g:ale_linters={
  \ 'python': ['pyright', 'flake8'],
  \ 'sh': ['shellcheck'],
  \}
let g:ale_fixers={
  \ '*': ['remove_trailing_lines', 'trim_whitespace',],
  \ 'python': ['isort', 'black'],
  \ 'markdown': ['prettier'],
  \ 'sh': ['shfmt'],
  \}
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1 " will change things automatically
let g:ale_completion_enabled = 0  " Disable ALE completion to avoid conflicts
let g:ale_hover_cursor = 0 " use hover from vim-lsp
let g:ale_python_auto_pipenv = 1
let g:ale_python_pyright_auto_pipenv = 1
let g:ale_python_pyright_executable = 'pyright-langserver'
let g:ale_python_pyright_options = '--stdio --project caiman_asr_train --project myrtle_asr_train --project myrtle_data'
let g:ale_python_isort_auto_pipenv = 1
let g:ale_python_isort_options = '--profile=black --project=caiman_asr_train --project=myrtle_asr_train --project=myrtle_data'
let g:ale_python_flake8_auto_pipenv = 1
let g:ale_python_flake8_options = '--extend-ignore=E203,F401,F722 --max-line-length=92 caiman-asr-dev/'
" let g:ale_python_ruff_auto_pipenv = 1 " NB if use ruff add it in ale_fixers and ale_linters
" let g:ale_python_ruff_options = '--select F401 --fix'
let g:ale_python_black_auto_pipenv = 1
let g:ale_markdown_prettier_options = '--single-quote --trailing-comma all'
let g:ale_virtualtext_cursor = 0 " 'current'
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
let g:ale_sign_info = 'ℹ'


" On the ALE and vim-lsp note, the language server works with the
" pyrightconfig.json file in the root of the project.

" Section: vim-lsp
if executable('pyright-langserver')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyright',
        \ 'cmd': ['pyright-langserver', '--stdio', '--project', 'caiman_asr_train', '--project', 'myrtle_asr_train', '--project', 'myrtle_data'],
        \ 'allowlist': ['python'],
        \ 'initialization_options': {
        \     'python': {
        \         'analysis': {
        \             'typeCheckingMode': 'basic',
        \             'reportUnboundVariable': 'none'
        \         }
        \     }
        \ }
        \ })
endif

if executable('ruff')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'ruff',
        \ 'cmd': {server_info->['ruff', 'server']},
        \ 'allowlist': ['python'],
        \ 'workspace_config': {'ruff': {'args': ['--line-length', '92']}},
        \ })
endif

if executable('nil')
  autocmd User lsp_setup call lsp#register_server({
    \ 'name': 'nil',
    \ 'cmd': {server_info->['nil']},
    \ 'whitelist': ['nix'],
    \ })
endif

" can make <leader>gd instead.
nnoremap <silent> h :LspHover<CR>
nnoremap <silent> gd :LspDefinition<CR>
nnoremap <silent> gr :LspReferences<CR>
nnoremap <leader> dn :LspNextError<CR>
nnoremap <leader> dp :LspPreviousError<CR>
nnoremap <silent> ca :LspCodeAction<CR>

" autocmd CursorHold * silent! LspHover " disable auto hover
let g:lsp_diagnostics_virtual_text_enabled = 0 " Disable virtual text
let g:lsp_diagnostics_echo_cursor = 1  " Show diagnostics in the command area when cursor is on an error
let g:lsp_diagnostics_virtual_text_position = 'right'
let g:lsp_diagnostics_float_cursor = 0 " Disable floating windows for diagnostics

" Section: vimwiki
let g:vimwiki_list = [{'syntax': 'markdown', 'ext': '.md', 'auto_toc': 1, 'auto_tags': 0}]
let g:vimwiki_filetypes = ['markdown']
let g:vimwiki_hl_headers = 1 " diff header colours
let g:vimwiki_listing_hl = 1
let g:vimwiki_hl_cb_checked = 1
let g:vimwiki_conceallevel = 2 " default, to conceal urls
let g:vimwiki_table_auto_fmt = 1 " default, to format tables
let g:vimwiki_folding = '' " options: 'syntax' 'expr' 'syntax' 'indent'
let g:vimwiki_rx_todo = '\C\<\%(XXX\)\>'
let g:vimwiki_auto_toc = 1
let g:wiki_nested_syntaxes = {'python': 'python', 'sh': 'sh', 'bash': 'sh'}
" vimwiki headers colors:
hi VimwikiHeader1 cterm=bold ctermfg=yellow
hi VimwikiHeader2 cterm=bold ctermfg=brown
hi VimwikiHeader3 cterm=bold ctermfg=blue
hi VimwikiHeader4 cterm=bold ctermfg=lightgreen
hi VimwikiHeader5 cterm=bold ctermfg=brown
hi VimwikiHeader6 cterm=bold ctermfg=brown

" Section: NERDTree
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>g :NERDTreeFocus<CR>
" nmap <Leader>r :NERDTreeFocus<cr>R<c-w><c-p> " to refresh NERDTree
let NERDChristmasTree = 1
let NERDTreeHighlightCursorline = 1
" let NERDTreeShowHidden = 1
let NERDTreeIgnore=['\.git','\.DS_Store','\.pdf', '.beam']



" Section: CtrlP
let g:ctrlp_max_files=0 " no limit on files
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)|__pycache__$',
  \ 'file': '\v\.(exe|so|dll|pyc)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
let g:ctrlp_open_new_file = 't' " open file in new tab

" " Section: Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#virtualenv#enabled = 1
let g:airline#extensions#virtualenv#ft = ['python', 'markdown', 'vim']
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]' " skip utf-8[unix] in encoding
let g:airline_powerline_fonts = 1
let g:airline_section_c = '%F'
let g:airline_section_z = '%p%% line: %l/%L col: %c'
let g:airline_section_error = ''
let g:airline_section_warning = ''
let g:airline#extensions#fugitiveline#enabled = 1 " show git branch tagbar b
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline_left_sep=' '
let g:airline_right_sep=' '
let g:airline_detect_spell=1
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>0 <Plug>AirlineSelectTab0


" Section: git-lens
let g:GIT_LENS_ENABLED = 1

" Section: gitline
" not tested yet. adds git info in vim airline iiuc

" Section: Airline Theme
let g:airline_theme = 'light'
" few alternatives: 'jellybeans' 'laederon' 'durant' 'papercolor'


" Section: vim-virtualenv
" NB not working
" let g:virtualenv_path = expand('~/.virtualenvs')
let g:virtualenv_directory = expand('~/$WORKON_HOME')
let g:virtualenv#prompt = '(%s)'


" Section: Markdown Preview
let g:mkdp_auto_close = 0
let g:mkdp_auto_start = 0
let g:mkdp_command_for_global = 1
let g:mkdp_open_to_the_world = 0
let g:mkdp_echo_preview_url = 1
let g:mkdp_open_ip = '127.0.0.1'
let g:mkdp_theme = 'dark'


" Section: copilot
let g:copilot#enable_mappings = 0
let g:copilot_filetypes = {
  \ 'gitcommit': v:true,
  \ 'markdown': v:true,
  \ 'yaml': v:true,
  \ 'perl': v:true
  \ }

" Replace tab w/ C-j  CR is regular carriage return fallback is used
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true
" accept 1 word of current suggestion
imap <C-L> <Plug>(copilot-accept-word)
imap <C-K> <Plug>(copilot-next)

" Section: copilot chat
" use <leader> cc to open chat
" NB that ctrl+w does not work

" Section: Buffer switching w/ <leader>
map <leader>n :bnext<cr>
map <leader>m :bprevious<cr>
map <leader>d :bdelete<cr>
map <leader>l :buffers<cr>

" Section: Fugitive
" Gw
" Git
" Gdiffsplit
" Gblame
" Gcommit
let g:fugitive_diff_command = 'Gdiffsplit!'

" Section: Gitgutter
highlight GitGutterAdd    guifg=#009900 ctermfg=2 cterm=bold ctermbg=black
highlight GitGutterChange guifg=#bbbb00 ctermfg=3 cterm=bold ctermbg=black
highlight GitGutterDelete guifg=#ff2222 ctermfg=1 cterm=bold ctermbg=black
set updatetime=100
" TODO what are hunks p
" TODO gitgutter grep
"
"
function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction
set statusline+=%{GitStatus()}


" Section: set spell
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>
let g:lexical#spelllang = ['en_gb']
hi clear SpellBad
hi SpellBad cterm=underline,bold ctermfg=DarkGray ctermbg=lightmagenta

" Section: custom commands
"
" Define a command :Today that inserts the current date
command! Today execute "normal! i" . strftime(" %Y%b%d")

" Write starters of task experiment
command! Task call InsertTaskTemplate()

function! InsertTaskTemplate()
  " Move to insert mode and insert the formatted text
  execute "normal! oDATE " . strftime("%Y%b%d")
  execute "normal! oNAME"
  execute "normal! oTASK"
  execute "normal! oLOCATION"
  execute "normal! oCOMMENTS"
endfunction
