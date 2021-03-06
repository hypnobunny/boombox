" -----------------------------------------------------------------------------
" File: boombox.vim
" Description: Modified version of boombox by morhetz
" Author: klepsauce <klepsauce@gmail.com>
" Last Modified: 28 June 2015
" -----------------------------------------------------------------------------

" Supporting code -------------------------------------------------------------
" Initialisation: {{{

if version > 580
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif

let g:colors_name='boombox'

if !has('gui_running') && &t_Co != 256
    finish
endif

" }}}
" Global Settings: {{{

if !exists('g:boombox_bold')
    let g:boombox_bold=1
endif
if !exists('g:boombox_italic')
    if has('gui_running') || $TERM_ITALICS == 'true'
        let g:boombox_italic=1
    else
        let g:boombox_italic=0
    endif
endif
if !exists('g:boombox_undercurl')
    let g:boombox_undercurl=1
endif
if !exists('g:boombox_underline')
    let g:boombox_underline=1
endif

if !exists('g:boombox_italicize_comments')
    let g:boombox_italicize_comments=1
endif
if !exists('g:boombox_italicize_strings')
    let g:boombox_italicize_strings=0
endif

if !exists('g:boombox_improved_strings')
    let g:boombox_improved_strings=0
endif

if !exists('g:boombox_improved_warnings')
    let g:boombox_improved_warnings=0
endif

if !exists('g:boombox_termcolors')
    let g:boombox_termcolors=256
endif

if !exists('g:boombox_invert_indent_guides')
    let g:boombox_invert_indent_guides=0
endif

if !exists('g:boombox_hls_cursor')
    let g:boombox_hls_cursor='orange'
endif

if !exists('g:boombox_sign_column')
    let g:boombox_sign_column='dark1'
endif

if !exists('g:boombox_color_column')
    let g:boombox_color_column='dark1'
endif

if !exists('g:boombox_vert_split')
    let g:boombox_vert_split='dark2'
endif

if !exists('g:boombox_invert_signs')
    let g:boombox_invert_signs=0
endif

if !exists('g:boombox_invert_selection')
    let g:boombox_invert_selection=1
endif

if !exists('g:boombox_contrast')
    let g:boombox_contrast='medium'
endif

if !exists('g:boombox_contrast_dark')
    let g:boombox_contrast_dark='medium'
endif

if !exists('g:boombox_contrast_light')
    let g:boombox_contrast_light='medium'
endif

if !exists('g:boombox_invert_tabline')
    let g:boombox_invert_tabline=0
endif

let s:is_dark=(&background == 'dark')

" }}}
" Palette: {{{

let s:gb = {}

if s:is_dark
    let s:gb.dark0  = ['282828', 235]     " 40-40-40
    let s:gb.dark1  = ['3c3836', 237]     " 60-56-54
    let s:gb.dark2  = ['504945', 239]     " 80-73-69
    let s:gb.dark3  = ['665c54', 241]     " 102-92-84
    let s:gb.dark4  = ['7c6f64', 243]     " 124-111-100

    let s:gb.medium = ['928374', 245]     " 146-131-116

    let s:gb.light0 = ['fdf4c1', 229]     " 253-244-193
    let s:gb.light1 = ['ebdbb2', 223]     " 235-219-178
    let s:gb.light2 = ['d5c4a1', 250]     " 213-196-161
    let s:gb.light3 = ['bdae93', 248]     " 189-174-147
    let s:gb.light4 = ['a89984', 246]     " 168-153-132

    let s:gb.light4_256 = ['a89984', 246] " 168-153-132

    let s:gb.red    = ['fb4934', 167]     " 251-73-52
    let s:gb.green  = ['5fd700', 76]      " 95-215-0
    let s:gb.yellow = ['fabd2f', 214]     " 250-189-47
    let s:gb.blue   = ['87afff', 111]     " 135-175-255
    let s:gb.purple = ['af5fff', 135]     " 175-95-255
    let s:gb.aqua   = ['87d7af', 115]     " 135-215-175
    let s:gb.orange = ['fe8019', 208]     " 254-128-25

    if g:boombox_termcolors == 16
        let s:gb.dark0  = ['282828', 0]
        let s:gb.light4 = ['a89984', 7]
        let s:gb.medium = ['928374', 8]
        let s:gb.red    = ['fb4934', 9]
        let s:gb.green  = ['b8bb26', 10]
        let s:gb.yellow = ['fabd2f', 11]
        let s:gb.blue   = ['83a598', 12]
        let s:gb.purple = ['d3869b', 13]
        let s:gb.aqua   = ['8ec07c', 14]
        let s:gb.light1 = ['ebdbb2', 15]
    endif

    if g:boombox_contrast == 'soft'
        let s:gb.dark0  = ['32302f', 236]     " 50-48-47
    endif

    if g:boombox_contrast == 'hard'
        let s:gb.dark0  = ['1d2021', 234]     " 29-32-33
    endif

    if g:boombox_contrast_dark == 'soft'
        let s:gb.dark0  = ['32302f', 236]     " 50-48-47
    endif

    if g:boombox_contrast_dark == 'hard'
        let s:gb.dark0  = ['1d2021', 234]     " 29-32-33
    endif
