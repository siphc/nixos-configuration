{pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
  #  (vim-full.customize {
  #    vimrcConfig.customRC = ''
  #    '';
  #  })
    vim-full
  ];
}
