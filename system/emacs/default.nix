{
  config,
  pkgs,
  ...
}: let
  emacs =
    if pkgs.stdenv.isLinux
    then pkgs.emacs-pgtk
    else pkgs.emacs-git;
in {
  environment.systemPackages = with pkgs; [
    ((emacsPackagesFor emacs).emacsWithPackages (epkgs: [
      epkgs.company
      epkgs.comment-dwim-2
      epkgs.consult
      epkgs.csv-mode
      epkgs.cue-mode
      epkgs.denote
      epkgs.direnv
      epkgs.elfeed
      epkgs.ef-themes
      epkgs.embark
      epkgs.embark-consult
      epkgs.evil
      epkgs.evil-goggles
      epkgs.evil-surround
      epkgs.exec-path-from-shell
      epkgs.git-timemachine
      epkgs.helpful
      epkgs.ledger-mode
      epkgs.logos
      epkgs.macrostep
      epkgs.magit
      epkgs.modus-themes
      epkgs.multi-vterm
      epkgs.multiple-cursors
      epkgs.nix-ts-mode
      epkgs.notmuch
      epkgs.ns-auto-titlebar
      epkgs.olivetti
      epkgs.osm
      epkgs.orderless
      epkgs.org-bullets
      epkgs.paren-face
      epkgs.reformatter
      epkgs.restclient
      epkgs.rg
      epkgs.spacious-padding
      epkgs.treesit-grammars.with-all-grammars
      epkgs.vertico
      epkgs.vterm
      epkgs.zig-mode
    ]))
  ];
}
