" =============================================================================
" 基本配置
" =============================================================================

" 不要兼容vi，使用 Vim 增强功能
if &compatible
    set nocompatible
endif

" 启用语法高亮，提高代码可读性
if has('syntax')
    syntax enable
    syntax on
endif

" 文件类型检测和自动缩进，根据文件类型加载相应的插件和缩进规则
if has('autocmd')
    filetype plugin indent on
endif

" 文件在外部修改时自动重新加载，保持文件同步
set autoread
if has('autocmd')
    au FocusGained,BufEnter * checktime
endif

" 设置编码为UTF-8，支持多语言字符
if has('multi_byte')
    set encoding=utf-8
    set fileencoding=utf-8
    set fileencodings=ucs-bom,utf-8,gb18030,cp936,latin1
endif

" 设定命令行的行数为 1
set cmdheight=1

" 启动时不显示 捐赠提示
set shortmess=atl

" 显示绝对行号，方便定位代码
set number

" 设置相对行号（Vim 7.3+），便于快速跳转
if v:version >= 703
    set relativenumber
endif

" 智能缩进，根据语法结构自动缩进
set smartindent
" 自动换行缩进，保持上一行的缩进
set autoindent
" 软折行，在单词边界处换行而不是字符边界
set linebreak
" 禁止生成swap文件
set noswapfile
" 终端隐藏后不结束
set hidden
" 字符串搜索时忽略大小写
set ignorecase
" 智能大小写匹配（如果一个模式包含大写字母，则区分大小写）
" set smartcase  " Vim 7.3 中默认关闭，可根据需要启用

" 搜索时高亮显示被找到的文本
set hlsearch

" 实时搜索（输入时就开始搜索）
set incsearch 

" 打开正则表达式
set magic

" 关闭错误声音
set noerrorbells
set novisualbell

" 显示状态栏 (默认值为 1, 无法显示状态栏)  
set laststatus=2

" Adjust case in insert completion mode
set infercase

" 允许backspace和光标键跨越行边界  
set whichwrap+=<,>,h,l

" 历史命令记录数量，方便重复使用
set history=500
" 新窗口在下方打开，符合现代编辑器习惯
set splitbelow
" 将制表符转换为空格，保持代码格式一致
set expandtab
" 设置制表符宽度为4个空格
set tabstop=4
" 编辑时连续数量的空格看作一个制表符
set softtabstop=4
" 自动缩进的空格数
set shiftwidth=4
" 智能制表符处理，在行首插入缩进，其他位置插入制表符
set smarttab
" 缩进对齐到最近的缩进级别
set shiftround
" 折叠设置
if has('folding')
    set foldenable
    " 基于缩进的折叠
    " set foldmethod=indent
    set foldmethod=syntax
    " 默认打开所有缩进
    set foldlevel=99
endif

set nobackup
set nowritebackup

" coc (Vim 8+ 插件, 在 7.3 中不适用)
" set shortmess+=c
" set sessionoptions+=globals

" 文件在外部被修改过，重新读入（已配置，此处移除重复）
" set autoread  " 上方已设置，移除重复
" 自动写回
set autowrite
" 显示确认对话框
set confirm
"set noshowmode
set ttimeout
set timeoutlen=500
set ttimeoutlen=10
" 更新时间100ms 默认4000ms 写入swap的时间
set updatetime=100
" 允许使用鼠标, normal生效，a则是全模式生效
set mouse=v

" 增强模式中的命令行自动完成操作
set wildmenu
" 实现C程序的缩进
" set sw=4

" 设计(自动) 缩进使用4个空格
" set sw=4
" 关闭"Tab转空格"
" :set noexpandtab
" 在编辑过程中，在右下角显示光标位置的状态行
set ruler
" 输入搜索内容时就显示搜索结果（已配置，此处移除重复）
" set incsearch  " 上方已设置，移除重复
" 不设定的话在插入模式里无法使用退格键，delete和回车符等
set backspace=indent,eol,start
" 自动换行显示
set wrap
" 在被分割的窗口键显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\
set cindent " 设置C语言自动对齐

set winaltkeys=no
" 延迟绘制，提升性能
set lazyredraw

" 显示括号配对情况
set showmatch
set matchtime=2
" 文件换行符，默认使用unix换行符
"set ffs=unix,dos,mac
set ffs=unix
" 与系统共用剪切板
" 在某些系统上可能会出现vim打开时间长的问题
if has('clipboard')
    set clipboard+=unnamedplus
endif

if has('nvim') == 0 && has('patch-8.1.2020')
    set cursorlineopt=number cursorline
endif

if has('patch-8.1.1564')
    set signcolumn=yes
    " set signcolumn=number
else
    ""set signcolumn=yes
endif

" 定位到退出位置并移动到屏幕中央
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif | normal! zvzz
endif

set fenc=utf-8 

" 获取当前时间，精确到分，用于文件头和注释时间戳
function GetDateTime()
     return strftime("%Y-%m-%d %H:%M")
endfunction

" =============================================================================
" 插件管理配置 (Vim-Plug)
" =============================================================================
"Set mapleader
let mapleader = "\<space>"

" 检查 vim-plug 是否已安装
if !filereadable(expand('~/.vim/autoload/plug.vim'))
    echohl WarningMsg
    echo "警告：vim-plug 未安装！请先安装 vim-plug："
    echo "curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    echohl None
    finish
endif
call plug#begin('~/.vim/plugged')

" 【修改】: 严格区分 Vim 7.3、7.4+ 和 8.0+ 的插件列表
if v:version >= 800
    " --- 仅适用于 Vim 8.0+ 的现代插件 ---
    
    " 文件目录树
    Plug 'scrooloose/nerdtree'
    " NERDTree 在 Tab 间的同步
    Plug 'jistr/vim-nerdtree-tabs'
    
    " gruvbox 配色方案
    Plug 'morhetz/gruvbox'
    
    " 快速注释插件
    Plug 'scrooloose/nerdcommenter'
    
    " 漂亮的状态栏
    Plug 'vim-airline/vim-airline'
    " airline 状态栏主题
    Plug 'vim-airline/vim-airline-themes'
    
    " 代码结构/大纲视图 (现代版)
    Plug 'majutsushi/tagbar'
    
    " 最近打开的文件 (MRU)
    Plug 'yegappan/mru'
    
    " C/C++ 头文件/源文件 (.h/.c) 切换
    Plug 'vim-scripts/a.vim'
    
    " 模糊文件搜索 (现代版)
    Plug 'Yggdroot/LeaderF'
    
    " 异步语法/Linter检查 (需Vim 8.0+)
    Plug 'w0rp/ale'
    
    " C++ 语法高亮增强
    Plug 'octol/vim-cpp-enhanced-highlight'
    
    " 自动 ctags/tags 文件生成
    Plug 'ludovicchabant/vim-gutentags' 

    " fzf 模糊搜索核心
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    " fzf 的 Vim 集成
    Plug 'junegunn/fzf.vim'
    
    " 【修复】: 只有当 node 可执行时才加载 coc.nvim，修复 "node is not executable" 报错
    if executable('node')
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
    endif

