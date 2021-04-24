" 前缀键
let mapleader=";"
" 默认显示行号
 set nu 
" 显示相对行号
set relativenumber
" 设置tab键空格数
set softtabstop=2
set expandtab
" 括号高亮
set showmatch 
" 搜索忽略大小写 
set ignorecase 
" 自动适配大写字母
set smartcase
"   开启实时走索
set incsearch
set hlsearch
" 显示光标当前位置
set ruler
" 显示现有命令
set showcmd
" 文件类型识别
filetype on
"  根据侦测懂得不同类型加载对应插件
filetype plugin on
filetype plugin indent on
" 开启语法高亮
syntax enable
syntax on
" 语法高亮折叠
set foldmethod=syntax
"  默认不折叠代码
set foldlevelstart=90
"  设置编码格式
set termencoding=utf-8
set encoding=utf-8
set helplang=cn
set langmenu=zh_CN.utf-8
"  总是显示状态栏
set laststatus=2
"  高亮显示当前行/列
set cursorline
set cursorcolumn
" 关闭自动折行
set nowrap
"  禁止生成临时文件
" set nobackup      " 取消备份文件 ~
" 取消交换文件.swp
set noswapfile
" 留存撤销历史
set undofile
"  保存历史操作条数
set history=2000 
" 设置临时文件地址
" set backupdir=~/.vim/.backup//  
set directory=~/.vim/.swp//
set undodir=~/.vim/.undo// 
" 命令自动补全
set wildmenu
" 错误不发出声音
set noerrorbells
" 最长行长度
set textwidth=80
" 根据右侧往左的列数自动换行
set wrapmargin=2
" 使光标距窗口上下6行
set scrolloff=6
" 自动缩进
set autoindent
" 智能缩进
set smartindent
" 缩进大小
set shiftwidth=2
set magic
" 显示特殊符号
set list
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_,extends:>,precedes:<
" 折叠相关
set foldenable
" set foldclose=all
" 退出插入模式指定类型的文件自动保存
au InsertLeave *.go,*.sh,*.java write

" 插件配置
if filereadable(expand("~/.vimrc.plugged"))
  source ~/.vimrc.plugged
endif

for file in split(glob('~/.vimrc.coc'), '\n')
  execute 'source' file
endfor
