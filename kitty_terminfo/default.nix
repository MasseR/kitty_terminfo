{ kitty, runCommand, ncurses }:
runCommand "kitty-terminfo" {
  inherit (kitty) src;
  nativeBuildInputs = [ ncurses ];
}
''
  unpackPhase
  mkdir -p $out/share/terminfo
  tic -o $out/share/terminfo ./source/terminfo/kitty.terminfo
''
