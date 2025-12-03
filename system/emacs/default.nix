{
  pkgs,
  ...
}: let
  emacs =
    if pkgs.stdenv.isLinux
    then pkgs.emacs-pgtk
    else (pkgs.emacs-git.override {  withNativeCompilation = true; });

  # Custom Emacs packages
  customEmacsPackages = epkgs: {
    acp = epkgs.callPackage ./packages/acp.nix { };
    agent-shell = epkgs.callPackage ./packages/agent-shell.nix {
      acp = (customEmacsPackages epkgs).acp;
      shell-maker = epkgs.shell-maker;
    };
  };
in {
  environment.systemPackages = with pkgs; [
    ((emacsPackagesFor emacs).emacsWithPackages (epkgs: let
      custom = customEmacsPackages epkgs;
    in [
      # Custom packages
      custom.acp
      custom.agent-shell
      # Standard packages
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
      epkgs.shell-maker
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
