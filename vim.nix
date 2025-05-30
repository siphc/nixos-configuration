{pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    (vim-full.customize {
      vimrcConfig.customRC = ''
        " reminder! the existence of ~/.vimrc ensures that compatibility mode is
        " switched off.

        " indentation
        set tabstop=4
        set shiftwidth=4
        set expandtab
        set smarttab
        set autoindent
        set smartindent

        " backspace
        " allows backspacing over autoindent, line breaks, start of insert
        set backspace=indent,eol,start

        " vanity
        set number
        set relativenumber
        set title
        set showmatch

        " status line
        set laststatus=2
        set ruler

        " show in-progress commands
        set showcmd

        " search
        set ignorecase
        set smartcase
        set hlsearch

        " always keep 8 lines above or below the cursor when scrolling, and when not at
        " the start/end of the file
        set scrolloff=8

        " 'enable' allows custom color settings with :highlight commands
        " 'on', in comparison, uses vim default settings
        syntax enable

        " self explanatory.
        set noswapfile

        " theme
        set noshowmode
        set termguicolors
        set background=dark
        let g:everforest_background='soft'
        " let g:everforest_better_performance=1
        colorscheme everforest
        let g:lightline = {'colorscheme': 'everforest'}

        " .nix 2-width tabs
        au BufNewFile,BufRead *.nix setlocal tabstop=2
        au BufNewFile,BufRead *.nix setlocal shiftwidth=2
      '';
    vimrcConfig.packages.myVimPackage = with pkgs.vimPlugins; {
      start = [
        nerdtree
        lightline-vim
        everforest
        vim-smoothie
        vim-cpp-enhanced-highlight
      ];
    };
  })
  ];
}
