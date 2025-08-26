{ fontSize, borderPx }:

final: prev: {
  dwm = prev.dwm.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      (prev.fetchpatch {
        url = "https://dwm.suckless.org/patches/noborder/dwm-noborder-6.2.diff";
        sha256 = "sha256-HJKvYCPDgAcxCmKeqA1Fri94RB184odEBF4ZTj6jvy8=";
      })

      ./dwm.diff

      (builtins.toFile "dwm-diffs.patch" ''
        --- a/config.def.h
        +++ b/config.def.h
        @@ -4,1 +4,1 @@
        -static const unsigned int borderpx  = 1;        /* border pixel of windows */
        +static const unsigned int borderpx  = ${borderPx};        /* border pixel of windows */
        @@ -10,2 +10,2 @@
        -static const char *fonts[]          = { "monospace:size=10" };
        -static const char dmenufont[]       = "monospace:size=10";
        +static const char *fonts[]          = { "monospace:size=${fontSize}" };
        +static const char dmenufont[]       = "monospace:size=${fontSize}";
      '')
    ];
  });
}