else
    let s:gb.dark0  = ['fbf1c7', 229]     " 251-241-199
    let s:gb.dark1  = ['ebdbb2', 223]     " 235-219-178
    let s:gb.dark2  = ['d5c4a1', 250]     " 213-196-161
    let s:gb.dark3  = ['bdae93', 248]     " 189-174-147
    let s:gb.dark4  = ['a89984', 246]     " 168-153-132

    let s:gb.medium = ['928374', 244]     " 146-131-116

    let s:gb.light0 = ['282828', 235]     " 40-40-40
    let s:gb.light1 = ['3c3836', 237]     " 60-56-54
    let s:gb.light2 = ['504945', 239]     " 80-73-69
    let s:gb.light3 = ['665c54', 241]     " 102-92-84
    let s:gb.light4 = ['7c6f64', 243]     " 124-111-100

    let s:gb.light4_256 = ['7c6f64', 243] " 124-111-100

    let s:gb.red    = ['9d0006', 88]      " 157-0-6
    let s:gb.green  = ['5fd700', 76]      " 95-215-0
    let s:gb.yellow = ['b57614', 136]     " 181-118-20
    let s:gb.blue   = ['87afff', 111]     " 135-175-255
    let s:gb.purple = ['af5fff', 135]     " 175-95-255
    let s:gb.aqua   = ['427b58', 66]      " 66-123-88
    let s:gb.orange = ['af3a03', 130]     " 175-58-3

    if g:boombox_termcolors == 16
        let s:gb.dark0  = ['fbf1c7', 0]
        let s:gb.light4 = ['7c6f64', 7]
        let s:gb.medium = ['928374', 8]
        let s:gb.red    = ['9d0006', 9]
        let s:gb.green  = ['79740e', 10]
        let s:gb.yellow = ['b57614', 11]
        let s:gb.blue   = ['076678', 12]
        let s:gb.purple = ['8f3f71', 13]
        let s:gb.aqua   = ['427b58', 14]
        let s:gb.light1 = ['3c3836', 15]
    endif

    if g:boombox_contrast == 'soft'
        let s:gb.dark0  = ['f2e5bc', 228]     " 242-229-188
    endif

    if g:boombox_contrast == 'hard'
        let s:gb.dark0  = ['f9f5d7', 230]     " 249-245-215
    endif

    if g:boombox_contrast_light == 'soft'
        let s:gb.dark0  = ['f2e5bc', 228]     " 242-229-188
    endif

    if g:boombox_contrast_light == 'hard'
        let s:gb.dark0  = ['f9f5d7', 230]     " 249-245-215
    endif
endif

" }}}
" Highlighting Function: {{{