elseif v:version >= 704
    " --- Vim 7.4+ ---
    Plug 'scrooloose/nerdtree'
    " NERDTree 在 Tab 间的同步
    Plug 'jistr/vim-nerdtree-tabs'
    
    " gruvbox 配色方案
    Plug 'morhetz/gruvbox'
    
    " 快速注释插件
    Plug 'scrooloose/nerdcommenter'
    
    " 漂亮的状态栏
    Plug 'vim-airline/vim-airline'
    " airline 状态栏主题
    Plug 'vim-airline/vim-airline-themes'
    
    " 代码结构/大纲视图 (现代版)
    Plug 'majutsushi/tagbar'
    
    " 最近打开的文件 (MRU)
    Plug 'yegappan/mru'
    
    " C/C++ 头文件/源文件 (.h/.c) 切换
    Plug 'vim-scripts/a.vim'
    
    if v:version > 704 || (v:version == 704 && has('patch330'))
        " 模糊文件搜索 (现代版)
        Plug 'Yggdroot/LeaderF'
    endif
    
    
    " C++ 语法高亮增强
    Plug 'octol/vim-cpp-enhanced-highlight'
    
    " 自动 ctags/tags 文件生成 (需 7.4+)
    Plug 'ludovicchabant/vim-gutentags' 

    if v:version > 704 || (v:version == 704 && has('patch383'))
        " fzf 模糊搜索核心
        Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
        " fzf 的 Vim 集成
        Plug 'junegunn/fzf.vim'
    endif
    
    " 【新增】现代 Snippets 引擎 (若您在 7.4+ 环境需要)
    " Plug 'SirVer/ultisnips'
    " Plug 'honza/vim-snippets'

else
    " --- 仅适用于 Vim 7.3 的兼容插件 (带版本锁定) ---
    
    " 文件目录树 (【锁定】 4.2.0 是 7.3 兼容的最后一个版本)
    Plug 'scrooloose/nerdtree', { 'tag': '4.2.0' }
    " 'jistr/vim-nerdtree-tabs' -> 禁用, 可能不兼容 nerdtree 4.2.0

    " gruvbox 配色方案
    Plug 'morhetz/gruvbox'
    
    " 快速注释插件 (兼容)
    Plug 'scrooloose/nerdcommenter' 
    
    " 轻量级状态栏 (airline的7.3替代品)
    Plug 'itchyny/lightline.vim' 
    
    " 代码结构/大纲视图 (tagbar的7.3替代品, 经典存档)
    Plug 'vim-scripts/taglist.vim'
    
    " 最近打开的文件 (MRU) (【修复】移除无效 tag)
    Plug 'yegappan/mru'
    
    " C/C++ 头文件/源文件 (.h/.c) 切换 (兼容, 经典存档)
    Plug 'vim-scripts/a.vim'
    
    " 模糊文件搜索 (LeaderF的7.3替代品, 【锁定】 1.79 明确支持 7.0+)
    Plug 'ctrlpvim/ctrlp.vim', { 'tag': '1.79' }
    
    " 同步语法检查 (ale的7.3替代品, 【锁定】 3.9.0 是 2017 年稳定版, 需 7.0+)
    Plug 'vim-syntastic/syntastic', { 'tag': '3.9.0' }
    
    " C++ 语法高亮增强 (兼容, 已存档无需锁定)
    Plug 'octol/vim-cpp-enhanced-highlight'
    
    " C/C++ 语法补全 (基于ctags, 经典存档, Vim 7.3 时代)
    Plug 'vim-scripts/omnicppcomplete'

    " 【新增】代码片段 (Snippets) 引擎 (Vim 7.3 经典组合, 均已存档)
    Plug 'MarcWeber/vim-addon-mw-utils' " snipmate 依赖
    Plug 'tomtom/tlib_vim'             " snipmate 依赖
    Plug 'garbas/vim-snipmate'         " snipmate 核心
    
    " 【新增】代码片段库 (【修复】移除无效 tag)
    Plug 'honza/vim-snippets'

endif

call plug#end()

" =============================================================================
" 配色方案和外观设置
" =============================================================================

" 设定配色方案（确保在插件加载后设置）
if has('gui_running')
    " GUI 模式下的设置
    try
        colorscheme gruvbox
        set background=dark
    catch
        echohl WarningMsg
        echo "警告：gruvbox 配色方案加载失败，使用默认配色"
        echohl None
    endtry
else
    " 终端模式下的设置
    try
        colorscheme gruvbox
        set background=dark
    catch
        echohl WarningMsg
        echo "警告：终端配色方案加载失败，使用默认配色"
        echohl None
    endtry
endif

" =============================================================================
" Cscope 缓存目录配置 - Vim 7.3 优化版
" =============================================================================

" 定义 Cscope 缓存目录的基础路径，避免污染项目目录
let s:cscope_cache_dir = expand('~/.cache/vim/cscope') 

" 确保基础缓存目录存在（静默创建，不显示信息）
if !isdirectory(s:cscope_cache_dir)
    silent! call mkdir(s:cscope_cache_dir, 'p')
endif

" 函数：获取当前项目对应的 Cscope 缓存目录路径
" 优化：减少变量使用，提高执行效率
function! <SID>GetProjectCscopeDir()
    " 使用当前目录名作为项目标识符
    let l:project_name = fnamemodify(getcwd(), ':t')
    " 处理根目录情况
    if empty(l:project_name)
        let l:project_name = 'root'
    endif
    let l:project_cscope_dir = s:cscope_cache_dir . '/' . l:project_name
    " 静默创建项目缓存目录
    if !isdirectory(l:project_cscope_dir)
        silent! call mkdir(l:project_cscope_dir, 'p')
    endif
    return l:project_cscope_dir
endfunction

" =============================================================================
" 快捷键设置
" =============================================================================

