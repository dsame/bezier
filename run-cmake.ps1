$env:Path = "C:\\msys64\\mingw64\\bin;" + $env:Path
# WAS: cmake --build .\libbezier-debug\build --config Debug --target install

cmake.exe -S .\src\fortran -B .\libbezier-debug\build --check-build-system CMakeFiles\Makefile.cmake 0
cmake.exe -E cmake_progress_start .\libbezier-debug\build\CMakeFiles .\libbezier-debug\build\\CMakeFiles\progress.marks
mingw32-make.exe  -f CMakeFiles\Makefile2 all
mingw32-make.exe  -f quadpack\CMakeFiles\quadpack.dir\build.make quadpack\CMakeFiles\quadpack.dir\depend
cmake.exe -E cmake_depends "MinGW Makefiles" .\src\fortran .\src\fortran\quadpack .\libbezier-debug\build .\libbezier-debug\build\quadpack .\libbezier-debug\build\quadpack\CMakeFiles\quadpack.dir\DependInfo.cmake --color=
mingw32-make.exe  -f quadpack\CMakeFiles\quadpack.dir\build.make quadpack\CMakeFiles\quadpack.dir\build
gfortran.exe   -g -fno-second-underscore -Wall -Wextra -Wno-compare-reals -Wimplicit-interface -fmax-errors=1 -std=f2008 -fcheck=all -fbacktrace -fimplicit-none -pedantic -g -ffixed-form -c .\src\fortran\quadpack\d1mach.f -o .\libbezier-debug\build\quadpack\CMakeFiles\quadpack.dir\d1mach.f.obj
gfortran.exe   -g -fno-second-underscore -Wall -Wextra -Wno-compare-reals -Wimplicit-interface -fmax-errors=1 -std=f2008 -fcheck=all -fbacktrace -fimplicit-none -pedantic -g -ffixed-form -c .\src\fortran\quadpack\dqagse.f -o .\libbezier-debug\build\quadpack\CMakeFiles\quadpack.dir\dqagse.f.obj
gfortran.exe   -g -fno-second-underscore -Wall -Wextra -Wno-compare-reals -Wimplicit-interface -fmax-errors=1 -std=f2008 -fcheck=all -fbacktrace -fimplicit-none -pedantic -g -ffixed-form -c .\src\fortran\quadpack\dqelg.f  -o .\libbezier-debug\build\quadpack\CMakeFiles\quadpack.dir\dqelg.f.obj
gfortran.exe   -g -fno-second-underscore -Wall -Wextra -Wno-compare-reals -Wimplicit-interface -fmax-errors=1 -std=f2008 -fcheck=all -fbacktrace -fimplicit-none -pedantic -g -ffixed-form -c .\src\fortran\quadpack\dqk21.f  -o .\libbezier-debug\build\quadpack\CMakeFiles\quadpack.dir\dqk21.f.obj
gfortran.exe   -g -fno-second-underscore -Wall -Wextra -Wno-compare-reals -Wimplicit-interface -fmax-errors=1 -std=f2008 -fcheck=all -fbacktrace -fimplicit-none -pedantic -g -ffixed-form -c .\src\fortran\quadpack\dqpsrt.f -o .\libbezier-debug\build\quadpack\CMakeFiles\quadpack.dir\dqpsrt.f.obj
mingw32-make.exe  -f CMakeFiles\bezier.dir\build.make CMakeFiles\bezier.dir\depend
cmake.exe -E cmake_depends "MinGW Makefiles" .\src\fortran .\src\fortran .\libbezier-debug\build .\libbezier-debug\build .\libbezier-debug\build\CMakeFiles\bezier.dir\DependInfo.cmake --color=
mingw32-make.exe  -f CMakeFiles\bezier.dir\build.make CMakeFiles\bezier.dir\build
gfortran.exe -Dbezier_EXPORTS  -g -fno-second-underscore -Wall -Wextra -Wno-compare-reals -Wno-conversion -Wimplicit-interface -fmax-errors=1 -std=f2008 -fcheck=all -fbacktrace -fimplicit-none -pedantic -g -c .\src\fortran\types.f90 -o CMakeFiles\bezier.dir\types.f90.obj
cmake.exe -E cmake_copy_f90_mod types.mod CMakeFiles\bezier.dir\types.mod.stamp GNU
gfortran.exe -Dbezier_EXPORTS  -g -fno-second-underscore -Wall -Wextra -Wno-compare-reals -Wno-conversion -Wimplicit-interface -fmax-errors=1 -std=f2008 -fcheck=all -fbacktrace -fimplicit-none -pedantic -g -c .\src\fortran\helpers.f90 -o CMakeFiles\bezier.dir\helpers.f90.obj
cmake.exe -E cmake_copy_f90_mod helpers.mod CMakeFiles\bezier.dir\helpers.mod.stamp GNU
gfortran.exe -Dbezier_EXPORTS  -g -fno-second-underscore -Wall -Wextra -Wno-compare-reals -Wno-conversion -Wimplicit-interface -fmax-errors=1 -std=f2008 -fcheck=all -fbacktrace -fimplicit-none -pedantic -g -c .\src\fortran\curve.f90 -o CMakeFiles\bezier.dir\curve.f90.obj
cmake.exe -E cmake_copy_f90_mod curve.mod CMakeFiles\bezier.dir\curve.mod.stamp GNU
cmake.exe -E touch CMakeFiles\bezier.dir\curve.f90.obj.provides.build
gfortran.exe -Dbezier_EXPORTS  -g -fno-second-underscore -Wall -Wextra -Wno-compare-reals -Wno-conversion -Wimplicit-interface -fmax-errors=1 -std=f2008 -fcheck=all -fbacktrace -fimplicit-none -pedantic -g -c .\src\fortran\status.f90 -o CMakeFiles\bezier.dir\status.f90.obj
cmake.exe -E cmake_copy_f90_mod status.mod CMakeFiles\bezier.dir\status.mod.stamp GNU
gfortran.exe -Dbezier_EXPORTS  -g -fno-second-underscore -Wall -Wextra -Wno-compare-reals -Wno-conversion -Wimplicit-interface -fmax-errors=1 -std=f2008 -fcheck=all -fbacktrace -fimplicit-none -pedantic -g -c .\src\fortran\curve_intersection.f90 -o CMakeFiles\bezier.dir\curve_intersection.f90.obj
cmake.exe -E cmake_copy_f90_mod curve_intersection.mod CMakeFiles\bezier.dir\curve_intersection.mod.stamp GNU
cmake.exe -E touch CMakeFiles\bezier.dir\curve_intersection.f90.obj.provides.build
cmake.exe -E touch CMakeFiles\bezier.dir\helpers.f90.obj.provides.build
cmake.exe -E touch CMakeFiles\bezier.dir\status.f90.obj.provides.build
gfortran.exe -Dbezier_EXPORTS  -g -fno-second-underscore -Wall -Wextra -Wno-compare-reals -Wno-conversion -Wimplicit-interface -fmax-errors=1 -std=f2008 -fcheck=all -fbacktrace -fimplicit-none -pedantic -g -c .\src\fortran\triangle.f90 -o CMakeFiles\bezier.dir\triangle.f90.obj
cmake.exe -E cmake_copy_f90_mod triangle.mod CMakeFiles\bezier.dir\triangle.mod.stamp GNU
cmake.exe -E touch CMakeFiles\bezier.dir\triangle.f90.obj.provides.build
gfortran.exe -Dbezier_EXPORTS  -g -fno-second-underscore -Wall -Wextra -Wno-compare-reals -Wno-conversion -Wimplicit-interface -fmax-errors=1 -std=f2008 -fcheck=all -fbacktrace -fimplicit-none -pedantic -g -c .\src\fortran\triangle_intersection.f90 -o CMakeFiles\bezier.dir\triangle_intersection.f90.obj
cmake.exe -E cmake_copy_f90_mod triangle_intersection.mod CMakeFiles\bezier.dir\triangle_intersection.mod.stamp GNU
cmake.exe -E touch CMakeFiles\bezier.dir\triangle_intersection.f90.obj.provides.build
cmake.exe -E touch CMakeFiles\bezier.dir\types.f90.obj.provides.build
cmake.exe -E cmake_link_script CMakeFiles\bezier.dir\link.txt --verbose=1
cmake.exe -E rm -f CMakeFiles\bezier.dir\objects.a
ar.exe cr CMakeFiles\bezier.dir\objects.a @CMakeFiles\bezier.dir\objects1.rsp
gfortran.exe -g  -static -lquadmath -shared -o bezier.dll "-Wl,--out-implib,bezier.lib" "-Wl,--major-image-version,2021,--minor-image-version,2" "-Wl,--whole-archive" CMakeFiles\bezier.dir\objects.a "-Wl,--no-whole-archive" @CMakeFiles\bezier.dir\linklibs.rsp
