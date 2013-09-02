" =============================================================================
"        << 判断操作系统是 Windows 还是 Linux 和判断是终端还是 Gvim >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < 判断操作系统是否是 Windows 还是 Linux >
" -----------------------------------------------------------------------------
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:iswindows = 0
endif

" -----------------------------------------------------------------------------
"  < 判断是终端还是 Gvim >
" -----------------------------------------------------------------------------
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif

" =============================================================================
"                          << 以下为软件默认配置 >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < Windows Gvim 默认配置> 做了一点修改
" -----------------------------------------------------------------------------
if (g:iswindows && g:isGUI)

    " 退格键
    set backspace=indent,eol,start whichwrap+=<,>,[,]
    vnoremap <BS> d

    set diffexpr=MyDiff()
    function MyDiff()
      let opt = '-a --binary '
      if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
      if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
      let arg1 = v:fname_in
      if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
      let arg2 = v:fname_new
      if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
      let arg3 = v:fname_out
      if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
      let eq = ''
      if $VIMRUNTIME =~ ' '
        if &sh =~ '\<cmd'
          let cmd = '""' . $VIMRUNTIME . '\diff"'
          let eq = '"'
        else
          let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
        endif
      else
        let cmd = $VIMRUNTIME . '\diff'
      endif
    endfunction
endif


" =============================================================================
"                          << 以下为用户自定义配置 >>
" =============================================================================
set nocompatible                                            " 禁用 Vi 兼容模式

set encoding=utf-8                                          " Vim内部使用的字符编码方式
set fileencoding=utf-8                                      " Vim中当前编辑的文件的字符编码方式
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1           " Vim自动探测fileencoding的顺序列表
set fileformat=unix                                         " 设置新文件换行符的格式
set fileformats=unix,dos,mac                                " 设置支持文件的换行符格式
set termencoding=utf-8                                      " Vim在与屏幕/键盘交互时使用的编码(取决于实际的终端的设定)
set langmenu=zh_CN.utf-8                                    " 菜单语言
language messages zh_CN.UTF-8

set guifont=YaHei\ Consolas\ Hybrid:h12                     " 字体

syntax on                                                   " 语法高亮

filetype on                                                 " 启用文件类型侦测
filetype plugin on                                          " 针对不同的文件类型加载对应的插件
"filetype plugin indent on                                   " 启用缩进

set history=8                                               " 设置冒号命令和搜索命令的命令历史列表的长度

set clipboard+=unnamed                                      " 与windows共享剪贴板

set writebackup                                             " 保存文件前建立备份，保存成功后删除该备份
set noswapfile                                              " 不要swap文件
set nobackup                                                " 不要备份文件

set expandtab                                               " 将Tab键转换为空格
set tabstop=2                                               " 设置Tab键的宽度为2
set shiftwidth=2                                            " 换行时自动缩进2个空格
set softtabstop=2

set cindent                                                 " 使用C样式的缩进
set autoindent                                              " 继承前一行的缩进方式，特别适用于多行注释
set smartindent                                             " 智能缩进
set smarttab                                                " 指定按一次backspace就删除shiftwidth宽度的空格
set nofoldenable                                              " 启用折叠
set foldmethod=indent                                       " indent 折叠方式
" 用空格键来开关折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

set ruler                                                   " 右下角的光标位置显示

set hlsearch                                                " 高亮显示搜索结果
set incsearch                                               " 在键入目标字符串的过程中就同时开始搜索

set showcmd                                                 " 在Vim窗口的右下角显示一个完整的命令已经完成的部分

set showmatch                                               " 高亮匹配的括号
set matchtime=8                                             " 设置键入某个闭括号时,等待时间的长短，时间单位是十分之一秒

set helplang=Cn                                             " 帮助文档语言为中文，需要先下载才有效

set number                                                  " 显示行号

set laststatus=2                                            " 总是显示状态栏

set cmdheight=2                                             " 设置命令行的高度

