{ lib
, fetchFromGitHub
, melpaBuild
}:

melpaBuild {
  pname = "acp";
  version = "0.7.3";

  src = fetchFromGitHub {
    owner = "xenodium";
    repo = "acp.el";
    rev = "8f82c9a65bb44ba2aad452bfa2a62c443bc12fb1";
    sha256 = "0kgb7ir65kh2112i0gsanhniqk5li021p4g2fs6w3vis8ygsz2wc";
  };

  packageRequires = [];

  meta = with lib; {
    description = "ACP (Agent Client Protocol) implementation in Emacs Lisp";
    homepage = "https://github.com/xenodium/acp.el";
    license = licenses.gpl3Plus;
    maintainers = [];
    platforms = platforms.all;
  };
}