function! s:HL(group, fg, ...)
    " Arguments: group, guifg, guibg, gui, guisp

    let histring = 'hi ' . a:group . ' '

    if strlen(a:fg)
        if a:fg == 'fg'
            let histring .= 'guifg=fg ctermfg=fg '
        elseif a:fg == 'bg'
            let histring .= 'guifg=bg ctermfg=bg '
        elseif a:fg == 'none'
            let histring .= 'guifg=NONE ctermfg=NONE '
        else
            let c = get(s:gb, a:fg)
            let histring .= 'guifg=#' . c[0] . ' ctermfg=' . c[1] . ' '
        endif
    endif

    if a:0 >= 1 && strlen(a:1)
        if a:1 == 'bg'
            let histring .= 'guibg=bg ctermbg=bg '
        elseif a:fg == 'fg'
            let histring .= 'guibg=fg ctermbg=fg '
        elseif a:1 == 'none'
            let histring .= 'guibg=NONE ctermbg=NONE '
        else
            let c = get(s:gb, a:1)
            let histring .= 'guibg=#' . c[0] . ' ctermbg=' . c[1] . ' '
        endif
    else
        let histring .= 'guibg=NONE ctermbg=NONE '
    endif

    " Hotfixing #24;
    " TODO: get rid of this spaghetti
    if a:0 >= 2 && strlen(a:2)
        if a:2 == 'none'
            let histring .= 'gui=NONE cterm=NONE '
        elseif a:2 == 'italic' && g:boombox_italic == 0
            let histring .= 'gui=NONE cterm=NONE '
        elseif a:2 == 'bold' && g:boombox_bold == 0
            let histring .= 'gui=NONE cterm=NONE '
        elseif a:2 == 'bold,inverse' && g:boombox_bold == 0
            let histring .= 'gui=inverse cterm=inverse '
        elseif a:2 == 'undercurl' && g:boombox_undercurl == 0
            let histring .= 'gui=NONE cterm=NONE '
        elseif a:2 == 'underline' && g:boombox_underline == 0
            let histring .= 'gui=NONE cterm=NONE '
        elseif a:2 == 'bold,italic'
            if g:boombox_italic == 0 && g:boombox_bold == 0
                let histring .= 'gui=NONE cterm=NONE '
            elseif g:boombox_italic == 0
                let histring .= 'gui=bold cterm=bold '
            elseif g:boombox_bold == 0
                let histring .= 'gui=italic cterm=italic '
            else
                let histring .= 'gui=' . a:2 . ' cterm=' . a:2 . ' '
            endif
        elseif a:2 == 'bold,underline'
            if g:boombox_underline == 0 && g:boombox_bold == 0
                let histring .= 'gui=NONE cterm=NONE '
            elseif g:boombox_underline == 0
                let histring .= 'gui=bold cterm=bold '
            elseif g:boombox_bold == 0
                let histring .= 'gui=underline cterm=underline '
            else
                let histring .= 'gui=' . a:2 . ' cterm=' . a:2 . ' '
            endif
        elseif a:2 == 'underline,italic'
            if g:boombox_underline == 0 && g:boombox_italic == 0
                let histring .= 'gui=NONE cterm=NONE '
            elseif g:boombox_underline == 0
                let histring .= 'gui=italic cterm=italic '
            elseif g:boombox_italic == 0
                let histring .= 'gui=underline cterm=underline '
            else
                let histring .= 'gui=' . a:2 . ' cterm=' . a:2 . ' '
            endif
        elseif a:2 == 'bold,underline,italic'
            if g:boombox_italic == 0 && g:boombox_bold == 0
                let histring .= 'gui=underline cterm=underline '
            elseif g:boombox_italic == 0
                let histring .= 'gui=bold,underline cterm=bold,underline '
            elseif g:boombox_bold == 0
                let histring .= 'gui=italic,underline cterm=italic,underline '
            else
                let histring .= 'gui=' . a:2 . ' cterm=' . a:2 . ' '
            endif
        else
            let histring .= 'gui=' . a:2 . ' cterm=' . a:2 . ' '
        endif
    else
        let histring .= 'gui=NONE cterm=NONE '
    endif

    if a:0 >= 3 && strlen(a:3)
        if a:3 == 'none'
            let histring .= 'guisp=NONE '
        else
            let c = get(s:gb, a:3)
            let histring .= 'guisp=#' . c[0] . ' '
        endif
    endif

    execute histring
endfunction

" }}}

" Vanilla colorscheme ---------------------------------------------------------
" General UI: {{{

" Normal text
call s:HL('Normal', 'light1', 'dark0')

" Correct background (see issue #7):
" --- Problem with changing between dark and light on 256 color terminal
" --- https://github.com/morhetz/boombox/issues/7
if s:is_dark
    set background=dark
else
    set background=light
endif

if version >= 700
    " Screen line that the cursor is
    call s:HL('CursorLine',   'none', 'dark1')
    " Screen column that the cursor is
    call s:HL('CursorColumn', 'none', 'dark1')

if g:boombox_invert_tabline == 0
    " Tab pages line filler
    call s:HL('TabLineFill', 'dark1', 'bg')
    " Active tab page label
    call s:HL('TabLineSel', 'light3', 'dark2', 'bold')
    " Not active tab page label
    call s:HL('TabLine', 'dark3', 'dark1')
else
    call s:HL('TabLineFill', 'bg', 'dark1')
    call s:HL('TabLineSel', 'dark2', 'light3', 'bold')
    call s:HL('TabLine', 'dark1', 'dark3')
endif

    " Match paired bracket under the cursor
    call s:HL('MatchParen', 'none', 'dark3', 'bold')
endif

if version >= 703
    " Highlighted screen columns
    call s:HL('ColorColumn',  'none', g:boombox_color_column)

    " Concealed element: \lambda → λ
    call s:HL('Conceal', 'blue', 'none')

    " Line number of CursorLine
    call s:HL('CursorLineNr', 'yellow', 'dark1')
endif

call s:HL('NonText',    'dark2')
call s:HL('SpecialKey', 'dark2')

if g:boombox_invert_selection == 0
    call s:HL('Visual',    'none',  'dark2')
    call s:HL('VisualNOS', 'none',  'dark2')
else
    call s:HL('Visual',    'none',  'dark3', 'inverse')
    call s:HL('VisualNOS', 'none',  'dark3', 'inverse')
endif

call s:HL('Search',    'dark0', 'yellow')
call s:HL('IncSearch', 'dark0', g:boombox_hls_cursor)

call s:HL('Underlined', 'blue', 'none', 'underline')

call s:HL('StatusLine',   'dark4', 'dark0', 'bold,inverse')
call s:HL('StatusLineNC', 'dark2', 'light4', 'bold,inverse')

" The column separating vertically split windows
call s:HL('VertSplit', 'light4', g:boombox_vert_split)

" Current match in wildmenu completion
call s:HL('WildMenu', 'blue', 'dark2', 'bold')

" Directory names, special names in listing
call s:HL('Directory', 'green', 'none', 'bold')