set cursorline                                              " 突出显示当前行
"set cursorcolumn                                            " 突出显示当前列

set shortmess=atI                                           " 去掉欢迎界面

au GUIEnter * simalt ~x                                     " 窗口启动时自动最大化

set mouse=nv                                                " normal和Visual启动鼠标

autocmd FileType perl set keywordprg=perldoc\ -f            " Perl帮助

set vb t_vb=                                                " 关闭响铃

" 定义mapleader
let mapleader = ","
let g:mapleader = ","

set autoread                                                " 当文件在外部被修改，自动更新该文件

nmap cS :%s/\s\+$//g<cr>:noh<cr>                            " 常规模式下输入 cS 清除行尾空格
nmap cM :%s/\r$//g<cr>:noh<cr>                              " 常规模式下输入 cM 清除行尾 ^M 符号

imap <c-k> <Up>                                             " Ctrl + K 插入模式下光标向上移动
imap <c-j> <Down>                                           " Ctrl + J 插入模式下光标向下移动
imap <c-h> <Left>                                           " Ctrl + H 插入模式下光标向左移动
imap <c-l> <Right>                                          " Ctrl + L 插入模式下光标向右移动

" 每行超过88个的字符用下划线标示
au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 88 . 'v.\+', -1)

au BufRead,BufNewFile,BufEnter * cd %:p:h                   " 自动切换目录为当前编辑文件所在目录

colorscheme lucius                                          " 配色方案

" 显示/隐藏菜单栏、工具栏、滚动条，可用 F11 切换
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L
map <silent> <F11> :if &guioptions =~# 'm' <Bar>
    \set guioptions-=m <Bar>
    \set guioptions-=T <Bar>
    \set guioptions-=r <Bar>
    \set guioptions-=L <Bar>
\else <Bar>
    \set guioptions+=m <Bar>
    \set guioptions+=T <Bar>
    \set guioptions+=r <Bar>
    \set guioptions+=L <Bar>
\endif<CR>

" 个性化状栏（这里提供两种方式，要使用其中一种去掉注释即可，不使用反之）
let &statusline=' %t %{&mod?(&ro?"*":"+"):(&ro?"=":" ")} %1*|%* %{&ft==""?"any":&ft} %1*|%* %{&ff} %1*|%* %{(&fenc=="")?&enc:&fenc}%{(&bomb?",BOM":"")} %1*|%* %=%1*|%* 0x%B %1*|%* (%l,%c%V) %1*|%* %L %1*|%* %P'
" set statusline=%t\ %1*%m%*\ %1*%r%*\ %2*%h%*%w%=%l%3*/%L(%p%%)%*,%c%V]\ [%b:0x%B]\ [%{&ft==''?'TEXT':toupper(&ft)},%{toupper(&ff)},%{toupper(&fenc!=''?&fenc:&enc)}%{&bomb?',BOM':''}%{&eol?'':',NOEOL'}]

" -----------------------------------------------------------------------------
"  < 编译、连接、运行配置 >
" -----------------------------------------------------------------------------
" F9 一键保存、编译、连接存并运行
map <F9> :call Run()<CR>
imap <F9> <ESC>:call Run()<CR>

" Ctrl + F9 一键保存并编译
map <c-F9> :call Compile()<CR>
imap <c-F9> <ESC>:call Compile()<CR>

" Ctrl + F10 一键保存并连接
map <c-F10> :call Link()<CR>
imap <c-F10> <ESC>:call Link()<CR>

let s:LastShellReturn_C = 0
let s:LastShellReturn_L = 0
let s:ShowWarning = 1
let s:Obj_Extension = '.o'
let s:Exe_Extension = '.exe'
let s:Sou_Error = 0

let s:windows_CFlags = 'gcc\ -fexec-charset=gbk\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'
let s:linux_CFlags = 'gcc\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'

let s:windows_CPPFlags = 'g++\ -fexec-charset=gbk\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'
let s:linux_CPPFlags = 'g++\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'

