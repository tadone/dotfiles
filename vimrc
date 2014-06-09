
" Much of this was customized by me, Rory O’Kane, but some was copied from
"  sources like these:
"
" http://vim.wikia.com/wiki/Example_vimrc
" https://github.com/gmarik/vundle
" https://github.com/smt/dotvim/
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/
" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/

"------------------------------------------------------------
" Features
"
" These options and commands enable some very useful features in Vim, that
" no user should have to live without.

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible


" Enable syntax highlighting
syntax on

set synmaxcol=2048      " Syntax coloring too-long lines is slow

set encoding=utf-8


"------------------------------------------------------------
" Vundle plugins

" Setting up Vundle - the vim plugin bundler
    let iCanHazVundle=1
    let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
    if !filereadable(vundle_readme)
        echo "Installing Vundle.."
        echo ""
        silent !mkdir -p ~/.vim/bundle
        silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
        let iCanHazVundle=0
    endif
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
    Bundle 'gmarik/vundle'
    "Add your bundles here
     Plugin 'flazz/vim-colorschemes'
     Plugin 'altercation/vim-colors-solarized'
     Plugin 'bling/vim-airline'
     Plugin 'roryokane/detectindent'
    "...All your other bundles...
    if iCanHazVundle == 0
        echo "Installing Bundles, please ignore key map error messages"
        echo ""
        :PluginInstall
    endif
" Setting up Vundle - the vim plugin bundler end

" Attempt to determine the type of a file based on its name and possibly its
" contents.  Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype plugin indent on


"------------------------------------------------------------
" Plugin settings

let g:airline_left_sep=''
let g:airline_right_sep=''
" don’t warn about trailing whitespace, because I like to indent even
"  blank lines, but Vim sees that indentation as trailing whitespace
let g:airline#extensions#whitespace#checks = [ 'indent' ]


"------------------------------------------------------------
" Must have options
"
" These are highly recommended options.

" One of the most important options to activate. Allows you to switch from an
" unsaved buffer without saving it first. Also allows you to keep an undo
" history for multiple files. Vim will complain if you try to quit without
" saving, and swap files will keep you safe if your computer crashes.
set hidden

" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window for multiple buffers, and/or:
" set confirm
" set autowriteall

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Do not highlight searches by default
" (the vim-unimpaired plugin provides `coh` to toggle this when needed)
" (my <Leader><Space> mapping below also temporarily turns off highlighting)
"set nohlsearch

" Modelines have historically been a source of security vulnerabilities.  As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline


"------------------------------------------------------------
" Backups

" don't keep swp files
set noswapfile


"------------------------------------------------------------
" Usability options
"
" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Replace all matches on the line, not just the first,
"  by default, without requiring …/g
set gdefault

" Incremental search
set incsearch

" Set the search scan to wrap around the file
set wrapscan

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell.  If visualbell is set, and
" this line is also included, vim will neither flash nor beep.  If visualbell
" is unset, this does nothing.
set t_vb=

" Enable use of the mouse for all modes
set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having to
" 'press <Enter> to continue'
" set cmdheight=2

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>

color wombat256

" wrap, but only in the display, not in the file
set wrap
set linebreak
set nolist
set textwidth=0
set wrapmargin=0
" indent wrapped lines
set showbreak=->
" set breakindent " not in main vim; need to compile with a patch

" automatically create folds based on syntax
set foldmethod=syntax
set foldlevelstart=99

" scroll to show always show some lines and columns around the cursor
set scrolloff=3
set sidescroll=1
set sidescrolloff=15

" reload files changed on disk when Vim regains focus,
"  unless there are local changes
" if this isn't working for you, perhaps only outside of the GUI,
"  see these pages:
" http://stackoverflow.com/questions/2490227/how-does-vims-autoread-work
" https://groups.google.com/forum/?fromgroups=#!topic/vim_dev/uqQuSfvuTrc
set autoread

" use prettier characters to represent whitespace in list mode,
"  and long lines and line wraps
" possible eol characters if I wanted one: ↩, ↲, ⬎, or ⤸
set listchars=tab:▸\ ,trail:·,extends:…,precedes:…,nbsp:·
set showbreak=↪\  " comment is here to make the whitespace not be trailing

" remove comment markers when joining lines
try
	set formatoptions+=j
catch /^Vim\%((\a\+)\)\=:E539/ " the j option was added in Vim 7.4
endtry

" don’t display the intro message on starting Vim
set shortmess+=I


"------------------------------------------------------------
" Indentation options
"
" Indentation settings according to personal preference.

" Use hard tabs for indent
set noexpandtab

" Display tabs as four characters wide
try
	set shiftwidth=0 " make 'sw' use the value of 'tabstop'
catch /^Vim\%((\a\+)\)\=:E487/ " before Vim 7.4, Vim did not support the value 0
	set shiftwidth=4
endtry
try
	set softtabstop=-1 " make 'sts' use the value of 'sw'
