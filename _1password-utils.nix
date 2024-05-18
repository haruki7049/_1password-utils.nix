{ lib, pkgs, ... }:

let
  _1password-utils = item: username: pkgs.runCommand "_1password-utils" { } ''
    unshare --user --map-root-user ${toString username.uid}:${toString username.uid} \
      ${pkgs._1password}/bin/op read ${item}
  '';
in
{
  inherit _1password-utils;
}
