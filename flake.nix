{
  description = "Build wlroots";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
  };

  outputs = { self , nixpkgs ,... }: let
    system = "x86_64-linux";
  in {
    devShells."${system}".default = let
      pkgs = import nixpkgs {
        inherit system;
      };
    in pkgs.mkShell {
      packages = with pkgs; [
        clang
        clang-tools
        wlroots
        libdrm
        libGL
        libcap
        libinput
        libpng
        libxkbcommon
        mesa
        pixman
        seatd
        vulkan-loader
        wayland
        wayland-protocols
	#wayland-client
        xorg.libX11
        xorg.xcbutilerrors
        xorg.xcbutilimage
        xorg.xcbutilrenderutil
        xorg.xcbutilwm
        xwayland
        ffmpeg
        hwdata
        libliftoff
        libdisplay-info
        pcre2
        json_c
        libevdev
        pango
        cairo
        gdk-pixbuf
        librsvg
        wayland-scanner
        scdoc
        pkg-config
        gcc
        gdb
        openlibm
        ccls
        gtk4
      ];

      nativeBuildInputs = [
        pkgs.cairo
        pkgs.ccls
        pkgs.gdb
        pkgs.clang-tools
        pkgs.pkg-config
	pkgs.wayland-protocols
        pkgs.wayland-scanner
      ];

      shellHook = ''
        make
      '';
    };
  };
}