catch /^Vim\%((\a\+)\)\=:E487/ " before Vim 7.4, Vim did not support the value -1
	" I usually won’t need this because expandtab will be off, but setting
	"  this makes changing expandtab simpler
	set softtabstop=4
endtry
set tabstop=4

" Settings for the DetectIndent plugin
let g:detectindent_preferred_indent = 4
" I do not set g:detectindent_preferred_expandtab ;
"  this indicates that I prefer noexpandtab

" Note that indentation is customized per-language in the Autocommands section.


"------------------------------------------------------------
" Mappings

let mapleader=" "
let g:mapleader=" "

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
" this is currently being overwritten by yrrecord in YankRing; TODO fix
noremap Y y$

" Press space bar to turn off search highlighting and clear any message displayed
nnoremap <silent> <Leader><Space> :nohl<Bar>:echo<CR>

" on wrapped lines, move up and down visually, not logically
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk

" swap some mappings for moving to line boundaries and marks
"  so the more-useful commands have easier-to-hit key combos
" mappings afterwards:
"  hard-begin soft-begin end: ^ 0 `
"  jump-mark jump-mark-and-column: $ '
noremap 0 ^
noremap $ '
noremap ` $
noremap ' `
noremap ^ 0
noremap g0 g^
noremap g$ g'
noremap g` g$
noremap g' g`
noremap g^ g0
" stop selecting the newline in Visual mode
vnoremap ` $h

" keep indentation if I press Esc right after o or O
nnoremap o ox<BS>
nnoremap O Ox<BS>
" also keep indentation if I press Esc right after a newline in Insert mode
inoremap <Esc> x<BS><Esc>

" when indenting with < and >, make it easy to repeat
vnoremap < <gv
vnoremap > >gv

" run recorded macros easily
" use qq to record
" if you want Ex mode, run :normal! Q
nnoremap Q @q

" Disable regexes in search by default. When editing a search pattern,
" change V to v to enable standard (not Vim-flavored) regexes.
" see :help \V
nnoremap / /\V
vnoremap / /\V
nnoremap ? ?\V
vnoremap ? ?\V

" move to end of pasted text, to ease multiple pastes
vnoremap y y`]
vnoremap p p`]
nnoremap p p`]

" quickly select text you just pasted
" Overwrites a function only used in mappings.
"  Mappings only need to use normal! to be safe.
noremap gV `[v`]

" Remap <f1> to <esc> in every mode to accommodate fat-fingering
nmap <f1> <esc>
vmap <f1> <esc>
xmap <f1> <esc>
smap <f1> <esc>
omap <f1> <esc>
imap <f1> <esc>
lmap <f1> <esc>
cmap <f1> <esc>

" Help command to open help in a new tab
" help-argument-taking syntax taken from http://stackoverflow.com/a/14601793/578288
" remember also that :vertical help opens help in a vertical split pane
command -nargs=* -complete=help Help tab help <args>

" search for trailing whitespace and confirm its deletion
" based on https://github.com/bronson/vim-trailing-whitespace
"  and http://vim.wikia.com/wiki/Highlight_unwanted_spaces#Highlighting_with_a_search
"  and http://vim.wikia.com/wiki/Remove_unwanted_spaces
function! s:TrailingWhitespaceDelete(line1,line2)
	let l:saved_cursor = getpos(".")
	let l:saved_hlsearch = &hlsearch
	let l:saved_list = &list
	set hlsearch
	set list
	silent! execute ':' . a:line1 . ',' . a:line2 . 's/\(\S\+\)\@<=\s\+$//c'
	call setpos('.', l:saved_cursor)
	let &hlsearch = l:saved_hlsearch
	let &list = l:saved_list
endfunction
command! -range=% TrailingWhitespaceDelete call <SID>TrailingWhitespaceDelete(<line1>,<line2>)

" commands to edit the clipboard in a buffer
" useful for Vim for Windows, which doesn't have the Command key for Cmd-A and Cmd-V
" Load Clipboard into buffer
command LC normal ggVG"*pgg0
" Save Clipboard - copy buffer into clipboard, preserving cursor position
command SC normal VggoG"*y<C-O>


"------------------------------------------------------------
" Mappings that rely on other mappings
" Mappings that don’t use noremap should be placed here, near the end, so they
"  are not overwritten by noremap mappings.

" prevent v_p from swapping the paste buffer
" this makes it easier to rename a variable by pasting its new name
"  over all instances
" function from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
function! RestoreRegister()
	let @" = s:restore_reg
	return ''
endfunction
function! s:Repl()
	let s:restore_reg = @"
	return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()


"------------------------------------------------------------
" Autocommands

" when loading a given file into a buffer for the first time, run `cd .`
"  so that its file path in the status line becomes relative to the
"  working directory
au BufReadPost *  cd .

" detect indentation when opening a new file
autocmd BufReadPost *  DetectIndent
