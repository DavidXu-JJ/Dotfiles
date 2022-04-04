set nu
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set tabstop=4
syntax on
autocmd BufWritePost $MYVIMRC source $MYVIMRC
set shiftwidth=4
set cin
set mouse=a
set ruler
set cursorline
set cursorcolumn
set cindent
set autoindent
set relativenumber
let g:rainbow_active=1
set backspace=2
set foldmethod=indent
set foldlevelstart=99
set cindent
let mapleader="\<space>"
filetype on

inoremap ' ''<ESC>i
inoremap " ""<ESC>i
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {<CR>}<ESC>O
inoremap } {}<ESC>i


func DeleteSpace()
	let i = 4
	while getline('.')[col('.') - i] == ' ' 
		let i += 1
	endwhile
	if getline('.')[col('.') - 3] == '-' && getline('.')[col('.') - i] == '='
		return "\<ESC>xhhxla"
	else 
		if getline('.')[col('.') - i] == '+' || getline('.')[col('.') - i] == '-' || getline('.')[col('.') - i] == '*' || getline('.')[col('.') - i] == '/' || getline('.')[col('.') - i] == '=' || getline('.')[col('.') - i] == '>' || getline('.')[col('.') - i] == '<' || getline('.')[col('.') - i] == '%'|| getline('.')[col('.') - i] == '!'|| getline('.')[col('.') - i] == '^'|| getline('.')[col('.') - i] == '|'|| getline('.')[col('.') - i] == '&'
			return "\<ESC>bbheldwhela"
		else
			return ""
		endif
	endif
endfunc

function ArrowBracket()
	while 1
		let pre = col('$')
		execute 's/\(<[^<>]*\)\(\s\)\([^<>]*>\)/\1\3/e'
		let now = col('$')
		if pre == now
			break
		endif
	endwhile
endfunction

nnoremap <silent> <leader>r :call ArrowBracket()<CR>A


function DefMap()
	inoremap ! <Space>!<Space><c-r>=DeleteSpace()<CR>
	inoremap & <Space>&<Space><c-r>=DeleteSpace()<CR>
	inoremap ^ <Space>^<Space><c-r>=DeleteSpace()<CR>
	inoremap \| <Space>\|<Space><c-r>=DeleteSpace()<CR>
	inoremap + <Space>+<Space><c-r>=DeleteSpace()<CR>
	inoremap - <Space>-<Space><c-r>=DeleteSpace()<CR>
	inoremap * <Space>*<Space><c-r>=DeleteSpace()<CR>
	inoremap / <Space>/<Space><c-r>=DeleteSpace()<CR>
	inoremap = <Space>=<Space><c-r>=DeleteSpace()<CR>
	inoremap < <Space><<Space><c-r>=DeleteSpace()<CR>
	inoremap > <Space>><Space><c-r>=DeleteSpace()<CR>
	inoremap % <Space>%<Space><c-r>=DeleteSpace()<CR>
	inoremap , ,<Space><ESC>a
endfunction

function CancelMap()
	iunmap !
	iunmap &
	iunmap ^
	iunmap \|
	iunmap +
	iunmap -
	iunmap *
	iunmap /
	iunmap =
	iunmap <
	iunmap >
	iunmap %
	iunmap ,
endfunction

nnoremap <silent> <leader>d :call DefMap()<CR>
nnoremap <silent> <leader>D	:call CancelMap()<CR>

"设置跳出自动补全的括号
func SkipPair()
    if getline('.')[col('.') - 1] == ')' || getline('.')[col('.') - 1] == ']' || getline('.')[col('.') - 1] == '"' || getline('.')[col('.') - 1] == "'" || getline('.')[col('.') - 1] == '}'|| getline('.')[col('.') - 1] == '='|| getline('.')[col('.') - 1] == ';' || getline('.')[col('.') - 1] == ')'|| getline('.')[col('.') - 1] == '>'

        return "\<ESC>la"
    else
        return "\t"
    endif
endfunc
" 将tab键绑定为跳出括号
inoremap <TAB> <c-r>=SkipPair()<CR>

