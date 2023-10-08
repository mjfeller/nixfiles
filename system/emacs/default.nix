{
  config,
  pkgs,
  ...
}: {
  services.emacs.enable = true;
  services.emacs.package = with pkgs; ((emacsPackagesFor emacs-unstable).emacsWithPackages (epkgs: [
      epkgs.bind-key
      epkgs.company
      epkgs.company-c-headers
      epkgs.comment-dwim-2
      epkgs.consult
      epkgs.csv-mode
      epkgs.direnv
      epkgs.dockerfile-mode
      epkgs.elfeed
      epkgs.embark
      epkgs.embark-consult
      epkgs.evil
      epkgs.evil-goggles
      epkgs.evil-surround
      epkgs.ggtags
      epkgs.git-timemachine
      epkgs.go-mode
      epkgs.helpful
      epkgs.highlight-indentation
      epkgs.ledger-mode
      epkgs.logos
      epkgs.macrostep
      epkgs.magit
      epkgs.minions
      epkgs.modus-themes
      epkgs.multi-vterm
      epkgs.multiple-cursors
      epkgs.nix-mode
      epkgs.notmuch
      epkgs.olivetti
      epkgs.orderless
      epkgs.org-bullets
      epkgs.org-fancy-priorities
      epkgs.paren-face
      epkgs.racer
      epkgs.restclient
      epkgs.rg
      epkgs.rust-mode
      epkgs.tree-sitter
      epkgs.tree-sitter-langs
      epkgs.use-package
      epkgs.vertico
      epkgs.vterm
      epkgs.yaml-mode
      epkgs.yasnippet
    ]));
}
