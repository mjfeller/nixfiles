{
  config,
  pkgs,
  ...
}: {
  # Alacritty is a modern terminal emulator that comes with sensible
  # defaults, but allows for extensive configuration. By integrating
  # with other applications, rather than reimplementing their
  # functionality, it manages to provide a flexible set of features with
  # high performance. The supported platforms currently consist of BSD,
  # Linux, macOS and Windows.
  programs.alacritty = {
    enable = true;
    settings = {
      # Configuration for Alacritty, the GPU enhanced terminal emulator

      # Any items in the `env` entry below will be added as
      # environment variables. Some entries may override variables
      # set by alacritty it self.
      env = {
        # TERM env customization.
        #
        # If this property is not set, alacritty will set it to xterm-256color.
        #
        # Note that some xterm terminfo databases don't declare support for italics.
        # You can verify this by checking for the presence of `smso` and `sitm` in
        # `infocmp xterm-256color`.
        TERM = "xterm-256color";
      };

      window = {
        opacity = 1;
        dynamic_title = true;

        # Window dimensions in character columns and lines
        # (changes require restart)
        dimensions = {
          columns = 80;
          lines = 24;
        };

        # Adds this many blank pixels of padding around the window
        # Units are physical pixels; this is not DPI aware.
        # (change requires restart)
        padding = {
          x = 15;
          y = 15;
        };

        # Window decorations
        # Setting this to false will result in window without borders and title bar.
        decorations = "Full";
      };

      # Font configuration (changes require restart)
      font = {
        # The normal (roman) font face to use.
        normal = {
          family = "Iosevka Comfy Wide Motion";
          # Style can be specified to pick a specific face.
          style = "Medium";
        };

        # The bold font face
        bold = {
          family = "Iosevka Comfy Wide Motion";
          # Style can be specified to pick a specific face.
          # style: Bold
        };

        # The italic font face
        italic = {
          family = "Iosevka Comfy Wide Motion";
          # Style can be specified to pick a specific face.
          # style: Italic
        };

        # Point size of the font
        size = 10.0;

        # Offset is the extra space around each character. offset.y can be thought of
        # as modifying the linespacing, and offset.x as modifying the letter spacing.
        offset = {
          x = 0;
          y = 2;
        };

        # Glyph offset determines the locations of the glyphs within their cells with
        # the default being at the bottom. Increase the x offset to move the glyph to
        # the right, increase the y offset to move the glyph upward.
        glyph_offset = {
          x = 0;
          y = 0;
        };
      };

      # Colors (Tomorrow Night Bright)
      colors = {
        # When true, bold text is drawn using the bright variant of colors.
        draw_bold_text_with_bright_colors = true;

        # Default colors
        primary = {
          background = "#000000";
          foreground = "#ffffff";
        };

        # Colors the cursor will use if `custom_cursor_colors` is true
        cursor = {
          text = "#ffffff";
          cursor = "#ffffff";
        };

        # Normal colors
        normal = {
          black = "#100f10";
          red = "#ff8059";
          green = "#44bc44";
          yellow = "#d0bc00";
          blue = "#2fafff";
          magenta = "#feacd0";
          cyan = "#00d3d0";
          white = "#e0e6f0";
        };

        # Bright colors
        bright = {
          black = "#535353";
          red = "#ef8b50";
          green = "#70b900";
          yellow = "#c0c530";
          blue = "#79a8ff";
          magenta = "#f78fe7";
          cyan = "#4ae2f0";
          white = "#a8a8a8";
        };

        # # Dim colors (Optional)
        # dim:
        #   black:   '0x333333'
        #   red:     '0xf2777a'
        #   green:   '0x99cc99'
        #   yellow:  '0xffcc66'
        #   blue:    '0x6699cc'
        #   magenta: '0xcc99cc'
        #   cyan:    '0x66cccc'
        #   white:   '0xdddddd'
      };

      # Visual Bell
      #
      # Any time the BEL code is received, Alacritty "rings" the visual bell. Once
      # rung, the terminal background will be set to white and transition back to the
      # default background color. You can control the rate of this transition by
      # setting the `duration` property (represented in milliseconds). You can also
      # configure the transition function by setting the `animation` property.
      #
      # Possible values for `animation`
      # `Ease`
      # `EaseOut`
      # `EaseOutSine`
      # `EaseOutQuad`
      # `EaseOutCubic`
      # `EaseOutQuart`
      # `EaseOutQuint`
      # `EaseOutExpo`
      # `EaseOutCirc`
      # `Linear`
      #
      # To completely disable the visual bell, set its duration to 0.
      #
      bell = {
        animation = "EaseOutExpo";
        duration = 0;
      };

      mouse = {
        hide_when_typing = true;
        bindings = [
          {
            mouse = "Middle";
            action = "PasteSelection";
          }
        ];
      };

      selection = {
        semantic_escape_chars = ",│`|:\"' ()[]{}<>";
      };

      # Live config reload (changes require restart)
      live_config_reload = true;

      # Shell
      #
      # You can set shell.program to the path of your favorite shell, e.g. /bin/fish.
      # Entries in shell.args are passed unmodified as arguments to the shell.
      #
      shell = {
        program = "zsh";
      };
      #   args:
      #     - --login

      # Key bindings
      #
      # Each binding is defined as an object with some properties. Most of the
      # properties are optional. All of the alphabetical keys should have a letter for
      # the `key` value such as `V`. Function keys are probably what you would expect
      # as well (F1, F2, ..). The number keys above the main keyboard are encoded as
      # `Key1`, `Key2`, etc. Keys on the number pad are encoded `Number1`, `Number2`,
      # etc.  These all match the glutin::VirtualKeyCode variants.
      #
      # A list with all available `key` names can be found here:
      # https://docs.rs/glutin/*/glutin/enum.VirtualKeyCode.html#variants
      #
      # Possible values for `mods`
      # `Command`, `Super` refer to the super/command/windows key
      # `Control` for the control key
      # `Shift` for the Shift key
      # `Alt` and `Option` refer to alt/option
      #
      # mods may be combined with a `|`. For example, requiring control and shift
      # looks like:
      #
      # mods: Control|Shift
      #
      # The parser is currently quite sensitive to whitespace and capitalization -
      # capitalization must match exactly, and piped items must not have whitespace
      # around them.
      #
      # Either an `action`, `chars`, or `command` field must be present.
      #   `action` must be one of `Paste`, `PasteSelection`, `Copy`, or `Quit`.
      #   `chars` writes the specified string every time that binding is activated.
      #     These should generally be escape sequences, but they can be configured to
      #     send arbitrary strings of bytes.
      #   `command` must be a map containing a `program` string, and `args` array of
      #     strings. For example:
      #     - { ... , command: { program: "alacritty", args: ["-e", "vttest"] } }
      #
      #     USE: xxd -psd
      keyboard.bindings = [
        {
          key = "N";
          mods = "Command";
          action = "SpawnNewInstance";
        }
        {
          key = "Return";
          mods = "Command";
          action = "ToggleFullscreen";
        }
        {
          key = "V";
          mods = "Command";
          action = "Paste";
        }
        {
          key = "C";
          mods = "Command";
          action = "Copy";
        }
        {
          key = "Q";
          mods = "Command";
          action = "Quit";
        }
        {
          key = "W";
          mods = "Command";
          action = "Quit";
        }
      ];
    };
  };
}