" 函数：显示所有快捷键帮助信息
" 使用临时窗口显示格式化的快捷键列表，便于查看和学习
function! <SID>ShowKeybindings()
    " 1. 打开一个新的临时窗口
    new
    " 设置非文件属性，避免保存提示
    setlocal buftype=nofile bufhidden=hide noswapfile
    setlocal filetype=markdown " 使用 markdown 语法高亮

    " 2. 定义帮助文本
    let s:help_lines = [
	\ '# Vim 快捷键助手 (Vim 7.3/7.4/8.0+ 兼容模式)',
        \ '',
        \ '## 核心导航 (Cscope & Vim 内置)',
        \ '---',
        \ '` <leader>fg ` : **[Go]** 查找函数/宏/变量 **定义** (cscope)',
        \ '` <leader>fc ` : **[Call]** 查找此函数被 **调用** 的地方 (cscope)',
        \ '` <leader>fs ` : **[Symbol]** 查找 C 语言 **符号** (cscope)',
        \ '` <C-O> ` : **[Back]** **回退** 到上一个跳转位置',
        \ '` <C-I> ` (或 `Tab`) : **[Forward]** **前进** 到下一个跳转位置',
        \ '',
        \ '## 项目搜索 (fzf / LeaderF / CtrlP)',
        \ '---',
        \ '` <c-p> ` : **[Project]** 模糊 **查找文件** (LeaderF / CtrlP)',
        \ '` <leader>f ` : **[File]** 模糊 **查找文件** (fzf / CtrlP)',
        \ '` <leader>b ` : 查找已打开的 **Buffers** (fzf / CtrlP)',
        \ '` <leader>ag ` : **[Grep]** 在项目中 **搜索内容** (Ag / Grep)',
        \ '',
        \ '## 窗口与 Tab 管理',
        \ '---',
        \ '` <leader>t ` : **[Tree]** 切换 **NERDTree** 文件树',
        \ '` <leader>1-9 ` : 切换到第 1-9 个 **Tab**',
        \ '` <leader>q ` : 关闭当前 **Buffer** 或 **Tab**',
        \ '` <F8> ` : **[Tags]** 切换 **Tagbar/Taglist** (函数/变量大纲)',
        \ '` <F2> ` : **[MRU]** 显示 **最近打开的文件**',
        \ '` <F10> ` : **[Alternate]** .c 和 .h 文件间切换 (a.vim)',
        \ '` <c-h>/<c-j>/<c-k>/<c-l> ` : 在窗口间跳转',
        \ '',
        \ '## 数据库生成 (手动)',
        \ '---',
        \ '` <leader>cf ` : *[Action]* 创建 cscope.files 列表',
        \ '` <leader>sf ` : *[Action]* 生成 cscope.out **和** tags 文件 (重要！)',
        \ '',
        \ '## 编辑与代码生成',
        \ '---',
        \ '` <Tab> ` (插入) : 触发 **代码片段** (snipmate/ultisnips)',
        \ '` <F7> ` (插入) : 触发 **代码补全** (omnicppcomplete/coc)',
        \ '` <F9> ` : **[Comment]** 切换/添加注释 (NERDCommenter)',
        \ '` <leader>uc ` : **[Uncomment]** 取消注释 (NERDCommenter)',
        \ '` <F4> ` : *[Action]* 添加/更新 **文件头** 版权信息',
        \ '` <F5> ` : *[Action]* 插入 **函数** 说明模板',
        \ '` <F6> ` : *[Action]* 插入 `#if 0` 注释块',
        \ '` <C-F6> ` : *[Action]* 插入 `/* Eric.he Start/End */` 块',
        \ '` = ` (等于号) : 交换当前行和下一行',
        \ '` - ` (减号) : 交换当前行和上一行',
        \ '',
        \ '## 语法检查 (ALE / Syntastic)',
        \ '---',
        \ '` <leader>s ` : **[Syntax]** 切换语法检查',
        \ '` <leader>d ` : **[Detail]** 显示错误/警告详情',
        \ '` sp ` : 跳转到 **上一个** 错误',
        \ '` sn ` : 跳转到 **下一个** 错误',
        \ '',
        \ '按 `q` 关闭此窗口',
        \ ]
    
    " 3. 将帮助文本写入窗口 (此时 buffer 仍可写)
    call append(0, s:help_lines)

    " 4. 【修复 W10 错误】: 在写入内容之后，再将 buffer 设为只读
    setlocal readonly
    setlocal nomodified " 标记为未修改，避免退出时提示
    
    " 5. 映射 q 键关闭
    nnoremap <buffer> q :q<CR>
endfunction

" 映射 <leader>h (空格+h) 来显示快捷键帮助
nnoremap <leader>h :call <SID>ShowKeybindings()<CR>

" =============================================================================
" 基础按键映射
" =============================================================================
noremap <c-h> <C-w>h
noremap <c-j> <C-w>j
noremap <c-k> <C-w>k
noremap <c-l> <C-w>l

" 括号自动补全
""inoremap [ []<Esc>i
""inoremap ] []<Esc>i
""inoremap ( ()<Esc>i
""inoremap ) ()<Esc>i
""inoremap { {<CR>}<Esc>O
""inoremap } {<CR>}<Esc>O
""inoremap < <><Esc>i
""inoremap " ""<Esc>i
""inoremap ' ''<Esc>i

" 光标移动
" 插入模式按键映射上下左右
inoremap <C-L> <Esc>la
inoremap <C-g> <Esc>ha
inoremap <C-J> <Esc>ja
inoremap <C-K> <Esc>ka

""map <leader>= dd2kp
""map <leader>- ddp
noremap = dd2kp
noremap - ddp

" 编辑完成跳出括号
"imap ,, <Esc>la
"imap .. <Esc>2la
inoremap ,, <Esc>la
inoremap .. <Esc>2la

" 复制到末尾
nnoremap Y y$

" =============================================================================
" NERDTree 文件树配置 - Vim 7.3 优化版
" =============================================================================

" NERDTree配置 (4.2.0 版本兼容)
let NERDTreeMinimalUI = 1 " 最小化显示，不显示问号
let NERDTreeDirArrows = 1
let NERDChristmasTree = 1
let NERDTreeMouseMode=2
let NERDTreeShowBookmarks=1
let NERDTreeShowFiles=1       "显示文件
let NERDTreeShowLineNumbers=1 "显示行号
let NERDTreeHightCursorline=1 "高亮当前文件
let NERDTreeShowHidden=1      "显示隐藏文件
let NERDTreeWinSize=31        "窗口宽度
let NERDTreeWinPos='right'

" 如果使用vim-plug的话，加上这一句可以避免光标在nerdtree
" 中的时候进行插件升级而导致nerdtree崩溃
let g:plug_window = 'noautocmd vertical topleft new'
" 在nerdtree中删除文件之后，自动删除vim中相应的buffer
let NERDTreeAutoDeleteBuffer = 1
" 进入目录自动将workspace更改为此目录
let g:NERDTreeChDirMode = 2

function! NERDTreeYankCurrentNode(node)
    " let n = g:NERDTreeFileNode.GetSelected()
    let l:s = a:node.GetSelected()
    if l:s != {}
        call setreg('"', l:s.path.str())
    endif
endfunction

let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

" 水平或者垂直窗口打开
let g:NERDTreeMapOpenSplit = "w"
let g:NERDTreeMapOpenVSplit = "W"
" 展开与关闭节点或者打开文件
let g:NERDTreeMapActivateNode = 'l'
" 【新增】将 l 和 Enter 键映射为在新的后台 Tab 中打开文件
let g:NERDTreeMapOpenInTab = 'l'
let g:NERDTreeMapOpenInTabSilent = '<CR>'
let g:NERDTreeMapOpenRecursively = 'L'
let g:NERDTreeMapCloseDir = 'h'
" 显示隐藏文件
let g:NERDTreeMapToggleHidden = '.'
" 回到上一级目录
let g:NERDTreeMapUpdirKeepOpen = '<backspace>'
" 在新的tab打开
""let g:NERDTreeMapOpenInTab = 't'
" 在节点之间跳转，无效
let g:NERDTreeMapJumpNextSibling = 'J'
let g:NERDTreeMapJumpPrevSibling = 'K'

augroup vim_nerdtree_group
    autocmd!
    " 只有一个窗口和nerdtree的时候，退出窗口即退出vim而不保留nerdtree
    autocmd BUFENTER * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

    " 避免在nerdtree中打开文件
    autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif

augroup END

" =============================================================================
" 状态栏配置 - Vim 7.3 使用 lightline
" =============================================================================

