{ lib, pkgs, ... }:

let
  _1password-utils = item: username: pkgs.runCommand "_1password-utils" { } ''
    unshare --user --map-root-user $(${pkgs.coreutils}/bin/id -u):$(${pkgs.coreutils}/bin/id -g) \
      ${pkgs._1password}/bin/op read ${item}
  '';
in
{
  inherit _1password-utils;
}