function Compile()
    exe ":ccl"
    exe ":update"
    if expand("%:e") == "c" || expand("%:e") == "cpp" || expand("%:e") == "cxx"
        let s:Sou_Error = 0
        let s:LastShellReturn_C = 0
        let Sou = expand("%:p")
        let Obj = expand("%:p:r").s:Obj_Extension
        let Obj_Name = expand("%:p:t:r").s:Obj_Extension
        let v:statusmsg = ''
        if !filereadable(Obj) || (filereadable(Obj) && (getftime(Obj) < getftime(Sou)))
            redraw!
            if expand("%:e") == "c"
                if g:iswindows
                    exe ":setlocal makeprg=".s:windows_CFlags
                else
                    exe ":setlocal makeprg=".s:linux_CFlags
                endif
                echohl WarningMsg | echo " compiling..."
                silent make
            elseif expand("%:e") == "cpp" || expand("%:e") == "cxx"
                if g:iswindows
                    exe ":setlocal makeprg=".s:windows_CPPFlags
                else
                    exe ":setlocal makeprg=".s:linux_CPPFlags
                endif
                echohl WarningMsg | echo " compiling..."
                silent make
            endif
            redraw!
            if v:shell_error != 0
                let s:LastShellReturn_C = v:shell_error
            endif
            if g:iswindows
                if s:LastShellReturn_C != 0
                    exe ":bo cope"
                    echohl WarningMsg | echo " compilation failed"
                else
                    if s:ShowWarning
                        exe ":bo cw"
                    endif
                    echohl WarningMsg | echo " compilation successful"
                endif
            else
                if empty(v:statusmsg)
                    echohl WarningMsg | echo " compilation successful"
                else
                    exe ":bo cope"
                endif
            endif
        else
            echohl WarningMsg | echo ""Obj_Name"is up to date"
        endif
    else
        let s:Sou_Error = 1
        echohl WarningMsg | echo " please choose the correct source file"
    endif
    exe ":setlocal makeprg=make"
endfunction

function Link()
    call Compile()
    if s:Sou_Error || s:LastShellReturn_C != 0
        return
    endif
    let s:LastShellReturn_L = 0
    let Sou = expand("%:p")
    let Obj = expand("%:p:r").s:Obj_Extension
    if g:iswindows
        let Exe = expand("%:p:r").s:Exe_Extension
        let Exe_Name = expand("%:p:t:r").s:Exe_Extension
    else
        let Exe = expand("%:p:r")
        let Exe_Name = expand("%:p:t:r")
    endif
    let v:statusmsg = ''
	if filereadable(Obj) && (getftime(Obj) >= getftime(Sou))
        redraw!
        if !executable(Exe) || (executable(Exe) && getftime(Exe) < getftime(Obj))
            if expand("%:e") == "c"
                setlocal makeprg=gcc\ -o\ %<\ %<.o
                echohl WarningMsg | echo " linking..."
                silent make
            elseif expand("%:e") == "cpp" || expand("%:e") == "cxx"
                setlocal makeprg=g++\ -o\ %<\ %<.o
                echohl WarningMsg | echo " linking..."
                silent make
            endif
            redraw!
            if v:shell_error != 0
                let s:LastShellReturn_L = v:shell_error
            endif
            if g:iswindows
                if s:LastShellReturn_L != 0
                    exe ":bo cope"
                    echohl WarningMsg | echo " linking failed"
                else
                    if s:ShowWarning
                        exe ":bo cw"
                    endif
                    echohl WarningMsg | echo " linking successful"
                endif
            else
                if empty(v:statusmsg)
                    echohl WarningMsg | echo " linking successful"
                else
                    exe ":bo cope"
                endif
            endif
        else
            echohl WarningMsg | echo ""Exe_Name"is up to date"
        endif
    endif
    setlocal makeprg=make
endfunction

