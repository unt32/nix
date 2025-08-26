{ alpha, pixelSize }:

final: prev: {
  st = prev.st.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      (prev.fetchpatch {
        url = "https://st.suckless.org/patches/anysize/st-anysize-20220718-baa9357.diff";
        sha256 = "sha256-yx9VSwmPACx3EN3CAdQkxeoJKJxQ6ziC9tpBcoWuWHc=";
      })

      (prev.fetchpatch {
        url = "https://st.suckless.org/patches/alpha/st-alpha-osc11-20220222-0.8.5.diff";
        sha256 = "sha256-Y8GDatq/1W86GKPJWzggQB7O85hXS0SJRva2atQ3upw=";
      })

      (builtins.toFile "st-diffs.patch" ''
        --- a/config.def.h
        +++ b/config.def.h
        @@ -8,1 +8,1 @@
        -static char *font = "Liberation Mono:pixelsize=12:antialias=true:autohint=true";
        +static char *font = "Liberation Mono:pixelsize=${pixelSize}:antialias=true:autohint=true";
        @@ -97,1 +97,1 @@ char *termname = "st-256color";
        -float alpha = 0.8;
        +float alpha = ${alpha};
      '')
    ];
  });
}