" Titles for output from :set all, :autocmd, etc.
call s:HL('Title', 'green', 'none', 'bold')

" Error messages on the command line
call s:HL('ErrorMsg',   'bg', 'red', 'bold')
" More prompt: -- More --
call s:HL('MoreMsg',    'yellow', 'none', 'bold')
" Current mode message: -- INSERT --
call s:HL('ModeMsg',    'yellow', 'none', 'bold')
" 'Press enter' prompt and yes/no questions
call s:HL('Question',   'orange', 'none', 'bold')
" Warning messages
call s:HL('WarningMsg', 'red', 'none', 'bold')

" }}}
" Gutter: {{{

" Line number for :number and :# commands
call s:HL('LineNr', 'light2', 'dark1')

" Column where signs are displayed
call s:HL('SignColumn', 'none', g:boombox_sign_column)

" Line used for closed folds
call s:HL('Folded', 'medium', 'dark1', 'italic')
" Column where folds are displayed
call s:HL('FoldColumn', 'medium', 'dark1')

" }}}
" Cursor: {{{

" Character under cursor
call s:HL('Cursor', 'none', 'none', 'inverse')
" Visual mode cursor, selection
call s:HL('vCursor', 'none', 'none', 'inverse')
" Input moder cursor
call s:HL('iCursor', 'none', 'none', 'inverse')
" Language mapping cursor
call s:HL('lCursor', 'none', 'none', 'inverse')

" }}}
" Syntax Highlighting: {{{

if g:boombox_improved_strings == 0
    call s:HL('Special', 'orange')
else
    call s:HL('Special', 'dark1', 'orange', 'italic')
endif

if g:boombox_italicize_comments == 0
    call s:HL('Comment', 'medium', 'none')
else
    call s:HL('Comment', 'medium', 'none', 'italic')
endif
call s:HL('Todo', 'fg', 'bg', 'bold')
call s:HL('Error', 'bg', 'red', 'bold')

" Generic statement
call s:HL('Statement',   'red')
" if, then, else, endif, swicth, etc.
call s:HL('Conditional', 'red')
" for, do, while, etc.
call s:HL('Repeat',      'red')
" case, default, etc.
call s:HL('Label',       'red')
" try, catch, throw
call s:HL('Exception',   'red')
" sizeof, "+", "*", etc.
hi! link Operator Normal
" Any other keyword
call s:HL('Keyword',     'red')

" Variable name
call s:HL('Identifier', 'blue')
" Function name
call s:HL('Function',   'green', 'none', 'bold')

" Generic preprocessor
call s:HL('PreProc',   'aqua')
" Preprocessor #include
call s:HL('Include',   'aqua')
" Preprocessor #define
call s:HL('Define',    'aqua')
" Same as Define
call s:HL('Macro',     'aqua')
" Preprocessor #if, #else, #endif, etc.
call s:HL('PreCondit', 'aqua')

" Generic constant
call s:HL('Constant',  'purple')
" Character constant: 'c', '/n'
call s:HL('Character', 'purple')
" String constant: "this is a string"
if g:boombox_italicize_strings == 0
    call s:HL('String',  'green')
else
    if g:boombox_improved_strings == 0
        call s:HL('String',  'green', 'none', 'italic')
    else
        call s:HL('String',  'dark1', 'light1', 'italic')
    endif
endif
" Boolean constant: TRUE, false
call s:HL('Boolean',   'purple')
" Number constant: 234, 0xff
call s:HL('Number',    'purple')
" Floating point constant: 2.3e10
call s:HL('Float',     'purple')

" Generic type
call s:HL('Type', 'yellow')
" static, register, volatile, etc
call s:HL('StorageClass', 'orange')
" struct, union, enum, etc.
call s:HL('Structure', 'aqua')
" typedef
call s:HL('Typedef', 'yellow')

" }}}
" Completion Menu: {{{

if version >= 700
    " Popup menu: normal item
    call s:HL('Pmenu', 'light1', 'dark2')
    " Popup menu: selected item
    call s:HL('PmenuSel', 'dark2', 'blue', 'bold')
    " Popup menu: scrollbar
    call s:HL('PmenuSbar', 'none', 'dark2')
    " Popup menu: scrollbar thumb
    call s:HL('PmenuThumb', 'none', 'dark4')
endif

" }}}
" Diffs: {{{

call s:HL('DiffDelete', 'dark0', 'red')
call s:HL('DiffAdd',    'dark0', 'green')
"call s:HL('DiffChange', 'dark0', 'blue')
"call s:HL('DiffText',   'dark0', 'yellow')

" Alternative setting
call s:HL('DiffChange', 'dark0', 'aqua')
call s:HL('DiffText',   'dark0', 'yellow')

" }}}
" Spelling: {{{