if v:version >= 704
    " --- airline (Vim 7.4+) ---
    " 设置状态栏
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#left_alt_sep = '|'
    let g:airline#extensions#tabline#buffer_nr_show = 1
    let g:airline#extensions#tabline#formatter = 'default'
    ""let g:airline_theme='ayu_dark'  " 主题
    let g:airline#extensions#keymap#enabled = 1
    let g:airline#extensions#tabline#buffer_idx_mode = 1
    let g:airline#extensions#tabline#buffer_idx_format = {
           \ '0': '0 ',
           \ '1': '1 ',
           \ '2': '2 ',
           \ '3': '3 ',
           \ '4': '4 ',
           \ '5': '5 ',
           \ '6': '6 ',
           \ '7': '7 ',
           \ '8': '8 ',
           \ '9': '9 '
           \ }
    " 设置切换tab的快捷键 <\> + <-> 切换到前一个 tab
    "nmap <leader>- <Plug>AirlineSelectPrevTab
    " 设置切换tab的快捷键 <\> + <+> 切换到后一个 tab
    "nmap <leader>+ <Plug>AirlineSelectNextTab
    " 设置切换tab的快捷键 <\> + <q> 退出当前的 tab
    nmap <leader>q :bd<cr>
    " 修改了一些个人不喜欢的字符
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    let g:airline_symbols.linenr = "CL" " current line
    let g:airline_symbols.whitespace = '|'
    let g:airline_symbols.maxlinenr = 'Ml' "maxline
    let g:airline_symbols.branch = 'BR'
    let g:airline_symbols.readonly = "RO"
    let g:airline_symbols.dirty = "DT"
    let g:airline_symbols.crypt = "CR"

    " 显示窗口号
    function! WindowNumber(...)
        let builder = a:1
        let context = a:2
        call builder.add_section('airline_b', '%{tabpagewinnr(tabpagenr())}')
        return 0
    endfunction

    ""call airlineadd_statusline_func('WindowNumber')
    ""call airline#add_inactive_statusline_func('WindowNumber')

    " 关闭airline的coc集成
    let g:airline#extensions#coc#enabled = 0
else
    " --- lightline (Vim 7.3) ---
    " 使用简单的 lightline 配置，避免颜色问题
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'readonly', 'filename', 'modified' ] ],
    \   'right': [ [ 'lineinfo' ],
    \              [ 'percent' ],
    \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
    \ },
    \ 'inactive': {
    \   'left': [ [ 'filename' ] ],
    \   'right': [ [ 'lineinfo' ],
    \              [ 'percent' ] ]
    \ },
    \ 'component': {
    \   'readonly': '%{&readonly?"RO":""}',
    \   'modified': '%{&modified?"+":""}',
    \   'fileformat': '%{&fileformat}',
    \   'fileencoding': '%{&fileencoding?&fileencoding:&encoding}',
    \   'filetype': '%{&filetype!=?""?&filetype:"no ft"}',
    \   'lineinfo': '%3l:%-2v',
    \   'percent': '%3p%%'
    \ },
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '|', 'right': '|' }
    \ }

" <leader>q: 退出当前tab
nmap <leader>q :tabclose<CR>

endif

" =============================================================================
" 插件快捷键延迟加载 - Vim 7.3 优化版
" =============================================================================

" 修改：将所有依赖插件命令的快捷键映射延迟到 VimEnter 事件
" 这样做可以确保所有插件都已完全加载
augroup vim_plugin_key_mappings
    autocmd!
    " 在 Vim 完全启动后运行 s:SetupPluginMappings 函数
    autocmd VimEnter * call <SID>SetupPluginMappings()
augroup END

" 定义用于设置插件快捷键的函数
" 优化：减少条件判断，提高加载速度
function! <SID>SetupPluginMappings()
    " --- Tab切换快捷键 (所有版本通用) ---
    " <leader>1-9: 切换到第1-9个tab
    nmap <leader>1 1gt
    nmap <leader>2 2gt
    nmap <leader>3 3gt
    nmap <leader>4 4gt
    nmap <leader>5 5gt
    nmap <leader>6 6gt
    nmap <leader>7 7gt
    nmap <leader>8 8gt
    nmap <leader>9 9gt
    
    " --- (1) NERDTree (<leader>t) ---
    " 检查 :NERDTreeToggle 是否存在
    if exists(':NERDTreeToggle')
        nnoremap <leader>t :NERDTreeToggle<CR>
    else
        nnoremap <leader>t :echoe "NERDTree 插件未加载，请运行 :PlugInstall"<CR>
    endif

    " --- (2) Tagbar / Taglist (F8) 和相关快捷键 ---
    if v:version >= 704
        " --- Tagbar (Vim 7.4+) ---
        if exists(':TagbarToggle')
            " 移除 ctags 硬编码路径，让插件自动在 PATH 中查找
            " let g:tagbar_ctags_bin='/usr/bin/ctags'
            nnoremap <F8> :TagbarToggle<CR>
            let g:tagbar_width = 35
            let g:tagbar_left = 1 " 1: 在右侧打开
            let g:tagbar_compact = 1
        else
            " 如果 Tagbar 已在 Plug 中定义但命令不存在，则映射错误提示
            nnoremap <F8> :echoe "Tagbar 未能正确加载。请运行 :PlugInstall 并检查 :messages。"<CR>
        endif
    else
        " --- Taglist (Vim 7.3) ---
        " 移除 ctags 硬编码路径，让插件自动在 PATH 中查找
        let Tlist_Ctags_Cmd = 'ctags'
        
        " 检查 :TlistToggle 是否存在
        if exists(':TlistToggle')
            nnoremap <F8> :TlistToggle<CR>          " F8 键映射
            nnoremap <c-f> :Tlist<CR>               " 函数搜索
            
            " Taglist 配置变量
            let Tlist_WinWidth = 35               " 设置窗口宽度
            let Tlist_Use_Left_Window = 1
            let Tlist_Show_One_File = 1
            let Tlist_Exit_OnlyWindow = 1
            let Tlist_Use_SingleClick = 1
        else
            nnoremap <F8> :echoe "Taglist 插件未加载，请运行 :PlugInstall"<CR>
            nnoremap <c-f> :echoe "Taglist 插件未加载，请运行 :PlugInstall"<CR>
        endif

    endif " 结束 v:version 检查 (F8)

    " --- (3) 模糊搜索快捷键 (fzf / LeaderF / CtrlP) ---
    " 逻辑：根据Vim版本和插件加载情况，动态设置快捷键
    if (v:version >= 800 || (v:version >= 704 && has('patch383'))) && exists(':Files') " fzf (Vim 8+ or modern 7.4)
        nnoremap <silent> <leader>f :Files<CR>
        nnoremap <silent> <leader>b :Buffers<CR>
        if exists(':Ag')
            nnoremap <silent> <leader>ag :Ag <C-R><C-W><CR>
        else
            nnoremap <silent> <leader>ag :grep <C-R><C-W><CR>:cw<CR> " Fallback
        endif
        " <c-p> is handled by LeaderF's g:Lf_ShortcutF, which is also loaded
    elseif v:version >= 704 && exists(':LeaderfFile') " LeaderF (Vim 7.4+)
        " <c-p> is handled by LeaderF's g:Lf_ShortcutF
        nnoremap <leader>lf :LeaderfFile<CR>
        nnoremap <silent> <leader>ag :grep <C-R><C-W><CR>:cw<CR>
    elseif v:version < 704 && exists(':CtrlP') " CtrlP (Vim 7.3)
        nnoremap <c-p> :CtrlP<CR>
        nnoremap <leader>f :CtrlP<CR>
        nnoremap <leader>b :CtrlPBuffer<CR>
        nnoremap <silent> <leader>ag :grep <C-R><C-W><CR>:cw<CR>
    else
        " Fallback error messages if no fuzzy finder is correctly loaded
        nnoremap <c-p>       :echoe "模糊搜索插件 (fzf/LeaderF/CtrlP) 未加载!"<CR>
        nnoremap <leader>f   :echoe "模糊搜索插件 (fzf/LeaderF/CtrlP) 未加载!"<CR>
        nnoremap <leader>b   :echoe "模糊搜索插件 (fzf/LeaderF/CtrlP) 未加载!"<CR>
        nnoremap <leader>ag  :echoe "内容搜索工具 (Ag/grep) 未配置!"<CR>
    endif
