{ lib
, fetchFromGitHub
, melpaBuild
, acp
, shell-maker
}:

melpaBuild {
  pname = "agent-shell";
  version = "0.18.2";

  src = fetchFromGitHub {
    owner = "xenodium";
    repo = "agent-shell";
    rev = "9df5d153bd4cde1c5e2e6072122a37ee0122c531";
    sha256 = "0a3iz7w58ikkjqwm8xy7wi1i62hhagv343mgymdkpn3mw48b6yya";
  };

  packageRequires = [ acp shell-maker ];

  meta = with lib; {
    description = "A native Emacs buffer to interact with LLM agents powered by ACP";
    homepage = "https://github.com/xenodium/agent-shell";
    license = licenses.gpl3Plus;
    maintainers = [];
    platforms = platforms.all;
  };
}
