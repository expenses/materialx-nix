{ stdenv, lib, cmake, xorg, libGL, darwin, build_viewer ? false }:
stdenv.mkDerivation {
  name = "materialx";

  src = fetchGit {
    url = "https://github.com/AcademySoftwareFoundation/MaterialX";
    ref = "refs/tags/v1.38.8";
    rev = "92734332d595278298ad08e6543409bbabf344f0";
    submodules = build_viewer;
  };

  cmakeFlags = lib.optionals build_viewer ([ "-DMATERIALX_BUILD_VIEWER=true" ]);

  nativeBuildInputs = [ cmake ];
  buildInputs = [ xorg.libXt libGL ]
    ++ lib.optionals stdenv.isDarwin (with darwin.apple_sdk_11_0.frameworks; [ Cocoa MetalKit ])
    ++ lib.optionals build_viewer ([
      xorg.libXrandr
      xorg.libXinerama
      xorg.libXcursor
      xorg.libXi
    ]);
}