endfunction

" =============================================================================
" MRU (最近打开的文件) 配置 - Vim 7.3 优化版
" =============================================================================

" 设置默认记录的打开文件数量，默认100
let MRU_Max_Entries = 100
" 设置默认在本窗口打开最近文件列表，而不是新的窗口
" let MRU_Use_Current_Window = 1
" 把记录保存在哪 默认$HOME/.vim_mru_files
" let MRU_File='$HOME/~/.vim/.vim_mru_files
map <expr> <F2> bufloaded("__MRU_Files__")?"q":":MRU\<cr>"

" =============================================================================
" .c 和.h 文件跳转配置 - Vim 7.3 优化版
" =============================================================================

nnoremap <F10> :AV<CR>

" =============================================================================
" Cscope 配置 - Vim 7.3 优化版
" =============================================================================

" 检查 cscope 是否可用
if has("cscope")
    " 检查 cscope 程序是否存在
    if executable('/usr/bin/cscope')
        set csprg=/usr/bin/cscope
    elseif executable('cscope')
        set csprg=cscope
    else
        " 仅在出错时显示警告，不影响启动速度
        echohl WarningMsg
        echo "警告：未找到 cscope 程序，Cscope 功能将不可用"
        echohl None
    endif
    
    " Cscope 基础设置
    set csto=1      " 先搜索tag，再搜索cscope
    set cst         " 使用cscope
    set nocsverb    " 不显示添加数据库时的消息
    
    " 优化：加载缓存中的 cscope 数据库
    let s:proj_cscope_dir = <SID>GetProjectCscopeDir()
    let s:cached_cscope_out = s:proj_cscope_dir . '/cscope.out'
    let s:project_root = getcwd() " 当前目录作为项目根目录 (用于前缀路径)
    
    if filereadable(s:cached_cscope_out)
        " 静默加载缓存中的 cscope.out
        silent! execute 'cs add ' . fnameescape(s:cached_cscope_out) . ' ' . fnameescape(s:project_root)
        " 同时加载对应的 tags 文件
        let s:cached_tags = s:proj_cscope_dir . '/tags'
        if filereadable(s:cached_tags)
            silent! execute 'set tags+=' . fnameescape(s:cached_tags)
        endif
    endif
    
    set csverb      " 显示添加数据库时的消息
else
    " 仅在出错时显示警告，不影响启动速度
    echo "警告：当前 Vim 不支持 cscope"
endif

" =============================================================================
" Cscope 快捷键配置
" =============================================================================

" 快捷键生成 cscope.files 文件列表
nnoremap <leader>cf :call <SID>GenerateCscopeFiles()<CR>

" 快捷键生成并加载 cscope 和 tags 数据库
nnoremap <leader>sf :call <SID>GenerateAndLoadCscopeDB()<CR>

" 全局数据库生成快捷键（修复：使用缓存目录并自动加载）
nnoremap <leader><F11> :call <SID>GenerateAndLoadCscopeDBRecursive()<CR>

" 生成 cscope.files 的函数
function! <SID>GenerateCscopeFiles()
    let l:proj_dir = <SID>GetProjectCscopeDir()
    let l:files_list = l:proj_dir . '/cscope.files'
    
    echo "正在生成文件列表到: " . l:files_list
    
    " 使用 find 命令生成文件列表 (修复：使用 . 代替 `pwd` 提高兼容性)
    if executable('find')
        let l:cmd = '!find . -name "*.h" -o -name "*.c" -o -name "*.cpp" -o -name "*.m" -o -name "*.mm" -o -name "*.java" -o -name "*.py" > ' . shellescape(l:files_list)
        execute l:cmd
        echo "文件列表已生成: " . l:files_list
    else
        echohl ErrorMsg
        echo "错误：未找到 find 命令"
        echohl None
    endif
endfunction

" 生成并加载 cscope 和 tags 数据库的函数
function! <SID>GenerateAndLoadCscopeDB()
    let l:proj_dir = <SID>GetProjectCscopeDir()
    let l:files_list = l:proj_dir . '/cscope.files'
    let l:cscope_out = l:proj_dir . '/cscope.out'
    let l:tags_file = l:proj_dir . '/tags'
    let l:project_root = getcwd()
    
    " 检查文件列表是否存在
    if !filereadable(l:files_list)
        echohl WarningMsg
        echo "警告：文件列表不存在，请先运行 <leader>cf 生成文件列表"
        echohl None
        return
    endif
    
    echo "正在生成数据库到: " . l:proj_dir
    
    " 检查 cscope 程序
    if !executable('cscope')
        echohl ErrorMsg
        echo "错误：未找到 cscope 程序"
        echohl None
        return
    endif
    
    " 生成 cscope 数据库
    let l:cmd = '!cscope -bkq -i ' . shellescape(l:files_list) . ' -f ' . shellescape(l:cscope_out)
    execute l:cmd
    
    " 检查 ctags 程序
    if executable('ctags')
        " 生成 tags 文件
        let l:cmd = '!ctags -L ' . shellescape(l:files_list) . ' -o ' . shellescape(l:tags_file)
        execute l:cmd
    else
        echohl WarningMsg
        echo "警告：未找到 ctags 程序，跳过 tags 生成"
        echohl None
    endif
    
    " 加载数据库
    if filereadable(l:cscope_out)
        cs reset  " 先重置现有连接
        execute 'cs add ' . fnameescape(l:cscope_out) . ' ' . fnameescape(l:project_root)
        echo "已加载 cscope 数据库: " . l:cscope_out
    endif
    
    if filereadable(l:tags_file)
        execute 'set tags=' . fnameescape(l:tags_file)
        echo "已加载 tags 文件: " . l:tags_file
    endif
    
    redraw!  " 重绘屏幕清除中间消息
    echo "数据库生成并加载完成！"
endfunction

