" -----------------------------
" vim-plug
" -----------------------------
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" go
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
"" monokai風カラー
Plug 'tomasr/molokai'
" statusバーをpowerline風にする
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" ドキュメントを日本語化
Plug 'vim-jp/vimdoc-ja'
" fzf(If installed using Homebrew)
Plug '/usr/local/opt/fzf'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
" :source ~/.vimrc(:source %) or restart Vim
" :PlugInstall to install the plugins.


" -----------------------------
" Basic setup
" -----------------------------
"" Encoding
set fenc=utf-8
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
"set bomb "ファイルにBOM(byte order mark)を付与するか
set binary "バイナリファイルを編集
set ttyfast " 高速ターミナル接続を行う(ウィンドウをスクロールするのでなく再描画する)

set backspace=indent,eol,start "backspaceを制御

"" タブ
set tabstop=4 "ファイル内の <Tab> が対応する空白の数
set softtabstop=0 "<TAB>挿入時の空白数
set shiftwidth=4 "インデントでの空白数
set expandtab "タブの代わりに空白を利用する

"" Map leader to ,
let mapleader=','

"" Enable hidden buffers
set hidden "編集中のバッファを保存せずに閉じる

"" Searching
set hlsearch "検索結果をハイライトする
set incsearch "インクリメンタルサーチを有効にする
set ignorecase "大文字と小文字を区別しない
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る

"" Directories for swp files
set noswapfile  "スワップファイルを作らない
set nobackup    "バックアップファイルを作らない

set fileformats=unix,dos,mac "想定される改行 (<EOL>) の種類を指定する
"East Asian Width Class Ambiguous な文字(ユーロ、登録商標記号、著作権記号、ギリシャ文字、キリル文字など)をどう扱うかを定める
set ambiwidth=double
"ファイルがVimの内部では変更されてないが、Vimの外部で変更されたことが判明したとき、自動的に読み直す。
set autoread

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax on       "構文カラー表示on
set ruler       "ルーラー(右下に出る行数)を表示
set number      "行番号表示on

"システムのメニューファイルを読み込まない
let no_buffers_menu=1

"" molokaiスキームを読み込む
let g:rehash256 = 1
let g:molokai_original = 1
colorscheme molokai

set mousemodel=popup "右クリックでポップアップメニューを表示する
set t_Co=256 "vimを256色に対応する
set guioptions=egmrti "GUIの設定
set guifont=Monospace\ 10 "GUIで使われるフォント

set gcr=a:blinkon0 "全てのモードで点滅カーソルをオフにする
set scrolloff=3 "スクロールに余裕を持たせる

set laststatus=2 "ステータス行を常に表示する

"" Use modeline overrides
set modeline
set modelines=10 "modelineの検索行数を指定

set title       "編集中のファイル名を表示
set titleold="Terminal" "タイトルが復元できない場合
set titlestring=%F "ウインドウタイトルを設定

"ステータス行の表示設定
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

" 補完ウィンドウの設定
set completeopt=menuone
" ビープ音を可視化
set visualbell

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
" zz カーソルのある行を中央に移動する
" カーソルのある部分まで折りたたみを開く
nnoremap n nzzzv
nnoremap N Nzzzv

" vim-airline
let g:airline_theme = 'powerlineish'
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1

"*****************************************************************************
"" Mappings
"*****************************************************************************

"" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

""" Set working directory
"nnoremap <leader>. :lcd %:p:h<CR>
"
""" Opens an edit command with the path of the currently edited file filled in
"noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
"
""" Opens a tab edit command with the path of the currently edited file filled
"noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>
"
"" syntastic
"let g:syntastic_always_populate_loc_list=1
"let g:syntastic_error_symbol='✗'
"let g:syntastic_warning_symbol='⚠'
"let g:syntastic_style_error_symbol = '✗'
"let g:syntastic_style_warning_symbol = '⚠'
"let g:syntastic_auto_loc_list=1
"let g:syntastic_aggregate_errors = 1
"
""" Buffer nav
"noremap <leader>z :bp<CR>
"noremap <leader>q :bp<CR>
"noremap <leader>x :bn<CR>
"noremap <leader>w :bn<CR>
"
"" Close buffer
"noremap <leader>c :bd<CR>
"
" 検索時のハイライトを消す
"nnoremap <silent> <leader><space> :noh<cr>
""ハイライトをEsc2回で消去
nmap <Esc><Esc> :nohlsearch<CR><Esc>
"
""" Switching windows
"noremap <C-j> <C-w>j
"noremap <C-k> <C-w>k
"noremap <C-l> <C-w>l
"noremap <C-h> <C-w>h
"
""" Vmap for maintain Visual Mode after shifting > and <
"vmap < <gv
"vmap > >gv
"
""" Move visual block
"vnoremap J :m '>+1<CR>gv=gv
"vnoremap K :m '<-2<CR>gv=gv

"*****************************************************************************
"" Custom configs
"*****************************************************************************
set showmatch   "括弧入力時に対応する括弧を強調
set smartindent	"賢いインデントに
set showmode    "モードの表示
set wildmenu wildmode=list:full   "補完機能を強化
set undolevels=100 "undoできる数
set cursorline "横ラインを引く
set autowrite "makeコマンド実行時にファイルの内容を自動的に保存する
set clipboard+=unnamed "クリップボードでコピーを保持する
set iskeyword+=- "ハイフンを境界文字から外す

"vimgrep関連のマッピング
"ctrl-g2回でカーソル文字列をvimgrep(jumpはしない.オプションj)
"nmap <C-G><C-G> :vimgrep /<C-R><C-W>/j **/*
""Quickfix結果を別ウィンドウで開く
"autocmd QuickFixCmdPost *grep* cwindow
"
""拡張子に合わせていい感じに
"filetype on
"filetype indent on
"filetype plugin on
"
""折りたたみ
""  シンタックスで折りたたみ
"set foldmethod=syntax
"set foldlevel=100
"set foldcolumn=3
"
""拡張子による設定変更
"""sw=softtabstop, sts=shiftwidth, ts=tabstop, et=expandtab
"autocmd FileType ruby        setlocal sw=2 sts=2 ts=2 et
"autocmd FileType c           setlocal sw=4 sts=4 ts=4 noet
"autocmd FileType go          setlocal sw=4 sts=4 ts=4 noet
"autocmd FileType erb         setlocal sw=4 sts=4 ts=4 noet
"autocmd FileType html        setlocal sw=4 sts=4 ts=4 noet
"autocmd Filetype yml		 setlocal sw=2 sts=2 ts=2 et
"autocmd BufNewFile,BufRead *.{md,txt} setlocal filetype=markdown
"autocmd BufNewFile,BufRead *.{md,txt} colorscheme slate