if has("spell")
    " Not capitalised word, or compile warnings
    if g:boombox_improved_warnings == 0
        call s:HL('SpellCap',   'none', 'none', 'undercurl', 'red')
    else
        call s:HL('SpellCap',   'green', 'none', 'italic,bold')
    endif
    " Not recognized word
    call s:HL('SpellBad',   'none', 'none', 'undercurl', 'blue')
    " Wrong spelling for selected region
    call s:HL('SpellLocal', 'none', 'none', 'undercurl', 'aqua')
    " Rare word
    call s:HL('SpellRare',  'none', 'none', 'undercurl', 'purple')
endif

" }}}

" Plugin specific -------------------------------------------------------------
" EasyMotion: {{{

hi! link EasyMotionTarget Search
hi! link EasyMotionShade Comment

" }}}
" Sneak: {{{

hi! link SneakPluginTarget Search
hi! link SneakStreakTarget Search
call s:HL('SneakStreakMask', 'yellow', 'yellow')
hi! link SneakStreakStatusLine Search

" }}}
" Indent Guides: {{{

if !exists('g:indent_guides_auto_colors')
    let g:indent_guides_auto_colors = 0
endif

if g:indent_guides_auto_colors == 0
    if g:boombox_invert_indent_guides == 0
        call s:HL('IndentGuidesOdd', 'bg', 'dark2')
        call s:HL('IndentGuidesEven', 'bg', 'dark1')
    else
        call s:HL('IndentGuidesOdd', 'bg', 'dark2', 'inverse')
        call s:HL('IndentGuidesEven', 'bg', 'dark3', 'inverse')
    endif
endif

" }}}
" IndentLine: {{{

let g:indentLine_color_term = s:gb.dark2[1]
let g:indentLine_color_gui = '#' . s:gb.dark2[0]

" }}}
" Rainbow Parentheses: {{{

if !exists('g:rbpt_colorpairs')
    let g:rbpt_colorpairs =
        \ [
            \ ['blue', '#458588'], ['magenta', '#b16286'],
            \ ['red',  '#cc241d'], ['166',     '#d65d0e']
        \ ]
endif

let g:rainbow_guifgs = [ '#d65d0e', '#cc241d', '#b16286', '#458588' ]
let g:rainbow_ctermfgs = [ '166', 'red', 'magenta', 'blue' ]

if !exists('g:rainbow_conf')
   let g:rainbow_conf = {}
endif
if !has_key(g:rainbow_conf, 'guifgs')
   let g:rainbow_conf['guifgs'] = g:rainbow_guifgs
endif
if !has_key(g:rainbow_conf, 'ctermfgs')
   let g:rainbow_conf['ctermfgs'] = g:rainbow_ctermfgs
endif

let g:niji_dark_colours = g:rbpt_colorpairs
let g:niji_light_colours = g:rbpt_colorpairs

"}}}
" GitGutter: {{{

if g:boombox_invert_signs == 0
    call s:HL('GitGutterAdd', 'green', g:boombox_sign_column)
    call s:HL('GitGutterChange', 'aqua', g:boombox_sign_column)
    call s:HL('GitGutterDelete', 'red', g:boombox_sign_column)
    call s:HL('GitGutterChangeDelete', 'aqua', g:boombox_sign_column)
else
    call s:HL('GitGutterAdd', 'green', g:boombox_sign_column, 'inverse')
    call s:HL('GitGutterChange', 'aqua', g:boombox_sign_column, 'inverse')
    call s:HL('GitGutterDelete', 'red', g:boombox_sign_column, 'inverse')
    call s:HL('GitGutterChangeDelete', 'aqua', g:boombox_sign_column, 'inverse')
endif