function Run()
    let s:ShowWarning = 0
    call Link()
    let s:ShowWarning = 1
    if s:Sou_Error || s:LastShellReturn_C != 0 || s:LastShellReturn_L != 0
        return
    endif
    let Sou = expand("%:p")
    let Obj = expand("%:p:r").s:Obj_Extension
    if g:iswindows
        let Exe = expand("%:p:r").s:Exe_Extension
    else
        let Exe = expand("%:p:r")
    endif
    if executable(Exe) && getftime(Exe) >= getftime(Obj) && getftime(Obj) >= getftime(Sou)
        redraw!
        echohl WarningMsg | echo " running..."
        if g:iswindows
            exe ":!%<.exe"
        else
            if g:isGUI
                exe ":!gnome-terminal -e ./%<"
            else
                exe ":!./%<"
            endif
        endif
        redraw!
        echohl WarningMsg | echo " running finish"
    endif
endfunction

inoremap ( ()<Esc>i
inoremap [ []<Esc>i
"  inoremap { {<CR>}<Esc>O
inoremap { {}<Esc>i

inoremap ) <ESC>:call RemoveNextDoubleChar(')')<CR>a
inoremap ] <ESC>:call RemoveNextDoubleChar(']')<CR>a
inoremap } <ESC>:call RemoveNextDoubleChar('}')<CR>a

inoremap <BS> <ESC>:call RemovePairs()<CR>a

function RemoveNextDoubleChar(char)
    let l:line = getline(".")
    let l:next_char = l:line[col(".")] " 取得当前光标后一个字符

    if a:char == l:next_char
        silent execute "normal! l"
    else
        silent execute "normal! a" . a:char . ""
    end
endfunction

function RemovePairs()
    let l:line = getline(".")
    let l:previous_char = l:line[col(".")-1] " 取得当前光标前一个字符

    if index(["(", "[", "{"], l:previous_char) == -1
        silent execute "normal! a\<BS>"
    else
        let l:original_pos = getpos(".")
        silent execute "normal %"
        let l:new_pos = getpos(".")

        " 如果没有匹配的右括号
        if l:original_pos == l:new_pos
            silent execute "normal! a\<BS>"
            return
        end

        let l:line2 = getline(".")
        if len(l:line2) == col(".")
            " 如果右括号是当前行最后一个字符
            silent execute "normal! v%xa"
        else
            " 如果右括号不是当前行最后一个字符
            silent execute "normal! v%xi"
        end
    end
endfunction

" -----------------------------------------------------------------------------
"  < 添加C/C++文件头描述信息 >
" -----------------------------------------------------------------------------
" F4
map <F4> :call TitleDescription()<cr>'s
function AddTitle()
  call append(0, "/*")
  call append(1, " * Copyright (c) ".strftime("%Y")." kom. All rights reserved.")
  call append(2, " *")
  call append(3, " * Redistribution and use in source and binary forms, with or without")
  call append(4, " * modification, are permitted provided that the following conditions")
  call append(5, " * are met:")
  call append(6, " *")
  call append(7, " *  * Redistributions of source code must retain the above copyright")
  call append(8, " *    notice, this list ofconditions and the following disclaimer.")
  call append(9, " *")
  call append(10," *  * Redistributions in binary form must reproduce the above copyright")
  call append(11," *    notice, this list of conditions and the following disclaimer in")
  call append(12," *    the documentation and/or other materialsprovided with the")
  call append(13," *    distribution.")
  call append(14," *")
  call append(15," * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS")
  call append(16," * \"AS IS\" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT")
  call append(17," * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS")
  call append(18," * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE")
  call append(19," * COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,")
  call append(20," * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,")
  call append(21," * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;")
  call append(22," * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER")
  call append(23," * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT")
  call append(24," * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN")
  call append(25," * ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE")
  call append(26," * POSSIBILITY OF SUCH DAMAGE.")
  call append(27," */")
  echohl WarningMsg | echo "Successful in adding the copyright." | echohl None
endfunction

