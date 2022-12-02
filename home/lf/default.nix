{
  config,
  pkgs,
  ...
}: {
  # lf (as in "list files") is a terminal file manager written in Go
  # with a heavy inspiration from ranger file manager.
  programs.lf = {
    enable = true;
    settings = {
      drawbox = false;
      shellopts = "-eu";
      ifs = "\\n";
      scrolloff = 10;
      period = 1;
      hidden = true;
    };
    extraConfig = ''
      set autoquit on
    '';
    commands = {
      rename = "%[ -e $1 ] && printf 'file exists' || mv $f $1";
      delete = ''
        ''${{
          clear
          set -f
          printf "%s\n\t" "$fx"
          printf "delete?[y/N]"
          read ans
          [ $ans = "y" ] && rm -rf $fx
        }}
      '';
      openshell = ''
        ''${{
          set -f
          zsh
        }}
      '';
    };
    keybindings = {
      D = "delete";
      r = "push :rename<space>";
      S = "openshell";
    };
    cmdKeybindings = {
      "c-r" = "reload";
      "c-s" = "set hidden!";
      "enter" = "shell";
    };
    previewer.source = pkgs.writeShellScript "pv.sh" ''
      #!/bin/sh

      case "$1" in
        *.tar*) tar tf "$1" ;;
        *.zip) unzip -l "$1" ;;
        *) bat --color always "$1" ;;
      esac

      case "$(file --dereference --brief --mime-type -- "$1")" in
        image/*) mediainfo "$1" ;;
        */pdf) mediainfo "$1" ;;
      esac
    '';
  };
}