func DeleteBoth()
	if (getline('.')[col('.') - 2] == '(' && getline('.')[col('.') - 1] == ')')||(getline('.')[col('.') - 2] == '[' && getline('.')[col('.') - 1] == ']') || (getline('.')[col('.') - 2] == '"' && getline('.')[col('.') - 1] == '"') ||(getline('.')[col('.') - 2] == "'" && getline('.')[col('.') - 1] == "'") || (getline('.')[col('.') - 2] == '{' && getline('.')[col('.') - 1] == '}') || (getline('.')[col('.') - 2] == '<' && getline('.')[col('.') - 1] == '>') 

		return "\<ESC>2s" 
	else
		return "\<BS>"
	endif
endfunc
inoremap <BS> <c-r>=DeleteBoth()<CR>

"把":g/^\s*\$/d"这个命令换成":DBL"这个容易被(Delete Blank Lines)
"记住的命令,这个命令的作用是删除文档中所有空白行
:command -nargs=0 DBL g/^\s*$/d
" :command -range=% DBL :<line1>,<line2>g/^\s*$/d

"以下命令将文中所有的字符串idiots替换成managers：
":1,$s/idiots/manages/g
"通常我们会在命令中使用%指代整个文件做为替换范围：
":%s/search/replace/g
"以下命令指定只在第5至第15行间进行替换:
":5,15s/dog/cat/g
"以下命令指定只在当前行至文件结尾间进行替换:
":.,$s/dog/cat/g
"以下命令指定只在后续9行内进行替换:
":.,.+8s/dog/cat/g


call plug#begin()
Plug 'ErichDonGubler/vim-sublime-monokai'
Plug 'tpope/vim-commentary'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mg979/vim-visual-multi'
Plug 'luochen1990/rainbow'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/rpc' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
call plug#end()

nnoremap <silent> <leader><space> :FZF<CR>

colorscheme sublimemonokai
set termguicolors

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :cal <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'java' 
		exec "!javac %" 
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		exec "!time python3 %"
    elseif &filetype == 'html'
        exec "!firefox % &"
    elseif &filetype == 'go'
        exec "!go build %<"
        exec "!time go run %"
    elseif &filetype == 'mkd'
        exec "!~/.vim/markdown.pl % > %.html &"
        exec "!firefox %.html &"
	endif
endfunc


let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
	let g:rainbow_conf = {
	\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
	\	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
	\	'operators': '_,_',
	\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
	\	'separately': {
	\		'*': {},
	\		'tex': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
	\		},
	\		'lisp': {
	\			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
	\		},
	\		'vim': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
	\		},
	\		'html': {
	\			'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
	\		},
	\		'css': 0,
	\	}
	\}


let g:airline#extensions#tabline#enabled = 1
"set airline 
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#fnametruncate = 20
let g:airline#extensions#tabline#fnamecollapse = 2
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


nmap <Leader>f [fzf-p]
xmap <Leader>f [fzf-p]

nnoremap <silent> [fzf-p]p     :<C-u>FzfPreviewFromResources project_mru git<CR>
nnoremap <silent> [fzf-p]gs    :<C-u>FzfPreviewGitStatus<CR>
nnoremap <silent> [fzf-p]ga    :<C-u>FzfPreviewGitActions<CR>
nnoremap <silent> [fzf-p]b     :<C-u>FzfPreviewBuffers<CR>
nnoremap <silent> [fzf-p]B     :<C-u>FzfPreviewAllBuffers<CR>
nnoremap <silent> [fzf-p]o     :<C-u>FzfPreviewFromResources buffer project_mru<CR>
nnoremap <silent> [fzf-p]<C-o> :<C-u>FzfPreviewJumps<CR>
nnoremap <silent> [fzf-p]g;    :<C-u>FzfPreviewChanges<CR>
nnoremap <silent> [fzf-p]/     :<C-u>FzfPreviewLines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<CR>
nnoremap <silent> [fzf-p]*     :<C-u>FzfPreviewLines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
nnoremap          [fzf-p]gr    :<C-u>FzfPreviewProjectGrep<Space>
xnoremap          [fzf-p]gr    "sy:FzfPreviewProjectGrep<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"
nnoremap <silent> [fzf-p]t     :<C-u>FzfPreviewBufferTags<CR>
nnoremap <silent> [fzf-p]q     :<C-u>FzfPreviewQuickFix<CR>
nnoremap <silent> [fzf-p]l     :<C-u>FzfPreviewLocationList<CR>

