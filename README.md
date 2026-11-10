# myvim

一套面向 C/C++ 开发、兼容 Vim 7.3 / 7.4 / 8.0+ 的 Vim 配置。插件随仓库分发，clone 后复制到 `$HOME` 即可使用，无需联网安装插件。

## 目录结构

```
.
├── .vimrc                    # 主配置（约 1470 行，带大量中文注释）
├── .bashrc                   # 系统默认 bashrc + fzf 集成 + 自定义 PS1
└── .vim/
    ├── autoload/
    │   ├── plug.vim          # vim-plug 自带，无需另行安装
    │   ├── acp.vim           # AutoComplPop（Vim 7.3 补全方案）
    │   └── lightline/colorscheme/gruvbox.vim   # 自定义 lightline 主题
    ├── doc/
    │   └── acp.txt           # acp 中文帮助
    ├── plugin/
    │   └── acp.vim           # AutoComplPop 主脚本
    └── plugged/              # 23 个插件（已剔除各自 .git 目录）
```

## 安装

把 `.vim` 和 `.vimrc` 放入 `$HOME`：

```bash
git clone https://github.com/<你的用户名>/myvim.git
cd myvim
cp -a .vim .vimrc ~/
```

`.vim/autoload/plug.vim` 已包含在仓库内，不需要单独安装 vim-plug。

备份现有配置再覆盖：

```bash
mv ~/.vim ~/.vim.bak 2>/dev/null; mv ~/.vimrc ~/.vimrc.bak 2>/dev/null
```

## 版本兼容策略

配置按 Vim 版本分成三套插件与按键方案，运行时动态选择：

| Vim 版本 | 状态栏 | 大纲视图 | 模糊搜索 | Linter | 补全 |
|---|---|---|---|---|---|
| 8.0+ | vim-airline | tagbar | LeaderF / fzf | ale | omnicppcomplete |
| 7.4+ | vim-airline | tagbar | LeaderF / fzf | syntastic | omnicppcomplete |
| 7.3 | lightline | taglist.vim | ctrlp.vim | syntastic | omnicppcomplete |

版本分支选择的核心逻辑在 `.vimrc:210-354`。LeaderF 要求 7.4+330 补丁，fzf 要求 7.4+383 补丁，coc.nvim 仅在 `executable('node')` 时加载。

## 已内置插件（23 个）

| 插件 | 作用 | 版本分支 |
|---|---|---|
| scrooloose/nerdtree | 文件目录树 | 全部 |
| jistr/vim-nerdtree-tabs | NERDTree 按 Tab 同步 | 7.4+ |
| morhetz/gruvbox | 配色方案 | 全部 |
| scrooloose/nerdcommenter | 快速注释 | 全部 |
| vim-airline/vim-airline | 状态栏 | 7.4+ |
| vim-airline/vim-airline-themes | 状态栏主题 | 7.4+ |
| itchyny/lightline.vim | 状态栏 | 7.3 |
| majutsushi/tagbar | 代码大纲 | 7.4+ |
| vim-scripts/taglist.vim | 代码大纲 | 7.3 |
| yegappan/mru | 最近打开文件 | 全部 |
| vim-scripts/a.vim | .c/.h 互跳 | 全部 |
| Yggdroot/LeaderF | 模糊搜索 | 7.4+ |
| ctrlpvim/ctrlp.vim (tag 1.79) | 模糊搜索 | 7.3 |
| junegunn/fzf.vim | fzf 集成 | 7.4+ |
| w0rp/ale | 异步语法检查 | 8.0+ |
| vim-syntastic/syntastic (tag 3.9.0) | 语法检查 | 7.3 |
| octol/vim-cpp-enhanced-highlight | C++ 高亮增强 | 全部 |
| ludovicchabant/vim-gutentags | 自动生成 tags | 7.4+ |
| vim-scripts/omnicppcomplete | C++ 补全 | 7.3 |
| MarcWeber/vim-addon-mw-utils | snipmate 依赖 | 7.3 |
| tomtom/tlib_vim | snipmate 依赖 | 7.3 |
| garbas/vim-snipmate | 代码片段引擎 | 7.3 |
| honza/vim-snippets | 代码片段库 | 7.3 |

以下插件未随仓库分发，需要时自行执行 `:PlugInstall`：

- `junegunn/fzf`（fzf 核心，安装脚本会写入 `~/.fzf`）
- `neoclide/coc.nvim`（需 node，可选）

## 快捷键

