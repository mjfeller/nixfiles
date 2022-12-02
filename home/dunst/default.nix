{
  config,
  pkgs,
  ...
}: {
  home.packages = [
    # libnotify provides the useful notify-send command line utility.
    pkgs.libnotify
  ];

  # Dunst is a lightweight replacement for the notification daemons
  # provided by most desktop environments. It’s very customizable, isn’t
  # dependent on any toolkits, and therefore fits into those window
  # manager centric setups we all love to customize to perfection.
  #
  # TODO: Since I'm using sx the X11 DISPLAY should be :1 not the
  # default :0. No idea how to overlay the systemd service to fix it
  # though.
  services.dunst = {
    enable = true;
    waylandDisplay = "wayland-0";
    settings = {
      global = {
        font = "Comic Mono 10";

        # Allow a small subset of html markup:
        #   <b>bold</b>
        #   <i>italic</i>
        #   <s>strikethrough</s>
        #   <u>underline</u>
        #
        # For a complete reference see
        # <http://developer.gnome.org/pango/stable/PangoMarkupFormat.html>.
        # If markup is not allowed, those tags will be stripped out of the
        # message.
        markup = "full";

        # The format of the message.  Possible variables are:
        #   %a  appname
        #   %s  summary
        #   %b  body
        #   %i  iconname (including its path)
        #   %I  iconname (without its path)
        #   %p  progress value if set ([  0%] to [100%]) or nothing
        # Markup is allowed
        format = "<b>%s</b>\\n%b";

        # Sort messages by urgency.
        sort = "no";

        # Show how many messages are currently hidden (because of geometry).
        indicate_hidden = "yes";

        # Alignment of message text.
        # Possible values are "left", "center" and "right".
        alignment = "center";

        # Show age of message if message is older than show_age_threshold
        # seconds.
        # Set to -1 to disable.
        show_age_threshold = -1;

        # Split notifications into multiple lines if they don't fit into
        # geometry.
        word_wrap = "yes";

        # Ignore newlines '\n' in notifications.
        ignore_newline = "no";

        # Hide duplicate's count and stack them
        stack_duplicates = true;
        hide_duplicate_count = true;

        # dynamic width from 0 to 300
        width = 400;

        # The maximum height of a single notification, excluding the frame.
        height = 300;

        # Position the notification in the top right corner
        origin = "top-right";

        # Offset from the origin
        offset = "50x50";

        # The transparency of the window.  Range: [0; 100].
        # This option will only work if a compositing windowmanager is
        # present (e.g. xcompmgr, compiz, etc.).
        transparency = 0;

        # Don't remove messages, if the user is idle (no mouse or keyboard input)
        # for longer than idle_threshold seconds.
        # Set to 0 to disable.
        idle_threshold = 0;

        # Which monitor should the notifications be displayed on.
        monitor = 0;

        # Display notification on focused monitor.  Possible modes are:
        #   mouse: follow mouse pointer
        #   keyboard: follow window with keyboard focus
        #   none: don't follow anything
        #
        # "keyboard" needs a windowmanager that exports the
        # _NET_ACTIVE_WINDOW property.
        # This should be the case for almost all modern windowmanagers.
        #
        # If this option is set to mouse or keyboard, the monitor option
        # will be ignored.
        follow = "none";

        # Should a notification popped up from history be sticky or timeout
        # as if it would normally do.
        sticky_history = "yes";

        # Maximum amount of notifications kept in history
        history_length = 15;

        # Display indicators for URLs (U) and actions (A).
        show_indicators = "no";

        # The height of a single line.  If the height is smaller than the
        # font height, it will get raised to the font height.
        # This adds empty space above and under the text.
        line_height = 3;

        # Draw a line of "separatpr_height" pixel height between two
        # notifications.
        # Set to 0 to disable.
        separator_height = 2;

        # Padding between text and separator.
        padding = 20;

        # Horizontal padding.
        horizontal_padding = 40;

        # Define a color for the separator.
        # possible values are:
        #  * auto: dunst tries to find a color fitting to the background;
        #  * foreground: use the same color as the foreground;
        #  * frame: use the same color as the frame;
        #  * anything else will be interpreted as a X color.
        separator_color = "frame";

        # dmenu path.
        dmenu = "dmenu -p dunst:";

        # Browser for opening urls in context menu.
        browser = "brave -new-tab";

        # Align icons left/right/off
        icon_position = "left";
        max_icon_size = 128;

        frame_width = 1;
        frame_color = "#000000";
      };
      urgency_low = {
        frame_color = "#a8a8a8";
        foreground = "#ffffff";
        background = "#000000";
        timeout = 4;
      };
      ugrency_normal = {
        frame_color = "#a8a8a8";
        foreground = "#ffffff";
        background = "#000000";
        timeout = 6;
      };
      urgency_critical = {
        frame_color = "#cc241d";
        foreground = "#cc241d";
        background = "#282828";
        timeout = 8;
      };
    };
  };
}