" 新增：递归生成并加载 cscope 和 tags 数据库的函数
function! <SID>GenerateAndLoadCscopeDBRecursive()
    let l:proj_dir = <SID>GetProjectCscopeDir()
    let l:cscope_out = l:proj_dir . '/cscope.out'
    let l:tags_file = l:proj_dir . '/tags'
    let l:project_root = getcwd()

    echo "正在递归生成数据库到: " . l:proj_dir

    " 检查 cscope 程序
    if !executable('cscope')
        echohl ErrorMsg
        echo "错误：未找到 cscope 程序。在 Ubuntu/Debian 上, 请尝试运行 'sudo apt-get install cscope' 进行安装。"
        echohl None
        return
    endif

    " 递归生成 cscope 数据库
    " 【修复】: 使用 system() 替代 '!' 来执行外部命令, 以捕获错误并防止屏幕闪烁
    let l:cscope_cmd = 'cscope -Rbq -f ' . shellescape(l:cscope_out)
    let l:cscope_output = system(l:cscope_cmd)
    
    " 检查命令执行是否出错
    if v:shell_error
        echohl ErrorMsg
        echo "Cscope 命令执行失败！"
        echo "命令: " . l:cscope_cmd
        echo "错误码: " . v:shell_error
        echo "输出: " . l:cscope_output
        echohl None
        return
    endif

    " 检查 ctags 程序
    if executable('ctags')
        " 递归生成 tags 文件
        let l:ctags_cmd = 'ctags -R -o ' . shellescape(l:tags_file)
        let l:ctags_output = system(l:ctags_cmd)
        if v:shell_error
            echohl WarningMsg " 使用警告而不是错误, 因为 cscope 可能已成功
            echo "ctags 命令执行失败！"
            echo "命令: " . l:ctags_cmd
            echo "错误码: " . v:shell_error
            echo "输出: " . l:ctags_output
            echohl None
        endif
    else
        echohl WarningMsg
        echo "警告：未找到 ctags 程序, 跳过 tags 生成。在 Ubuntu/Debian 上, 请尝试运行 'sudo apt-get install exuberant-ctags'。"
        echohl None
    endif

    " 加载数据库
    if filereadable(l:cscope_out)
        cs reset  " 先重置现有连接
        execute 'cs add ' . fnameescape(l:cscope_out) . ' ' . fnameescape(l:project_root)
        echo "已加载 cscope 数据库: " . l:cscope_out
    endif

    if filereadable(l:tags_file)
        execute 'set tags=' . fnameescape(l:tags_file)
        echo "已加载 tags 文件: " . l:tags_file
    endif

    redraw!  " 重绘屏幕清除中间消息
    echo "数据库生成并加载完成！"
endfunction

" Cscope 快捷键映射
" s: 查找C语言符号出现的地方
nnoremap <leader>fs :cs find s <C-R>=expand("<cword>")<CR>

" g: 查找函数、宏、枚举等定义的位置
nnoremap <leader>fg :cs find g <C-R>=expand("<cword>")<CR>

" t: 查找指定的字符串出现的地方
nnoremap <leader>ft :cs find t <C-R>=expand("<cword>")<CR>

" e: egrep模式查找,相当于egrep功能
nnoremap <leader>fe :cs find e <C-R>=expand("<cword>")<CR>

" f: 查找文件名,相当于lookupfile
nnoremap <leader>ff :cs find f <C-R>=expand("<cfile>")<CR>

" i: 查找当前文件名出现过的地方
nnoremap <leader>fi :cs find i <C-R>=expand("<cfile>")<CR>

" c: 查找函数被调用的地方
nnoremap <leader>fc :cs find c <C-R>=expand("<cword>")<CR>

" d: 查找当前函数调用的函数
nnoremap <leader>fd :cs find d <C-R>=expand("<cword>")<CR>

" =============================================================================
" NERDCommenter 配置 
" =============================================================================

let g:NERDSpaceDelims            = 1      " 在注释符号后加一个空格
let g:NERDCompactSexyComs        = 1      " 紧凑排布多行注释
let g:NERDDefaultAlign           = 'left' " 逐行注释左对齐
let g:NERDAltDelims_java         = 1      " JAVA 语言使用默认的注释符号
let g:NERDCustomDelimiters       = {'c': {'left': '/*', 'right': '*/'}, 'html': { 'left': '<!-- ', 'right': '-->'}} " 注释符号
let g:NERDCommentEmptyLines      = 1      " 允许空行注释
let g:NERDTrimTrailingWhitespace = 1      " 取消注释时删除行尾空格
let g:NERDToggleCheckAllLines    = 1      " 检查选中的行操作是否成功

""快捷键
map <F9> <plug>NERDCommenterSexy         " 选中注释
map <leader>uc <plug>NERDCommenterUncomment  " 选中取消注释

" =============================================================================
" 语法检查配置 - Vim 7.3 使用 syntastic
" =============================================================================

if v:version >= 800
    " --- ale (Vim 8.0+) ---
let g:ale_set_highlights = 0
"自定义error和warning图标
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
"在vim自带的状态栏中整合ale
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"打开文件时进行检查
let g:ale_lint_on_enter = 1

"普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)
"<Leader>s触发/关闭语法检查
nmap <leader>s :ALEToggle<CR>
"<Leader>d查看错误或警告的详细信息
nmap <leader>d :ALEDetail<CR>
"对python使用pyflakes进行语法检查
"\   'python': ['pylint'],
" let g:ale_linters = {
" \   'python': ['pyflakes'],
" \}
" }}}

"使用clang对c和c++进行语法检查，对python使用pylint进行语法检查
    let g:ale_linters = {
    \   'c++': ['clang'],
    \   'c': ['clang'],
    \}
else
    " --- syntastic (Vim 7.3) ---
    " 新增：配置 7.3 替代品 syntastic
    " 调试信息：syntastic 状态行函数检查
    if exists('*SyntasticStatuslineFlag')
        set statusline+=%#warningmsg#
        set statusline+=%{SyntasticStatuslineFlag()}
        set statusline+=%*
    endif
    
    " Syntastic 基础配置
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 0  " 不自动打开错误列表
    let g:syntastic_check_on_open = 1     " 打开文件时检查
    let g:syntastic_check_on_wq = 0       " 退出时不检查
    
    " 设置 C/C++ 检查器
    let g:syntastic_c_checkers = ['clang']
    let g:syntastic_cpp_checkers = ['clang']
    
    " 快捷键映射 - 与原 ale 快捷键保持一致
    " sp/sn: 在错误间跳转，使用 silent! 避免无错误时的错误提示
    nmap sp :silent! lprev<CR>
    nmap sn :silent! lnext<CR>
    " <leader>s: 触发/关闭语法检查
    nmap <leader>s :SyntasticToggleMode<CR>
    " <leader>d: 查看错误详情
    nmap <leader>d :Errors<CR>
endif

" =============================================================================
" 模糊搜索配置 - Vim 7.3 使用 CtrlP
" =============================================================================

if v:version > 704 || (v:version == 704 && has('patch330'))
    "LeaderF 模糊文件查找配置
    let g:Lf_ShortcutF = '<c-p>' " 文件快速搜索
    " 函数,宏,变量快速搜索
    " noremap <c-f> :LeaderfTag<cr>
    " 修改：移除重复的快捷键映射，所有映射已移动到 VimEnter 自动命令中
    " noremap <c-f> :LeaderfFunction<cr>
    " noremap <leader>lf :LeaderfFile<cr>
    let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
    let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
    let g:Lf_WorkingDirectoryMode = 'Ac'
    let g:Lf_WindowHeight = 0.30
    let g:Lf_CacheDirectory = expand('~/.vim/cache')
    let g:Lf_ShowRelativePath = 0
    let g:Lf_HideHelp = 1
    let g:Lf_StlColorscheme = 'powerline'
    let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}
