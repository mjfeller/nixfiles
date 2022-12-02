{
  config,
  pkgs,
  ...
}: {
  accounts.email = {
    accounts.mjf = {
      primary = true;
      address = "mark@mfeller.io";
      userName = "Mark Feller";
      realName = "Mark Feller";
      notmuch.enable = true;
    };
    maildirBasePath = "${config.xdg.dataHome}/mail";
  };

  # Notmuch is not much of an email program. It doesn't receive messages
  # (no POP or IMAP support). It doesn't send messages (no mail
  # composer, no network code at all). And for what it does do (email
  # search) that work is provided by an external library, Xapian. So if
  # Notmuch provides no user interface and Xapian does all the heavy
  # lifting, then what's left here? Not much.
  programs.notmuch = {
    enable = true;

    # Configuration for "notmuch new"
    #
    # The following options are supported here:
    #
    #	tags	A list (separated by ';') of the tags that will be
    #		added to all messages incorporated by "notmuch new".
    #
    #	ignore	A list (separated by ';') of file and directory names
    #		that will not be searched for messages by "notmuch new".
    #
    #		NOTE: *Every* file/directory that goes by one of those
    #		names will be ignored, independent of its depth/location
    #		in the mail store.
    #
    new.tags = ["unread" "ingox"];

    # Search configuration
    #
    # The following option is supported here:
    #
    #	exclude_tags
    #		A ;-separated list of tags that will be excluded from
    #		search results by default.  Using an excluded tag in a
    #		query will override that exclusion.
    #
    search.excludeTags = ["deleted" "spam"];

    # Maildir compatibility configuration
    #
    # The following option is supported here:
    #
    #	synchronize_flags      Valid values are true and false.
    #
    #	If true, then the following maildir flags (in message filenames)
    #	will be synchronized with the corresponding notmuch tags:
    #
    #		Flag	Tag
    #		----	-------
    #		D	draft
    #		F	flagged
    #		P	passed
    #		R	replied
    #		S	unread (added when 'S' flag is not present)
    #
    #	The "notmuch new" command will notice flag changes in filenames
    #	and update tags, while the "notmuch tag" and "notmuch restore"
    #	commands will notice tag changes and update flags in filenames
    #
    maildir.synchronizeFlags = true;
  };

  # programs.offlineimap.enable = true;

  xdg.configFile."offlineimap/get_settings.py".text = ''
    from subprocess import check_output

    def get_pass(account):
        return check_output("pash show " + account, shell=True).splitlines()[0]
  '';

  xdg.configFile."offlineimap/config".text = ''
    [general]
    accounts = MfellerIo
    metadata = $XDG_CONFIG_HOME/offlineimap/offlineimap
    pythonfile = $XDG_CONFIG_HOME/offlineimap/get_settings.py

    [Account MfellerIo]
    localrepository = MfellerLocal
    remoterepository = MfellerRemote

    [Repository MfellerRemote]
    type = IMAP
    remotehost = mail.mfeller.io
    remoteuser = mark
    remotepasseval = get_pass("bsd-mark")
    sslcacertfile = /etc/ssl/certs/ca-bundle.crt
    ssl = yes

    [Repository MfellerLocal]
    type = Maildir
    localfolders = ~/.local/mail
    restoreatime = no
  '';
}