" 更新最近修改时间和文件名
function UpdateTitle()
  normal m'
  execute '/# *Last modified:/s@:.*$@\=strftime(":\t%Y-%m-%d %H:%M")@'
  normal ''
  normal mk
  execute '/# *Filename:/s@:.*$@\=":\t\t".expand("%:t")@'
  execute "noh"
  normal 'k
  echohl WarningMsg | echo "Successful in updating the copy right." | echohl None
endfunction

" 判断前10行代码里面, 是否有Copyright这个单词，
" 如果没有的话, 代表没有添加过作者信息, 需要新添加: 如果有的话, 那么只需要更新即可
function TitleDescription()
  let n=1
  " 默认为添加
  while n < 10
    let line = getline(n)
      if line =~ '^\#\s*\S*Copyright:\S*.*$'
        call UpdateTitle()
        return
      endif
      let n = n + 1
  endwhile
  call AddTitle()
endfunction



" =============================================================================
"                          << 以下为常用插件配置 >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < a.vim 插件配置 >
" -----------------------------------------------------------------------------
" 用于切换C/C++头文件
" :A     ---切换头文件并独占整个窗口
" :AV    ---切换头文件并垂直分割窗口
" :AS    ---切换头文件并水平分割窗口

" -----------------------------------------------------------------------------
"  < nerdtree 插件配置 >
" -----------------------------------------------------------------------------
" 常规模式下按 F2 调用插件
nmap <F2> :NERDTreeToggle<CR>
let NERDChristmasTree=1                     " 让Tree把自己给装饰得多姿多彩漂亮点
let NERDTreeAutoCenter=1                    " 控制当光标移动超过一定距离时，是否自动将焦点调整到屏中心
let NERDTreeMouseMode=2                     " 指定鼠标模式（1.双击打开；2.单目录双文件；3.单击打开）
let NERDTreeShowBookmarks=1                 " 是否默认显示书签列表
let NERDTreeShowFiles=1                     " 是否默认显示文件
"let NERDTreeShowHidden=1                    " 是否默认显示隐藏文件
let NERDTreeShowLineNumbers=1               " 是否默认显示行号
let NERDTreeWinPos='left'                   " 窗口位置（'left' or 'right'）
let NERDTreeWinSize=31                      " 窗口宽
let NERDTreeStatusline=1                    " 窗口状态栏
" 指定书签文件
let NERDTreeBookmarksFile=$VIM.'\vimfiles\Data\NerdBookmarks.txt'

" -----------------------------------------------------------------------------
"  < Tagbar 插件配置 >
" -----------------------------------------------------------------------------
" 常规模式下按 F3 调用插件
nmap <F3> :TagbarToggle<cr>
let g:tagbar_ctags_bin='ctags'              " ctags命令
let g:tagbar_width=30                       " 设置窗口宽度
let g:tagbar_left=1                         " 在左侧窗口中显示

" 打开C/C++文件是自动打开
autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()

" -----------------------------------------------------------------------------
"  < nerdcommenter 插件配置 >
" -----------------------------------------------------------------------------
" 我主要用于C/C++代码注释(其它的也行)，这个插件我做了小点修改，也就是在注释符
" 与注释内容间加一个空格
" 以下为插件默认快捷键，其中的说明是以C/C++为例的
" <Leader>ci 以每行一个 /* */ 注释选中行(选中区域所在行)，再输入则取消注释
" <Leader>cm 以一个 /* */ 注释选中行(选中区域所在行)，再输入则称重复注释
" <Leader>cc 以每行一个 /* */ 注释选中行或区域，再输入则称重复注释
" <Leader>cu 取消选中区域(行)的注释，选中区域(行)内至少有一个 /* */
" <Leader>ca 在/*...*/与//这两种注释方式中切换（其它语言可能不一样了）
" <Leader>cA 行尾注释
let NERDSpaceDelims = 1                     "在左注释符之后，右注释符之前留有空格
