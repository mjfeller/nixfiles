{
  pkgs,
  ...
}: let
  emacs =
    if pkgs.stdenv.isLinux
    then pkgs.emacs-pgtk
    else (pkgs.emacs-git.override {  withNativeCompilation = true; });
in {
  environment.systemPackages = with pkgs; [
    ((emacsPackagesFor emacs).emacsWithPackages (epkgs: [
      epkgs.cape
      epkgs.comment-dwim-2
      epkgs.consult
      epkgs.corfu
      epkgs.csv-mode
      epkgs.cue-mode
      epkgs.denote
      epkgs.direnv
      epkgs.ef-themes
      epkgs.embark
      epkgs.embark-consult
      epkgs.evil
      epkgs.evil-goggles
      epkgs.evil-surround
      epkgs.evil-textobj-tree-sitter
      epkgs.exec-path-from-shell
      epkgs.focus
      epkgs.git-timemachine
      epkgs.gptel
      epkgs.hcl-mode
      epkgs.helpful
      epkgs.ledger-mode
      epkgs.logos
      epkgs.macrostep
      epkgs.magit
      epkgs.marginalia
      epkgs.markdown-mode
      epkgs.modus-themes
      epkgs.multi-vterm
      epkgs.multiple-cursors
      epkgs.nix-ts-mode
      epkgs.notmuch
      epkgs.ns-auto-titlebar
      epkgs.olivetti
      epkgs.orderless
      epkgs.org-bullets
      epkgs.paren-face
      epkgs.reformatter
      epkgs.restclient
      epkgs.rg
      epkgs.spacious-padding
      epkgs.terraform-mode
      epkgs.tree-sitter
      epkgs.treesit-grammars.with-all-grammars
      epkgs.tsc
      epkgs.vertico
      epkgs.vterm
      epkgs.yasnippet
      epkgs.yasnippet-snippets
      #epkgs.zig-mode
    ]))
  ];
}
