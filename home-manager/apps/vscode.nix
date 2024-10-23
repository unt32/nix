{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs; [
      vscode-extensions.github.vscode-pull-request-github
    ];    
  };
}