source $VIMRUNTIME/vimrc_example.vim

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction


"开启行号
set nu
"配色方案为desert
colorscheme desert
"开启语法高亮
syntax enable
syntax on

"设置tab宽度
set tabstop=4
set softtabstop=4
"按退格键时可以一次删除4个空格
set shiftwidth=4
"将tab转为空格
set expandtab

"检测文件类型
filetype on
"设置自动对齐
set autoindent
set cindent
set smartindent
"设置代码匹配，包括括号匹配情况
set showmatch
"去掉命令错误时发出的响声
set vb t_vb=
"关闭闪烁
set novisualbell
set noeb

"显示标尺右下角的行号的列号
set ruler
"显示当前横线
set cursorline
"显示当前竖线
set cursorcolumn
"在状态栏显示正在输入的命令
set showcmd
"左下角显示当前Vim模式
set showmode
"显示文件状态，1为关闭，2为开启
set laststatus=1
"当搜索时尝试smart
set smartcase
"与windows共享粘贴板
set clipboard+=unnamed
"在处理未保存或只读文件的时候，弹出确认
set confirm
"在搜索模式下，随着搜索字符的逐个输入，试试进行字符串匹配，并对首个匹配的字符串高亮显示
set incsearch
"保存的命令历史条数
set history=1000
"打开文件后自动读入修改
set autoread
"启动时不显示帮助乌干达儿童的信息
set shortmess=atI
"关闭备份，即编辑时不生成~后缀文件
set nobackup
"关闭undofile，即不生成un后缀文件
set noundofile
"关闭swapfile，即不生成swap后缀文件
"set noswapfile
"被分割窗口之间显示空白
set fillchars=vert:/
set fillchars=stl:/
set fillchars=stlnc:/ 


"修改字体及字号
set guifont=Courier_new:h10:b:cDEFAULT
"设置字符及文件编码
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,chinese,latin-1
set helplang=cn
if has("win32")
    set fileencoding=chinese
else
    set fileencoding=utf-8
endif
"解决菜单乱码
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

"解决console输出乱码
language messages zh_CN.utf-8

"Ctrlp配置
set runtimepath^=D:\\software\\Vim\\Ctrlp\\bundle\\ctrlp.vim


"设置大括号、小括号、方括号以及单双引号的自动补全
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {}<Esc>i
autocmd Syntax html,vim inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=CloseBracket()<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

function ClosePair(char)
 if getline('.')[col('.') - 1] == a:char
 return "\<Right>"
 else
 return a:char
 endif
endf

function CloseBracket()
 if match(getline(line('.') + 1), '\s*}') < 0
 return "\<CR>}"
 else
 return "\<Esc>j0f}a"
 endif
endf

function QuoteDelim(char)
 let line = getline('.')
 let col = col('.')
 if line[col - 2] == "\\"
 return a:char
 elseif line[col - 1] == a:char
 return "\<Right>"
 else
 return a:char.a:char."\<Esc>i"
 endif
endf