Leader 键为 `<Space>`。在 Vim 内按 `<Space>h` 可随时查看完整帮助。

### Cscope 代码导航

| 快捷键 | 功能 |
|---|---|
| `<leader>fg` | 查找函数/宏/变量定义 |
| `<leader>fc` | 查找函数被调用的位置 |
| `<leader>fs` | 查找 C 符号出现的位置 |
| `<leader>ft` | 查找字符串出现的位置 |
| `<leader>fe` | egrep 模式查找 |
| `<leader>ff` | 查找文件名 |
| `<leader>fi` | 查找 `#include` 了当前文件的位置 |
| `<leader>fd` | 查找当前函数调用了哪些函数 |
| `<leader>cf` | 生成 `cscope.files` 文件列表 |
| `<leader>sf` | 生成并加载 `cscope.out` 与 `tags` |
| `<leader><F11>` | 递归生成并加载 `cscope.out` 与 `tags` |

cscope/tags 数据库缓存在 `~/.cache/vim/cscope/<项目名>/`，不污染工程目录。

### 文件搜索

| 快捷键 | 功能 |
|---|---|
| `<c-p>` | LeaderF / CtrlP 模糊查找文件 |
| `<leader>f` | fzf `:Files`（未装 fzf 则回退） |
| `<leader>b` | fzf `:Buffers` |
| `<leader>lf` | LeaderF 文件搜索 |
| `<leader>ag` | `:Ag` / `:grep` 全局内容搜索 |

### 窗口与 Tab

| 快捷键 | 功能 |
|---|---|
| `<leader>t` | 切换 NERDTree |
| `<leader>1` ~ `<leader>9` | 切换到第 1-9 个 Tab |
| `<leader>q` | 关闭当前 Buffer / Tab |
| `<F8>` | Tagbar / Taglist 大纲开关 |
| `<c-h>` `<c-j>` `<c-k>` `<c-l>` | 窗口间跳转 |
| `q` | 关闭帮助窗口 |

### 编辑与代码生成

| 快捷键 | 功能 |
|---|---|
| `<F9>` | 选中块注释（NERDCommenter sexy） |
| `<leader>uc` | 取消注释 |
| `<Tab>`（插入模式） | 触发代码片段 |
| `<F7>`（插入模式） | omnicppcomplete 补全 |
| `<F4>` | 插入/更新文件头 |
| `<F5>` | 插入函数说明模板 |
| `<F6>` | 插入 `#if 0` 注释块 |
| `<C-F6>` | 插入 `begin/end add by` 标记块 |
| `=` | 与下一行交换 |
| `-` | 与上一行交换 |

文件头（`.c/.cpp/.h/.hpp/.sh/Makefile`）在 `BufNewFile` 时自动插入，F4 可手动更新。

### 语法检查

| 快捷键 | 功能 |
|---|---|
| `<leader>s` | 开启/关闭检查 |
| `<leader>d` | 查看错误详情 |
| `sp` | 跳上一个错误 |
| `sn` | 跳下一个错误 |

ALE（8.0+）使用 clang 检查 C/C++，错误/警告图标为 `✗`/`⚡`。

## 外部依赖

| 程序 | 用途 | 缺失后果 |
|---|---|---|
| `cscope` | 代码导航 | cscope 功能不可用，启动时有警告 |
| `ctags` | tags 生成、Tagbar、gutentags | F8 大纲不可用 |
| `clang` | ALE/Syntastic 检查 | 语法检查无结果 |
| `node` | coc.nvim（可选） | coc.nvim 不加载 |
| `find` | `<leader>cf` 生成文件列表 | 生成列表失败 |

Debian/Ubuntu 安装：

```bash
sudo apt-get install cscope exuberant-ctags clang
```

## 自定义提示

文件头和注释模板中的作者与版权信息（`Eric.he<Eric.he@fibocom.com>`、`Fibocom Electronics Corporation`）硬编码在 `.vimrc` 约 1286-1468 行。Fork 后建议改成自己的信息：

```vim
call append( 3, "#  Copyright (C) 2022 Fibocom Electronics Corporation, Inc. All rights reserved" )
call append( 5, "#  Author              :Eric.he<Eric.he@fibocom.com>" )
```

主要位置：`AddTitle()`（1281-1310 行）、`<F5>` 函数模板（约 1428、1440 行）、`<C-F6>` / `<F6>` 标记块（约 1452-1468 行）。

## .gitignore

`.vim/cache/`（LeaderF 索引）与 `~/.cache/tags`（gutentags）都是运行时生成物，已排除。
