{
  config,
  pkgs,
  ...
}: {
  # mpv is a free (as in freedom) media player for the command line. It
  # supports a wide variety of media file formats, audio and video
  # codecs, and subtitle types.
  programs.mpv = {
    enable = true;
  };

  # Music Player Daemon (MPD) is a flexible, powerful, server-side
  # application for playing music. Through plugins and libraries it can
  # play a variety of sound files while being controlled by its network
  # protocol.
  services.mpd = {
    enable = true;
    musicDirectory = "/var/media/music";
    playlistDirectory = "${config.xdg.configHome}/mpd/playlists";
    extraConfig = ''
      user "mjf"
      port "6600"

      audio_output {
        type	"pipewire"
        name	"PipeWire Sound Server"
      }
    '';
  };

  # Featureful ncurses based MPD client inspired by ncmpc
  programs.ncmpcpp = {
    enable = true;
    mpdMusicDir = "/var/media/music";
    settings = {
      # directories
      ncmpcpp_directory = "${config.xdg.configHome}/ncmpcpp";
      lyrics_directory = "${config.xdg.cacheHome}/ncmpcpp";

      # mpd
      mpd_port = "6600";
      playlist_disable_highlight_delay = 1;
      message_delay_time = 3;

      # formats
      song_status_format = "{%a} • {%t}";
      song_library_format = "%t";
      song_window_title_format = "{%a-%t}";
      song_columns_list_format = "(30)[]{a} (40)[]{t|f} (30)[]{b}";
      alternative_header_first_line_format = "$aqu$/a $b{%t}|{%f}$/b $atq$/a";
      alternative_header_second_line_format = "{%a}";

      # progressbar
      progressbar_look = "─╼ "; # ╼─
      progressbar_color = "black";
      progressbar_elapsed_color = "cyan";

      # ui
      user_interface = "classic";
      header_visibility = "no";
      statusbar_visibility = "yes";
      titles_visibility = "no";
      cyclic_scrolling = "no";
      enable_window_title = "no";
      playlist_display_mode = "columns";
      browser_display_mode = "columns";
      autocenter_mode = "yes";

      # colors
      colors_enabled = "yes";
      statusbar_color = "default";
      alternative_ui_separator_color = "default";
      window_border_color = "default";
      active_window_border = "default";
      color2 = "default";
      color1 = "default";
      main_window_color = "default";
      state_flags_color = "default";
      state_line_color = "default";
      volume_color = "default";
      header_window_color = "default";
      empty_tag_color = "default";

      current_item_prefix = "$(white)$r";
      current_item_suffix = "$/r$(end)";

      # visualizer
      visualizer_output_name = "my_fifo";
      # visualizer_type          = "spectrum";
      visualizer_look = "∙▋";
      visualizer_in_stereo = "yes";

      #execute_on_song_change = "$HOME/.local/bin/notify_mpd";
    };
    bindings = [
      {
        key = "up";
        command = "scroll_up";
      }
      {
        key = "down";
        command = "scroll_down";
      }
      {
        key = "k";
        command = "scroll_up";
      }
      {
        key = "j";
        command = "scroll_down";
      }
      {
        key = "l";
        command = "next_column";
      }
      {
        key = "l";
        command = "enter_directory";
      }
      {
        key = "l";
        command = "toggle_output";
      }
      {
        key = "l";
        command = "run_action";
      }
      {
        key = "l";
        command = "play_item";
      }
      {
        key = "h";
        command = "previous_column";
      }
      {
        key = "h";
        command = "jump_to_parent_directory";
      }
      {
        key = "d";
        command = "delete_playlist_items";
      }
      {
        key = "d";
        command = "delete_browser_items";
      }
      {
        key = "d";
        command = "delete_stored_playlist";
      }
      {
        key = "space";
        command = "add_item_to_playlist";
      }
      {
        key = "space";
        command = "toggle_lyrics_update_on_song_change";
      }
      {
        key = "space";
        command = "toggle_visualization_type";
      }
      {
        key = "right";
        command = "volume_up";
      }
      {
        key = "+";
        command = "volume_up";
      }
      {
        key = "down";
        command = "volume_down";
      }
      {
        key = "-";
        command = "volume_down";
      }
      {
        key = "o";
        command = "master_screen";
      }
      {
        key = "o";
        command = "slave_screen";
      }
      {
        key = "s";
        command = "stop";
      }
      {
        key = "S";
        command = "save_playlist";
      }
      {
        key = "p";
        command = "pause";
      }
      {
        key = ":";
        command = "execute_command";
      }
      {
        key = "f1";
        command = "show_help";
      }
      {
        key = "1";
        command = "show_playlist";
      }
      {
        key = "2";
        command = "show_browser";
      }
      {
        key = "2";
        command = "change_browse_mode";
      }
      {
        key = "3";
        command = "show_search_engine";
      }
      {
        key = "3";
        command = "reset_search_engine";
      }
      {
        key = "4";
        command = "show_media_library";
      }
      {
        key = "4";
        command = "toggle_media_library_columns_mode";
      }
      {
        key = "5";
        command = "show_playlist_editor";
      }
      {
        key = "6";
        command = "show_tag_editor";
      }
      {
        key = "7";
        command = "show_outputs";
      }
      {
        key = "8";
        command = "show_visualizer";
      }
      {
        key = "0";
        command = "show_clock";
      }
      {
        key = "0";
        command = "show_server_info";
      }
      {
        key = "q";
        command = "quit";
      }
      {
        key = ")";
        command = "seek_forward";
      }
      {
        key = "(";
        command = "seek_backward";
      }
      {
        key = "/";
        command = "find";
      }
      {
        key = "/";
        command = "find_item_forward";
      }
      {
        key = "?";
        command = "find";
      }
      {
        key = "?";
        command = "find_item_backward";
      }
      {
        key = "n";
        command = "next_found_item";
      }
      {
        key = "N";
        command = "previous_found_item";
      }
      {
        key = "=";
        command = "sort_playlist";
      }
      {
        key = "backspace";
        command = "jump_to_parent_directory";
      }
      {
        key = "backspace";
        command = "replay_song";
      }
      {
        key = "u";
        command = "update_database";
      }
      {
        key = "e";
        command = "edit_song";
      }
      {
        key = "e";
        command = "edit_library_tag";
      }
      {
        key = "e";
        command = "edit_library_album";
      }
      {
        key = "e";
        command = "edit_directory_name";
      }
      {
        key = "e";
        command = "edit_playlist_name";
      }
      {
        key = "e";
        command = "edit_lyrics";
      }
      {
        key = "i";
        command = "show_song_info";
      }
      {
        key = "I";
        command = "show_artist_info";
      }
      {
        key = "c";
        command = "clear_playlist";
      }
      {
        key = "ctrl-l";
        command = "toggle_screen_lock";
      }
      {
        key = "tab";
        command = "next_screen";
      }
      {
        key = "shift-tab";
        command = "previous_screen";
      }
      {
        key = "s";
        command = "add_selected_items";
      }
      {
        key = "c";
        command = "clear_main_playlist";
      }
      {
        key = "r";
        command = "toggle_repeat";
      }
      {
        key = "z";
        command = "toggle_random";
      }
      {
        key = "y";
        command = "toggle_single";
      }
      {
        key = "R";
        command = "toggle_consume";
      }
      {
        key = "#";
        command = "toggle_bitrate_visibility";
      }
      {
        key = "x";
        command = "toggle_crossfade";
      }
      {
        key = "X";
        command = "set_crossfade";
      }
      {
        key = "g";
        command = "jump_to_position_in_song";
      }
      {
        key = "G";
        command = "jump_to_playing_song";
      }
      {
        key = "b";
        command = "jump_to_playlist_editor";
      }
      {
        key = "!";
        command = "toggle_separators_between_albums";
      }
      {
        key = "L";
        command = "toggle_lyrics_fetcher";
      }

      # { key = "K"; command = "scroll_up scroll_up scroll_up scroll_up"; }
      # { key = "J"; command = "scroll_down scroll_down scroll_down scroll_down"; }
    ];
  };
}