else
    """ --- ctrlp (Vim 7.3) ---
    " 新增：将 LeaderF 的 <c-p> 映射到 ctrlp
    " 注意：ctrlp 默认已映射 <c-p>，这里是为保持配置清晰
    " 新增：<c-f> (函数搜索) 在 7.3 上降级为 ctags 搜索
    " 新增：<leader>lf (文件搜索) 映射到 ctrlp
    " " (注：所有相关快捷键已移动到 VimEnter 自动命令中，以确保插件加载完毕)
endif

" =============================================================================
" C++ 语法高亮增强配置
" =============================================================================

" cpp-enhanced-highlight c/c++ 语法高亮配置
" 默认情况下，不突出显示类范围。启用设置
let g:cpp_class_scope_highlight = 1

" 默认情况下，成员变量突出显示为禁用状态。启用设置
let g:cpp_member_variable_highlight = 1

" 默认情况下，在声明中高亮显示类名。启用设置
let g:cpp_class_decl_highlight = 1

" POSIX功能的突出显示默认情况下处于禁用状态。启用设置
let g:cpp_posix_standard = 1

" 有两种突出显示模板功能的方法。要么
let g:cpp_experimental_simple_template_highlight = 1

" 在大多数情况下都可以使用，但是在大文件上可能会有点慢。替代设置
let g:cpp_experimental_template_highlight = 1

" 这是一个较快的实现，但是在某些极端情况下它不起作用。
" 注意：众所周知，C ++模板语法很难解析，因此不要指望此功能是完美的。
" 库概念的突出显示由
let g:cpp_concepts_highlight = 1

" 这将突出显示关键字的概念，要求以及标准库中的所有命名要求（例如DefaultConstructible）
" 可以通过以下方式禁用突出显示用户定义的功能
let g:cpp_no_function_highlight = 1

" =============================================================================
" 自动标签生成配置
" =============================================================================

if v:version >= 704
    " gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归 "
    let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']

    " 所生成的数据文件的名称 "
    let g:gutentags_ctags_tagfile = '.tags'

    " 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录 "
    let s:vim_tags = expand('~/.cache/tags')
    let g:gutentags_cache_dir = s:vim_tags
    " 检测 ~/.cache/tags 不存在就新建 "
    if !isdirectory(s:vim_tags)
       silent! call mkdir(s:vim_tags, 'p')
    endif

    " 配置 ctags 的参数 "
    let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
    let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
    let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
else
    " (Vim 7.3: 无 gutentags, 使用手动 <leader>sf 快捷键生成 ctags)
endif

" =============================================================================
" Omnicppcomplete 配置 - Vim 7.3 优化版
" =============================================================================

" 【激活】: 为 Vim 7.3 启用 omnicppcomplete
if v:version < 800
"-- omnicppcomplete setting --
" 按下F7自动补全代码，注意该映射语句后不能有其他字符，包括tab；否则按下F3会自动补全一些乱码
" imap <F7> <C-X><C-O>
inoremap <F7> <C-X><C-O>
"按下F8根据头文件内关键字补全
" 【说明】：imap <F8> 与 <F8> (Taglist) 功能重叠，建议注释
" imap <F8> <C-X><C-I>
" set tags+=... " 【移除】: 路径已通过 <leader>sf 手动设置
" 【修改】: 添加 'preview'
set completeopt=menu,menuone,preview " 关掉智能补全时的预览窗口
let OmniCpp_MayCompleteDot = 1 " autocomplete with .
let OmniCpp_MayCompleteArrow = 1 " autocomplete with ->
let OmniCpp_MayCompleteScope = 1 " autocomplete with ::
let OmniCpp_SelectFirstItem = 2 " select first item (but don't insert)
let OmniCpp_NamespaceSearch = 2 " search namespaces in this and included files
let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype in popup window
let OmniCpp_GlobalScopeSearch=1 " enable the global scope search
let OmniCpp_DisplayMode=1 " Class scope completion mode: always show all members
""let OmniCpp_DefaultNamespaces=["std"]
let OmniCpp_ShowScopeInAbbr=1 " show scope in abbreviation and remove the last column
let OmniCpp_ShowAccess=1
endif

""-----------------------------------------------------------------------------------------------------
""----------------------------------------------YouCompleteMe------------------------------------
" YouCompleteMe
"set runtimepath+=~/.vim/plugged/YouCompleteMe
"let g:ycm_collect_identifiers_from_tags_files = 1            " 开启 YCM 基于标签引擎
"let g:ycm_collect_identifiers_from_comments_and_strings = 1 " 注释与字符串中的内容也用于补全
"let g:syntastic_ignore_files=[".*\.py$"]
"let g:ycm_seed_identifiers_with_syntax = 1                  " 语法关键字补全
"let g:ycm_complete_in_comments = 1
"let g:ycm_confirm_extra_conf = 0
"let g:ycm_key_list_select_completion = ['<c-n>', '<Down>']  " 映射按键, 没有这个会拦截掉tab, 导致其他插件的tab不能用.
"let g:ycm_key_list_previous_completion = ['<c-p>', '<Up>']
"let g:ycm_complete_in_comments = 1                           " 在注释输入中也能补全
"let g:ycm_complete_in_strings = 1                            " 在字符串输入中也能补全
"let g:ycm_collect_identifiers_from_comments_and_strings = 1 " 注释和字符串中的文字也会被收入补全
""let g:ycm_global_ycm_extra_conf='~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
"let g:ycm_show_diagnostics_ui = 0                            " 禁用语法检查
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>" |             " 回车即选中当前项
"nnoremap <c-j> :YcmCompleter GoToDefinitionElseDeclaration<CR>|      " 跳转到定义处
"let g:ycm_min_num_of_chars_for_completion=2                  " 从第2个键入字符就开始罗列匹配项

""-----------------------------------------------------------------------------------------------------
""-----------------------------------------------fzf / ctrlp-----------------------------------
" 注意: 所有模糊搜索插件的快捷键已统一移至 SetupPluginMappings() 函数中，
" 以便根据 Vim 版本和插件加载情况进行统一处理。
" 
" if v:version > 704 || (v:version == 704 && has('patch383'))
" ...
" endif

" =============================================================================
" 文件头自动添加
" =============================================================================

" 自动为新文件添加版权信息（优化：减少 echo 调用）
autocmd BufNewFile *.[ch],*.hpp,*.cpp,Makefile,*.mk,*.sh exec "call AddTitle()"
function AddTitle()
    if &filetype=='sh'
        call append( 0, "\#!/bin/bash")
        call append( 1, "#")
        call append( 2, "#  COPYRIGHT NOTICE")
        call append( 3, "#  Copyright (C) 2022 Fibocom Electronics Corporation, Inc. All rights reserved")
        call append( 4, "#")
        call append( 5, "#  Author              :Eric.he<Eric.he@fibocom.com>")
        call append( 6, "#  File Name           :".expand("%:p:h")."\/".expand("%:t"))
        call append( 7, "#  Create Date         :".strftime("%Y/%m/%d %H:%M"))
        call append( 8, "#  Last Modified       :".strftime("%Y/%m/%d %H:%M"))
        call append( 9, "#  Description         :")
        call append(10, "#")
        call append(11, "")
    else
        call append( 0, "/*")
        call append( 1, "* COPYRIGHT NOTICE")
        call append( 2, "* Copyright (C) 2016 Fibocom Electronics Corporation, Inc. All rights reserved")
        call append( 3, "*")
        call append( 4, "* Author              :Eric.he<Eric.he@fibocom.com>")
        call append( 5, "* File Name           :".expand("%:p:h")."\/".expand("%:t"))
        call append( 6, "* Create Date         :".strftime("%Y/%m/%d %H:%M"))
        call append( 7, "* Last Modified       :".strftime("%Y/%m/%d %H:%M"))
        call append( 8, "* Description         :")
        call append( 9, "*/")
        call append(10, "")
    endif
    " 优化：减少不必要的提示信息
    " echohl WarningMsg | echo "Successful in adding the copyright." | echohl None
endfunction



" map <F4> :call TitleDet() <cr>
"更新最近修改时间和文件名
function UpdateTitle()
    normal m'
    execute '/* Last Modified/s@:.*$@\=strftime(":%Y-%m-%d %H:%M")@'
    normal ''
    normal mk
    execute '/* File Name/s@:.*$@=""."expand("%:p:h")."\\"."expand("%:t")@'
    execute "noh"
    normal 'k
    " 优化：减少不必要的提示信息
    " echohl WarningMsg | echo "Successful in updating the copyright." | echohl None
endfunction

" 判断前10行代码里面，是否有COPYRIGHT NOTICE这个单词，
" 如果没有的话，代表没有添加过作者信息，需要新添加；
" 如果有的话，那么只需要更新即可
function TitleDet()
    let n = 1
    while n < 10
        let line = getline(n)
        if line =~ '^\*\s*\S*Last\sModified\S*.*$'
            call UpdateTitle()
            return
        endif
        let n = n + 1
    endwhile
    call AddTitle()
endfunction

" =============================================================================
" 文件头设置函数
" =============================================================================

" 定义函数SetTitle，自动插入文件头
" 加入注释
" 加入shell,Makefile注释
func SetTitle()
        if &filetype == 'make'
                call setline(1,"")
                call setline(2,"")
                call TitleDet()

        elseif &filetype == 'sh'
                call setline(1,"#!/bin/bash")  " 当以sh结尾的文件时，自动添加解释器
                call setline(2,"")
                call TitleDet()

        else
            call TitleDet()
            if expand("%:e") == 'hpp'
                    call append(10, "#ifndef _".toupper(expand("%:t:r"))."_H")
                    call append(11, "#define _".toupper(expand("%:t:r"))."_H")
                    call append(12, "")
                    call append(13, "#ifdef __cplusplus")
                    call append(14, "extern \"C\" {")
                    call append(15, "#endif")
                    call append(16, "")
                    call append(17, "")
                    call append(18, "#ifdef __cplusplus")
                    call append(19, "}")
                    call append(20, "#endif")
                    call append(21, "")
                    call append(22, "#endif // _".toupper(expand("%:t:r"))."_H")
                    normal G
                    normal o
                    normal k
            elseif expand("%:e") == 'h'
                    call append(10, "#ifndef _".toupper(expand("%:t:r"))."_H")
                    call append(11, "#define _".toupper(expand("%:t:r"))."_H")
                    call append(12, "")
                    call append(13, "#ifdef __cplusplus")
                    call append(14, "extern \"C\" {")
                    call append(15, "#endif")
                    call append(16, "")
                    call append(17, "")
                    call append(18, "#ifdef __cplusplus")
                    call append(19, "}")
                    call append(20, "#endif")
                    call append(21, "")
                    call append(22, "#endif // _".toupper(expand("%:t:r"))."_H")
                    normal G
                    normal o
                    normal k
           elseif expand("%:e") == 'c'
                    call append(10,"#include \"".expand("%:t:r").".h\"")
                    normal G
                    normal o
                    normal k
                    normal o
           elseif expand("%:e") == 'cpp'
                    call append(10,"#include \"".expand("%:t:r").".hpp\"")
                    normal G
                    normal o
                    normal k
                    normal o
           endif
        endif
endfun

map <F4> :call SetTitle() <cr>

" =============================================================================
" 函数说明信息插入
" =============================================================================

" 添加函数说明信息
nnoremap <silent> <F5> i<CR>/*<CR>
\*******************************************************************************
\<CR>*<CR>* Function    :
\<CR>*<CR>* Input       :
\<CR>*<CR>* Output      :
\<CR>*<CR>* Return      :
\<CR>*<CR>* Description :
\<CR>*<CR>* Author      :    <C-R>=GetDateTime()<ESC>   by Eric.he<Eric.he@fibocom.com>
\<CR>*<CR>
\*******************************************************************************
\<CR>*/<CR><CR>

inoremap <silent> <F5> <CR>/*<CR>
\*******************************************************************************
\<CR>*<CR>* Function    :    
\<CR>*<CR>* Input       :    
\<CR>*<CR>* Output      :    
\<CR>*<CR>* Return      :    
\<CR>*<CR>* Description :
\<CR>*<CR>* Author      :    <C-R>=GetDateTime()<ESC>   by Eric.he<Eric.he@fibocom.com>
\<CR>*<CR>
\*******************************************************************************
\<CR>*/<CR><CR>

" =============================================================================
" 自定义代码块注释
" =============================================================================

" 添加自定义代码块注释，以区别是自己添加的代码
nnoremap <silent> <C-F6> O
\/* begin add by Eric.he.  <C-R>=GetDateTime()<ESC> */<ESC>o
\/* end add by Eric.he End <C-R>=GetDateTime()<ESC> */<ESC>O

inoremap <silent> <C-F6> <ESC>O
\/* begin add by Eric.he.  <C-R>=GetDateTime()<ESC> */<ESC>o
\/* end add by Eric.he.  <C-R>=GetDateTime()<ESC> */<ESC>O

vnoremap <silent> <F6> dO
\#if 0    //Eric.he Comment Start <C-R>=GetDateTime()<ESC><ESC>o
\#endif   //Eric.he Comment End   <C-R>=GetDateTime()<ESC><ESC>O<CR><ESC>O<ESC>p

nnoremap <silent> <F6> O
\#if 0    //Eric.he Comment Start <C-R>=GetDateTime()<ESC><ESC>o
\#endif   //Eric.he Comment End   <C-R>=GetDateTime()<ESC><ESC>O

inoremap <silent> <F6> <ESC>O
\#if 0    //Eric.he Comment Start <C-R>=GetDateTime()<ESC><ESC>o
\#endif   //Eric.he Comment End   <C-R>=GetDateTime()<ESC><ESC>O

"""------------------------------------------------------------------------------------------------- 
""set autochdir
" set tags=tags
