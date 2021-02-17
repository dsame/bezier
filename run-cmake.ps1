$env:Path = "C:\\msys64\\mingw64\\bin;" + $env:Path
cmake --build .\libbezier-debug\build --config Debug --target install