" }}}
" gitcommit highlighting "{{{

call s:HL('gitcommitSelectedFile', 'green')
call s:HL('gitcommitDiscardedFile', 'red')

" }}}
" Signify: {{{

if g:boombox_invert_signs == 0
    call s:HL('SignifySignAdd', 'green', g:boombox_sign_column)
    call s:HL('SignifySignChange ', 'aqua', g:boombox_sign_column)
    call s:HL('SignifySignDelete', 'red', g:boombox_sign_column)
else
    call s:HL('SignifySignAdd', 'green', g:boombox_sign_column, 'inverse')
    call s:HL('SignifySignChange ', 'aqua', g:boombox_sign_column, 'inverse')
    call s:HL('SignifySignDelete', 'red', g:boombox_sign_column, 'inverse')
endif

" }}}
" Syntastic: {{{

call s:HL('SyntasticError', 'none', 'none', 'undercurl', 'red')
call s:HL('SyntasticWarning', 'none', 'none', 'undercurl', 'yellow')

if g:boombox_invert_signs == 0
    call s:HL('SyntasticErrorSign', 'red', g:boombox_sign_column)
    call s:HL('SyntasticWarningSign', 'yellow', g:boombox_sign_column)
else
    call s:HL('SyntasticErrorSign', 'red', g:boombox_sign_column, 'inverse')
    call s:HL('SyntasticWarningSign', 'yellow', g:boombox_sign_column, 'inverse')
endif

" }}}
" Signature: {{{

if g:boombox_invert_signs == 0
    call s:HL('SignatureMarkerText', 'purple', g:boombox_sign_column)
    call s:HL('SignatureMarkText', 'blue', g:boombox_sign_column)
else
    call s:HL('SignatureMarkerText', 'purple', g:boombox_sign_column, 'inverse')
    call s:HL('SignatureMarkText', 'blue', g:boombox_sign_column, 'inverse')
endif

let g:SignatureMarkerTextHL='"SignatureMarkerText"'
let g:SignatureMarkTextHL='"SignatureMarkText"'

" }}}
" ShowMarks: {{{

if g:boombox_invert_signs == 0
    call s:HL('ShowMarksHLl', 'blue', g:boombox_sign_column)
    call s:HL('ShowMarksHLu', 'blue', g:boombox_sign_column)
    call s:HL('ShowMarksHLo', 'blue', g:boombox_sign_column)
    call s:HL('ShowMarksHLm', 'blue', g:boombox_sign_column)
else
    call s:HL('ShowMarksHLl', 'blue', g:boombox_sign_column, 'inverse')
    call s:HL('ShowMarksHLu', 'blue', g:boombox_sign_column, 'inverse')
    call s:HL('ShowMarksHLo', 'blue', g:boombox_sign_column, 'inverse')
    call s:HL('ShowMarksHLm', 'blue', g:boombox_sign_column, 'inverse')
endif

" }}}
" CtrlP: {{{

call s:HL('CtrlPMatch', 'yellow')
call s:HL('CtrlPNoEntries', 'red')
call s:HL('CtrlPPrtBase', 'dark2')
call s:HL('CtrlPPrtCursor', 'blue')
call s:HL('CtrlPLinePre', 'dark2')

call s:HL('CtrlPMode1', 'blue', 'dark2', 'bold')
call s:HL('CtrlPMode2', 'dark0', 'blue', 'bold')
call s:HL('CtrlPStats', 'light4', 'dark2', 'bold')

" }}}
" Startify: {{{

call s:HL('StartifyBracket', 'light3')
call s:HL('StartifyFile', 'light0')
call s:HL('StartifyNumber', 'blue')
call s:HL('StartifyPath', 'medium')
call s:HL('StartifySlash', 'medium')
call s:HL('StartifySection', 'yellow')
call s:HL('StartifySpecial', 'dark2')
call s:HL('StartifyHeader', 'orange')
call s:HL('StartifyFooter', 'dark2')

" }}}
" Vimshell: {{{

let g:vimshell_escape_colors = map(split(
    \ 'dark4 red green yellow blue purple aqua light4 ' .
    \ 'dark0 red green orange blue purple aqua light0'
    \ ), '"#" . s:gb[v:val][0]')

" }}}

" Filetype specific -----------------------------------------------------------
" Diff: {{{

call s:HL('diffAdded', 'green')
call s:HL('diffRemoved', 'red')
call s:HL('diffChanged', 'aqua')

call s:HL('diffFile', 'orange')
call s:HL('diffNewFile', 'yellow')

call s:HL('diffLine', 'blue')

" }}}
" Html: {{{

call s:HL('htmlTag', 'blue')
call s:HL('htmlEndTag', 'blue')

call s:HL('htmlTagName', 'aqua', 'none', 'bold')
call s:HL('htmlArg', 'aqua')

call s:HL('htmlScriptTag', 'purple')
call s:HL('htmlTagN', 'light1')
call s:HL('htmlSpecialTagName', 'aqua', 'none', 'bold')

call s:HL('htmlLink', 'light4', 'none', 'underline')

call s:HL('htmlSpecialChar', 'orange')

call s:HL('htmlBold', 'fg', 'bg', 'bold')
call s:HL('htmlBoldUnderline', 'fg', 'bg', 'bold,underline')
call s:HL('htmlBoldItalic', 'fg', 'bg', 'bold,italic')
call s:HL('htmlBoldUnderlineItalic', 'fg', 'bg', 'bold,underline,italic')

call s:HL('htmlUnderline', 'fg', 'bg', 'underline')
call s:HL('htmlUnderlineItalic', 'fg', 'bg', 'underline,italic')
call s:HL('htmlItalic', 'fg', 'bg', 'italic')

" }}}
" Xml: {{{

call s:HL('xmlTag', 'blue')
call s:HL('xmlEndTag', 'blue')
call s:HL('xmlTagName', 'blue')
call s:HL('xmlEqual', 'blue')
call s:HL('docbkKeyword', 'aqua', 'none', 'bold')

call s:HL('xmlDocTypeDecl', 'medium')
call s:HL('xmlDocTypeKeyword', 'purple')
call s:HL('xmlCdataStart', 'medium')
call s:HL('xmlCdataCdata', 'purple')
call s:HL('dtdFunction', 'medium')
call s:HL('dtdTagName', 'purple')

call s:HL('xmlAttrib', 'aqua')
call s:HL('xmlProcessingDelim', 'medium')
call s:HL('dtdParamEntityPunct', 'medium')
call s:HL('dtdParamEntityDPunct', 'medium')
call s:HL('xmlAttribPunct', 'medium')

call s:HL('xmlEntity', 'orange')
call s:HL('xmlEntityPunct', 'orange')
" }}}
" Vim: {{{

if g:boombox_italicize_comments == 0
    call s:HL('vimCommentTitle', 'light4_256', 'none', 'bold')
else
    call s:HL('vimCommentTitle', 'light4_256', 'none', 'bold,italic')
endif
call s:HL('vimNotation', 'orange')
call s:HL('vimBracket', 'orange')
call s:HL('vimMapModKey', 'orange')
call s:HL('vimFuncSID', 'light3')
call s:HL('vimSetSep', 'light3')
call s:HL('vimSep', 'light3')
call s:HL('vimContinue', 'light3')

" }}}
" Clojure: {{{

call s:HL('clojureKeyword', 'blue')
call s:HL('clojureCond', 'orange')
call s:HL('clojureSpecial', 'orange')
call s:HL('clojureDefine', 'orange')

call s:HL('clojureFunc', 'yellow')
call s:HL('clojureRepeat', 'yellow')
call s:HL('clojureCharacter', 'aqua')
call s:HL('clojureStringEscape', 'aqua')
call s:HL('clojureException', 'red')

call s:HL('clojureRegexp', 'aqua')
call s:HL('clojureRegexpEscape', 'aqua')
call s:HL('clojureRegexpCharClass', 'light3', 'none', 'bold')
call s:HL('clojureRegexpMod', 'light3', 'none', 'bold')
call s:HL('clojureRegexpQuantifier', 'light3', 'none', 'bold')

call s:HL('clojureParen', 'light3')
call s:HL('clojureAnonArg', 'yellow')
call s:HL('clojureVariable', 'blue')
call s:HL('clojureMacro', 'orange')

call s:HL('clojureMeta', 'yellow')
call s:HL('clojureDeref', 'yellow')
call s:HL('clojureQuote', 'yellow')
call s:HL('clojureUnquote', 'yellow')

" }}}
" C: {{{

call s:HL('cOperator', 'purple')
call s:HL('cStructure', 'orange')

" }}}
" Python: {{{

call s:HL('pythonBuiltin', 'orange')
call s:HL('pythonBuiltinObj', 'orange')
call s:HL('pythonBuiltinFunc', 'orange')
call s:HL('pythonFunction', 'aqua')
call s:HL('pythonDecorator', 'red')
call s:HL('pythonInclude', 'blue')
call s:HL('pythonImport', 'blue')
call s:HL('pythonRun', 'blue')
call s:HL('pythonCoding', 'blue')
call s:HL('pythonOperator', 'red')
call s:HL('pythonExceptions', 'purple')
call s:HL('pythonBoolean', 'purple')
call s:HL('pythonDot', 'light3')

" }}}
" CSS: {{{

call s:HL('cssBraces', 'blue')
call s:HL('cssFunctionName', 'yellow')
call s:HL('cssIdentifier', 'orange')
call s:HL('cssClassName', 'green')
call s:HL('cssColor', 'blue')
call s:HL('cssSelectorOp', 'blue')
call s:HL('cssSelectorOp2', 'blue')
call s:HL('cssImportant', 'green')
call s:HL('cssVendor', 'light1')

call s:HL('cssTextProp', 'aqua')
call s:HL('cssAnimationProp', 'aqua')
call s:HL('cssUIProp', 'yellow')
call s:HL('cssTransformProp', 'aqua')
call s:HL('cssTransitionProp', 'aqua')
call s:HL('cssPrintProp', 'aqua')
call s:HL('cssPositioningProp', 'yellow')
call s:HL('cssBoxProp', 'aqua')
call s:HL('cssFontDescriptorProp', 'aqua')
call s:HL('cssFlexibleBoxProp', 'aqua')
call s:HL('cssBorderOutlineProp', 'aqua')
call s:HL('cssBackgroundProp', 'aqua')
call s:HL('cssMarginProp', 'aqua')
call s:HL('cssListProp', 'aqua')
call s:HL('cssTableProp', 'aqua')
call s:HL('cssFontProp', 'aqua')
call s:HL('cssPaddingProp', 'aqua')
call s:HL('cssDimensionProp', 'aqua')
call s:HL('cssRenderProp', 'aqua')
call s:HL('cssColorProp', 'aqua')
call s:HL('cssGeneratedContentProp', 'aqua')

" }}}
" JavaScript: {{{

call s:HL('javaScriptBraces', 'orange')
call s:HL('javaScriptFunction', 'aqua')
call s:HL('javaScriptIdentifier', 'red')
call s:HL('javaScriptMember', 'blue')
call s:HL('javaScriptNumber', 'purple')
call s:HL('javaScriptNull', 'purple')
call s:HL('javaScriptParens', 'light3')

" }}}
" CoffeeScript: {{{

call s:HL('coffeeExtendedOp', 'light3')
call s:HL('coffeeSpecialOp', 'light3')
call s:HL('coffeeCurly', 'orange')
call s:HL('coffeeParen', 'light3')
call s:HL('coffeeBracket', 'orange')

" }}}
" Ruby: {{{

call s:HL('rubyStringDelimiter', 'green')
call s:HL('rubyInterpolationDelimiter', 'aqua')

" }}}
" ObjectiveC: {{{

call s:HL('objcTypeModifier', 'red')
call s:HL('objcDirective', 'blue')

" }}}
" Go: {{{

call s:HL('goDirective', 'aqua')
call s:HL('goConstants', 'purple')
call s:HL('goDeclaration', 'red')
call s:HL('goDeclType', 'blue')
call s:HL('goBuiltins', 'orange')

" }}}
" Lua: {{{

call s:HL('luaIn', 'red')
call s:HL('luaFunction', 'aqua')
call s:HL('luaTable', 'orange')

" }}}
" MoonScript: {{{

call s:HL('moonSpecialOp', 'light3')
call s:HL('moonExtendedOp', 'light3')
call s:HL('moonFunction', 'light3')
call s:HL('moonObject', 'yellow')

" }}}
" Java: {{{

call s:HL('javaAnnotation', 'blue')
call s:HL('javaDocTags', 'aqua')
hi! link javaCommentTitle vimCommentTitle
call s:HL('javaParen', 'light3')
call s:HL('javaParen1', 'light3')
call s:HL('javaParen2', 'light3')
call s:HL('javaParen3', 'light3')
call s:HL('javaParen4', 'light3')
call s:HL('javaParen5', 'light3')
call s:HL('javaOperator', 'orange')

call s:HL('javaVarArg', 'green')

" }}}
" Elixir: {{{

hi! link elixirDocString Comment

call s:HL('elixirStringDelimiter', 'green')
call s:HL('elixirInterpolationDelimiter', 'aqua')

" }}}
" Scala: {{{

" NB: scala vim syntax file is kinda horrible
call s:HL('scalaNameDefinition', 'light1')
call s:HL('scalaCaseFollowing', 'light1')
call s:HL('scalaCapitalWord', 'light1')
call s:HL('scalaTypeExtension', 'light1')

call s:HL('scalaKeyword', 'red')
call s:HL('scalaKeywordModifier', 'red')

call s:HL('scalaSpecial', 'aqua')
call s:HL('scalaOperator', 'light1')

call s:HL('scalaTypeDeclaration', 'yellow')
call s:HL('scalaTypeTypePostDeclaration', 'yellow')

call s:HL('scalaInstanceDeclaration', 'light1')
call s:HL('scalaInterpolation', 'aqua')

" }}}
" Markdown: {{{

call s:HL('markdownItalic', 'light3', 'none', 'italic')

call s:HL('markdownH1', 'green', 'none', 'bold')
call s:HL('markdownH2', 'green', 'none', 'bold')
call s:HL('markdownH3', 'yellow', 'none', 'bold')
call s:HL('markdownH4', 'yellow', 'none', 'bold')
call s:HL('markdownH5', 'yellow')
call s:HL('markdownH6', 'yellow')

call s:HL('markdownCode', 'aqua')
call s:HL('markdownCodeBlock', 'aqua')
call s:HL('markdownCodeDelimiter', 'aqua')

call s:HL('markdownBlockquote', 'medium')
call s:HL('markdownListMarker', 'medium')
call s:HL('markdownOrderedListMarker', 'medium')
call s:HL('markdownRule', 'medium')
call s:HL('markdownHeadingRule', 'medium')

call s:HL('markdownUrlDelimiter', 'light3')
call s:HL('markdownLinkDelimiter', 'light3')
call s:HL('markdownLinkTextDelimiter', 'light3')

call s:HL('markdownHeadingDelimiter', 'orange')
call s:HL('markdownUrl', 'purple')
call s:HL('markdownUrlTitleDelimiter', 'green')

call s:HL('markdownLinkText', 'medium', 'none', 'underline')
call s:HL('markdownIdDeclaration', 'medium', 'none', 'underline')

" }}}

" Functions -------------------------------------------------------------------
" Search Highlighting Cursor {{{

function! BoomboxHlsShowCursor()
    call s:HL('Cursor', 'dark0', g:boombox_hls_cursor)
    call s:HL('vCursor', 'dark0', g:boombox_hls_cursor)
    call s:HL('iCursor', 'dark0', g:boombox_hls_cursor)
    call s:HL('lCursor', 'dark0', g:boombox_hls_cursor)
endfunction

function! BoomboxHlsHideCursor()
    call s:HL('Cursor', 'none', 'none', 'inverse')
    call s:HL('vCursor', 'none', 'none', 'inverse')
    call s:HL('iCursor', 'none', 'none', 'inverse')
    call s:HL('lCursor', 'none', 'none', 'inverse')
endfunction

" }}}

" vim: set sw=3 ts=3 sts=3 noet tw=80 ft=vim fdm=marker:
