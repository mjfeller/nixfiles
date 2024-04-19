{
  config,
  pkgs,
  lib,
  ...
}: let
  myFonts = with pkgs; [
    nerdfonts
    iosevka
    iosevka-comfy.comfy
    iosevka-comfy.comfy-duo
    iosevka-comfy.comfy-wide
    iosevka-comfy.comfy-fixed
    iosevka-comfy.comfy-motion
    iosevka-comfy.comfy-wide-duo
    iosevka-comfy.comfy-wide-fixed
    iosevka-comfy.comfy-motion-duo
    iosevka-comfy.comfy-motion-fixed
    iosevka-comfy.comfy-wide-motion
    iosevka-comfy.comfy-wide-motion-duo
    iosevka-comfy.comfy-wide-motion-fixed
  ];
  attrset =
    if pkgs.stdenv.isLinux
    then { packages = myFonts; }
    else { fonts = myFonts; };
in {
  fonts = { fontDir.enable = true; } // attrset;
}
