{
  config,
  pkgs,
  ...
}: {
  # Zsh is a shell designed for interactive use, although it is also a
  # powerful scripting language. More information can be found on the
  # "Zsh Web Pages" sites.
  programs.zsh = {
    enable = true;
    history.size = 10000;
    history.path = "${config.xdg.cacheHome}/zsh/history";
    dotDir = ".config/zsh";
    sessionVariables = {
      # Setup standard xdg environment variables. This may not be
      # necessary, but can't hurt right?
      XDG_CACHE_HOME = "${config.home.homeDirectory}/.cache";
      XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
      XDG_DATA_HOME = "${config.home.homeDirectory}/.local/share";
      XDG_STATE_HOME = "${config.home.homeDirectory}/.local/state";
      XDG_DOWNLOADS_DIR = "${config.home.homeDirectory}/downloads";
      XDG_DOCUMENTS_DIR = "${config.home.homeDirectory}/documents";
      XDG_CODE_DIR = "${config.home.homeDirectory}/development";

      # Move gnupg files out of the home directory into the xdg data
      # home to keep my home dir cleaner.
      #
      # TODO: There seems to be an issue with the gpg-agent not taking
      # into account the directory gpg data is stored. This currently
      # breaks my gpg setup.
      # GNUPGHOME = "${config.xdg.dataHome}/gnupg";

      # Generally useful environment variables various programs like
      # git, lf, etc use to open files with for certain tasks.
      EDITOR = "emacs";
      VISIAL = "less";
      PAGER = "less";

      SAVEHIST = "10000";
      SHELL_SESSION_HISTORY = "0";
      LC_ALL = "C";

      # Render man pages to have a width of 80 characters. I find it
      # more pleasant to read when not too wide.
      MANWIDTH = "80";

      # Drop the history file for less. This doesn't help me in any way
      # and just clutters the home directory.
      LESSHISTFILE = "-";

      ZSH_COMPDUMP = "~/.cache/zsh/zcompdump-$HOST";

      # pash configuration
      PASH_CLIP = "wl-copy -n";
      PASH_TIMEOUT = "off";

      LS_COLORS = "rs=0:di=36;36:ln=36;51:mh=00:pi=40;36;11:so=36;13:do=36;5:bd=48;236;36;11:cd=48;236;36;3:or=48;236;36;9:mi=01;36;41:su=48;196;36;15:sg=48;11;36;16:ca=48;196;36;226:tw=48;10;36;16:ow=48;10;36;21:st=48;21;36;15:ex=1:*.tar=36;9:*.tgz=36;9:*.arc=36;9:*.arj=36;9:*.taz=36;9:*.lha=36;9:*.lz4=36;9:*.lzh=36;9:*.lzma=36;9:*.tlz=36;9:*.txz=36;9:*.tzo=36;9:*.t7z=36;9:*.zip=36;9:*.z=36;9:*.dz=36;9:*.gz=36;9:*.lrz=36;9:*.lz=36;9:*.lzo=36;9:*.xz=36;9:*.zst=36;9:*.tzst=36;9:*.bz2=36;9:*.bz=36;9:*.tbz=36;9:*.tbz2=36;9:*.tz=36;9:*.deb=36;9:*.rpm=36;9:*.jar=36;9:*.war=36;9:*.ear=36;9:*.sar=36;9:*.rar=36;9:*.alz=36;9:*.ace=36;9:*.zoo=36;9:*.cpio=36;9:*.7z=36;9:*.rz=36;9:*.cab=36;9:*.wim=36;9:*.swm=36;9:*.dwm=36;9:*.esd=36;9:*.jpg=36;13:*.jpeg=36;13:*.mjpg=36;13:*.mjpeg=36;13:*.gif=36;13:*.bmp=36;13:*.pbm=36;13:*.pgm=36;13:*.ppm=36;13:*.tga=36;13:*.xbm=36;13:*.xpm=36;13:*.tif=36;13:*.tiff=36;13:*.png=36;13:*.svg=36;13:*.svgz=36;13:*.mng=36;13:*.pcx=36;13:*.mov=36;13:*.mpg=36;13:*.mpeg=36;13:*.m2v=36;13:*.mkv=36;13:*.webm=36;13:*.ogm=36;13:*.mp4=36;13:*.m4v=36;13:*.mp4v=36;13:*.vob=36;13:*.qt=36;13:*.nuv=36;13:*.wmv=36;13:*.asf=36;13:*.rm=36;13:*.rmvb=36;13:*.flc=36;13:*.avi=36;13:*.fli=36;13:*.flv=36;13:*.gl=36;13:*.dl=36;13:*.xcf=36;13:*.xwd=36;13:*.yuv=36;13:*.cgm=36;13:*.emf=36;13:*.ogv=36;13:*.ogx=36;13:*.aac=36;45:*.au=36;45:*.flac=36;45:*.m4a=36;45:*.mid=36;45:*.midi=36;45:*.mka=36;45:*.mp3=36;45:*.mpc=36;45:*.ogg=36;45:*.ra=36;45:*.wav=36;45:*.oga=36;45:*.opus=36;45:*.spx=36;45:*.xspf=36;45:";
    };
    shellAliases = {
      ls = "ls -F --group-directories-first";
      l = "ls -lAh";
      cp = "cp -iv";
      mv = "mv -iv";
      rm = "rm -iv";
      q = "exit";
      vi = "vim";

      # Youtube download heplers
      yt = "youtube-dl";
      yta = "youtube-dl --extract-audio --audio-quality 0 --audio-format flac --output \"%(title)s.%(ext)s\"";
      ytad = "youtube-dl --extract-audio --audio-quality 0 --audio-format flac --output \"%(title)s [%(upload_date)s].%(ext)s\"";

      # Pash heplers
      fp = "pash copy $(pash list | fzf)";
      fps = "pash show $(pash list | fzf)";

      # Fetch the weather via the command line
      weather = "curl wttr.in/\~Boulder+Colorado";
    };
    initExtra = ''
      source $XDG_CONFIG_HOME/zsh/fzf.zsh
      source $XDG_CONFIG_HOME/zsh/kubernetes.zsh
      source $XDG_CONFIG_HOME/zsh/terraform.zsh
      source $XDG_CONFIG_HOME/zsh/gcloud.zsh

      export PATH=$HOME/.local/bin:$PATH

      update() {
          sudo nixos-rebuild switch --flake '/home/mjf/.config/nixos' --impure
          home-manager switch --flake '/home/mjf/.config/nixos#mjf'
      }

      if [[ "$INSIDE_EMACS" = 'vterm' ]]; then
        alias clear='vterm_printf "51;Evterm-clear-scrollback";tput clear'
      fi

      export NIX_PATH=$HOME/.nix-defexpr/channels''${NIX_PATH:+:}$NIX_PATH
    '';
  };
}
