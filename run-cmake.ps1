$env:Path = "C:\\msys64\\mingw64\\bin;" + $env:Path
# WAS: cmake --build .\libbezier-debug\build --config Debug --target install

# Roughly equivalent to `set -e` in `bash`
$ErrorActionPreference = "Stop"
# Roughly equivalent to `set -x` in `bash`
Set-PSDebug -Trace 1

## C:\msys64\mingw64\bin\cmake.exe -SD:\a\bezier\bezier\src\fortran -BD:\a\bezier\bezier\libbezier-debug\build --check-build-system CMakeFiles\Makefile.cmake 0
## C:\msys64\mingw64\bin\cmake.exe -E cmake_progress_start D:\a\bezier\bezier\libbezier-debug\build\CMakeFiles D:\a\bezier\bezier\libbezier-debug\build\\CMakeFiles\progress.marks
Set-Location -Path D:\a\bezier\bezier\libbezier-debug\build  # Added by dhermes
## C:/msys64/mingw64/bin/mingw32-make.exe  -f CMakeFiles\Makefile2 all
# mingw32-make[1]: Entering directory 'D:/a/bezier/bezier/libbezier-debug/build'
## C:/msys64/mingw64/bin/mingw32-make.exe  -f quadpack\CMakeFiles\quadpack.dir\build.make quadpack/CMakeFiles/quadpack.dir/depend
# mingw32-make[2]: Entering directory 'D:/a/bezier/bezier/libbezier-debug/build'
## C:\msys64\mingw64\bin\cmake.exe -E cmake_depends "MinGW Makefiles" D:\a\bezier\bezier\src\fortran D:\a\bezier\bezier\src\fortran\quadpack D:\a\bezier\bezier\libbezier-debug\build D:\a\bezier\bezier\libbezier-debug\build\quadpack D:\a\bezier\bezier\libbezier-debug\build\quadpack\CMakeFiles\quadpack.dir\DependInfo.cmake --color=
# Dependee "D:\a\bezier\bezier\libbezier-debug\build\quadpack\CMakeFiles\quadpack.dir\DependInfo.cmake" is newer than depender "D:/a/bezier/bezier/libbezier-debug/build/quadpack/CMakeFiles/quadpack.dir/depend.internal".
# Dependee "D:/a/bezier/bezier/libbezier-debug/build/quadpack/CMakeFiles/CMakeDirectoryInformation.cmake" is newer than depender "D:/a/bezier/bezier/libbezier-debug/build/quadpack/CMakeFiles/quadpack.dir/depend.internal".
# Scanning dependencies of target quadpack
# mingw32-make[2]: Leaving directory 'D:/a/bezier/bezier/libbezier-debug/build'
## C:/msys64/mingw64/bin/mingw32-make.exe  -f quadpack\CMakeFiles\quadpack.dir\build.make quadpack/CMakeFiles/quadpack.dir/build
# mingw32-make[2]: Entering directory 'D:/a/bezier/bezier/libbezier-debug/build'
# [  7%] Building Fortran object quadpack/CMakeFiles/quadpack.dir/d1mach.f.obj
Set-Location -Path D:\a\bezier\bezier\libbezier-debug\build\quadpack  # Added / modified by dhermes
C:\msys64\mingw64\bin\gfortran.exe   -g -fno-second-underscore -Wall -Wextra -Wno-compare-reals -Wimplicit-interface -fmax-errors=1 -std=f2008 -fcheck=all -fbacktrace -fimplicit-none -pedantic -g -ffixed-form -c D:\a\bezier\bezier\src\fortran\quadpack\d1mach.f -o CMakeFiles\quadpack.dir\d1mach.f.obj
# D:\a\bezier\bezier\src\fortran\quadpack\d1mach.f:157:72:

#   157 |                   CALL I1MCRY(SMALL(1), J, 8285, 8388608, 0)
#       |                                                                        1
# Warning: Procedure 'i1mcry' called with an implicit interface at (1) [-Wimplicit-interface]
# D:\a\bezier\bezier\src\fortran\quadpack\d1mach.f:159:72:

#   159 |                   CALL I1MCRY(LARGE(1), J, 24574, 16777215, 16777215)
#       |                                                                        1
# Warning: Procedure 'i1mcry' called with an implicit interface at (1) [-Wimplicit-interface]
# D:\a\bezier\bezier\src\fortran\quadpack\d1mach.f:160:72:

#   160 |                   CALL I1MCRY(LARGE(2), J, 0, 16777215, 16777214)
#       |                                                                        1
# Warning: Procedure 'i1mcry' called with an implicit interface at (1) [-Wimplicit-interface]
# D:\a\bezier\bezier\src\fortran\quadpack\d1mach.f:161:72:

#   161 |                   CALL I1MCRY(RIGHT(1), J, 16291, 8388608, 0)
#       |                                                                        1
# Warning: Procedure 'i1mcry' called with an implicit interface at (1) [-Wimplicit-interface]
# D:\a\bezier\bezier\src\fortran\quadpack\d1mach.f:163:72:

#   163 |                   CALL I1MCRY(DIVER(1), J, 16292, 8388608, 0)
#       |                                                                        1
# Warning: Procedure 'i1mcry' called with an implicit interface at (1) [-Wimplicit-interface]
# D:\a\bezier\bezier\src\fortran\quadpack\d1mach.f:165:72:

#   165 |                   CALL I1MCRY(LOG10(1), J, 16383, 10100890, 8715215)
#       |                                                                        1
# Warning: Procedure 'i1mcry' called with an implicit interface at (1) [-Wimplicit-interface]
# D:\a\bezier\bezier\src\fortran\quadpack\d1mach.f:166:72:

#   166 |                   CALL I1MCRY(LOG10(2), J, 0, 16226447, 9001388)
#       |                                                                        1
# Warning: Procedure 'i1mcry' called with an implicit interface at (1) [-Wimplicit-interface]
# [ 15%] Building Fortran object quadpack/CMakeFiles/quadpack.dir/dqagse.f.obj
Set-Location -Path D:\a\bezier\bezier\libbezier-debug\build\quadpack  # Added / modified by dhermes
C:\msys64\mingw64\bin\gfortran.exe   -g -fno-second-underscore -Wall -Wextra -Wno-compare-reals -Wimplicit-interface -fmax-errors=1 -std=f2008 -fcheck=all -fbacktrace -fimplicit-none -pedantic -g -ffixed-form -c D:\a\bezier\bezier\src\fortran\quadpack\dqagse.f -o CMakeFiles\quadpack.dir\dqagse.f.obj
# D:\a\bezier\bezier\src\fortran\quadpack\dqagse.f:218:15:

#   218 |       epmach = d1mach(4)
#       |               1
# Warning: Procedure 'd1mach' called with an implicit interface at (1) [-Wimplicit-interface]
# D:\a\bezier\bezier\src\fortran\quadpack\dqagse.f:238:14:

#   238 |       uflow = d1mach(1)
#       |              1
# Warning: Procedure 'd1mach' called with an implicit interface at (1) [-Wimplicit-interface]
# D:\a\bezier\bezier\src\fortran\quadpack\dqagse.f:239:14:

#   239 |       oflow = d1mach(2)
#       |              1
# Warning: Procedure 'd1mach' called with an implicit interface at (1) [-Wimplicit-interface]
# D:\a\bezier\bezier\src\fortran\quadpack\dqagse.f:241:72:

#   241 |       call dqk21(f,a,b,result,abserr,defabs,resabs)
#       |                                                                        1
# Warning: Procedure 'dqk21' called with an implicit interface at (1) [-Wimplicit-interface]
# D:\a\bezier\bezier\src\fortran\quadpack\dqagse.f:290:72:

#   290 |         call dqk21(f,a1,b1,area1,error1,resabs,defab1)
#       |                                                                        1
# Warning: Procedure 'dqk21' called with an implicit interface at (1) [-Wimplicit-interface]
# D:\a\bezier\bezier\src\fortran\quadpack\dqagse.f:291:72:

#   291 |         call dqk21(f,a2,b2,area2,error2,resabs,defab2)
#       |                                                                        1
# Warning: Procedure 'dqk21' called with an implicit interface at (1) [-Wimplicit-interface]
# D:\a\bezier\bezier\src\fortran\quadpack\dqagse.f:347:72:

#   347 |    30   call dqpsrt(limit,last,maxerr,errmax,elist,iord,nrmax)
#       |                                                                        1
# Warning: Procedure 'dqpsrt' called with an implicit interface at (1) [-Wimplicit-interface]
# D:\a\bezier\bezier\src\fortran\quadpack\dqagse.f:385:72:

#   385 |         call dqelg(numrl2,rlist2,reseps,abseps,res3la,nres)
#       |                                                                        1
# Warning: Procedure 'dqelg' called with an implicit interface at (1) [-Wimplicit-interface]
# [ 23%] Building Fortran object quadpack/CMakeFiles/quadpack.dir/dqelg.f.obj
Set-Location -Path D:\a\bezier\bezier\libbezier-debug\build\quadpack  # Added / modified by dhermes
C:\msys64\mingw64\bin\gfortran.exe   -g -fno-second-underscore -Wall -Wextra -Wno-compare-reals -Wimplicit-interface -fmax-errors=1 -std=f2008 -fcheck=all -fbacktrace -fimplicit-none -pedantic -g -ffixed-form -c D:\a\bezier\bezier\src\fortran\quadpack\dqelg.f -o CMakeFiles\quadpack.dir\dqelg.f.obj
# D:\a\bezier\bezier\src\fortran\quadpack\dqelg.f:83:15:

#    83 |       epmach = d1mach(4)
#       |               1
# Warning: Procedure 'd1mach' called with an implicit interface at (1) [-Wimplicit-interface]
# D:\a\bezier\bezier\src\fortran\quadpack\dqelg.f:84:14:

#    84 |       oflow = d1mach(2)
#       |              1
# Warning: Procedure 'd1mach' called with an implicit interface at (1) [-Wimplicit-interface]
# [ 30%] Building Fortran object quadpack/CMakeFiles/quadpack.dir/dqk21.f.obj
Set-Location -Path D:\a\bezier\bezier\libbezier-debug\build\quadpack  # Added / modified by dhermes
C:\msys64\mingw64\bin\gfortran.exe   -g -fno-second-underscore -Wall -Wextra -Wno-compare-reals -Wimplicit-interface -fmax-errors=1 -std=f2008 -fcheck=all -fbacktrace -fimplicit-none -pedantic -g -ffixed-form -c D:\a\bezier\bezier\src\fortran\quadpack\dqk21.f -o CMakeFiles\quadpack.dir\dqk21.f.obj
# D:\a\bezier\bezier\src\fortran\quadpack\dqk21.f:132:15:

#   132 |       epmach = d1mach(4)
#       |               1
# Warning: Procedure 'd1mach' called with an implicit interface at (1) [-Wimplicit-interface]
# D:\a\bezier\bezier\src\fortran\quadpack\dqk21.f:133:14:

#   133 |       uflow = d1mach(1)
#       |              1
# Warning: Procedure 'd1mach' called with an implicit interface at (1) [-Wimplicit-interface]
# D:\a\bezier\bezier\src\fortran\quadpack\dqk21.f:143:11:

#   143 |       fc = f(centr)
#       |           1
# Warning: Procedure 'f' called with an implicit interface at (1) [-Wimplicit-interface]
# D:\a\bezier\bezier\src\fortran\quadpack\dqk21.f:149:16:

#   149 |         fval1 = f(centr-absc)
#       |                1
# Warning: Procedure 'f' called with an implicit interface at (1) [-Wimplicit-interface]
# D:\a\bezier\bezier\src\fortran\quadpack\dqk21.f:150:16:

#   150 |         fval2 = f(centr+absc)
#       |                1
# Warning: Procedure 'f' called with an implicit interface at (1) [-Wimplicit-interface]
# D:\a\bezier\bezier\src\fortran\quadpack\dqk21.f:161:16:

#   161 |         fval1 = f(centr-absc)
#       |                1
# Warning: Procedure 'f' called with an implicit interface at (1) [-Wimplicit-interface]
# D:\a\bezier\bezier\src\fortran\quadpack\dqk21.f:162:16:

#   162 |         fval2 = f(centr+absc)
#       |                1
# Warning: Procedure 'f' called with an implicit interface at (1) [-Wimplicit-interface]
# [ 38%] Building Fortran object quadpack/CMakeFiles/quadpack.dir/dqpsrt.f.obj
Set-Location -Path D:\a\bezier\bezier\libbezier-debug\build\quadpack  # Added / modified by dhermes
C:\msys64\mingw64\bin\gfortran.exe   -g -fno-second-underscore -Wall -Wextra -Wno-compare-reals -Wimplicit-interface -fmax-errors=1 -std=f2008 -fcheck=all -fbacktrace -fimplicit-none -pedantic -g -ffixed-form -c D:\a\bezier\bezier\src\fortran\quadpack\dqpsrt.f -o CMakeFiles\quadpack.dir\dqpsrt.f.obj
# mingw32-make[2]: Leaving directory 'D:/a/bezier/bezier/libbezier-debug/build'
# [ 38%] Built target quadpack
Set-Location -Path D:\a\bezier\bezier\libbezier-debug\build  # Added by dhermes
## C:/msys64/mingw64/bin/mingw32-make.exe  -f CMakeFiles\bezier.dir\build.make CMakeFiles/bezier.dir/depend
# mingw32-make[2]: Entering directory 'D:/a/bezier/bezier/libbezier-debug/build'
## C:\msys64\mingw64\bin\cmake.exe -E cmake_depends "MinGW Makefiles" D:\a\bezier\bezier\src\fortran D:\a\bezier\bezier\src\fortran D:\a\bezier\bezier\libbezier-debug\build D:\a\bezier\bezier\libbezier-debug\build D:\a\bezier\bezier\libbezier-debug\build\CMakeFiles\bezier.dir\DependInfo.cmake --color=
# Dependee "D:\a\bezier\bezier\libbezier-debug\build\CMakeFiles\bezier.dir\DependInfo.cmake" is newer than depender "D:/a/bezier/bezier/libbezier-debug/build/CMakeFiles/bezier.dir/depend.internal".
# Dependee "D:/a/bezier/bezier/libbezier-debug/build/CMakeFiles/CMakeDirectoryInformation.cmake" is newer than depender "D:/a/bezier/bezier/libbezier-debug/build/CMakeFiles/bezier.dir/depend.internal".
# Scanning dependencies of target bezier
# mingw32-make[2]: Leaving directory 'D:/a/bezier/bezier/libbezier-debug/build'
## C:/msys64/mingw64/bin/mingw32-make.exe  -f CMakeFiles\bezier.dir\build.make CMakeFiles/bezier.dir/build
# mingw32-make[2]: Entering directory 'D:/a/bezier/bezier/libbezier-debug/build'
# [ 46%] Building Fortran object CMakeFiles/bezier.dir/types.f90.obj
C:\msys64\mingw64\bin\gfortran.exe -Dbezier_EXPORTS  -g -fno-second-underscore -Wall -Wextra -Wno-compare-reals -Wno-conversion -Wimplicit-interface -fmax-errors=1 -std=f2008 -fcheck=all -fbacktrace -fimplicit-none -pedantic -g -c D:\a\bezier\bezier\src\fortran\types.f90 -o CMakeFiles\bezier.dir\types.f90.obj
C:\msys64\mingw64\bin\cmake.exe -E cmake_copy_f90_mod types.mod CMakeFiles\bezier.dir\types.mod.stamp GNU
# [ 53%] Building Fortran object CMakeFiles/bezier.dir/helpers.f90.obj
C:\msys64\mingw64\bin\gfortran.exe -Dbezier_EXPORTS  -g -fno-second-underscore -Wall -Wextra -Wno-compare-reals -Wno-conversion -Wimplicit-interface -fmax-errors=1 -std=f2008 -fcheck=all -fbacktrace -fimplicit-none -pedantic -g -c D:\a\bezier\bezier\src\fortran\helpers.f90 -o CMakeFiles\bezier.dir\helpers.f90.obj
C:\msys64\mingw64\bin\cmake.exe -E cmake_copy_f90_mod helpers.mod CMakeFiles\bezier.dir\helpers.mod.stamp GNU
# [ 61%] Building Fortran object CMakeFiles/bezier.dir/curve.f90.obj
C:\msys64\mingw64\bin\gfortran.exe -Dbezier_EXPORTS  -g -fno-second-underscore -Wall -Wextra -Wno-compare-reals -Wno-conversion -Wimplicit-interface -fmax-errors=1 -std=f2008 -fcheck=all -fbacktrace -fimplicit-none -pedantic -g -c D:\a\bezier\bezier\src\fortran\curve.f90 -o CMakeFiles\bezier.dir\curve.f90.obj
C:\msys64\mingw64\bin\cmake.exe -E cmake_copy_f90_mod curve.mod CMakeFiles\bezier.dir\curve.mod.stamp GNU
C:\msys64\mingw64\bin\cmake.exe -E touch CMakeFiles/bezier.dir/curve.f90.obj.provides.build
# [ 69%] Building Fortran object CMakeFiles/bezier.dir/status.f90.obj
C:\msys64\mingw64\bin\gfortran.exe -Dbezier_EXPORTS  -g -fno-second-underscore -Wall -Wextra -Wno-compare-reals -Wno-conversion -Wimplicit-interface -fmax-errors=1 -std=f2008 -fcheck=all -fbacktrace -fimplicit-none -pedantic -g -c D:\a\bezier\bezier\src\fortran\status.f90 -o CMakeFiles\bezier.dir\status.f90.obj
C:\msys64\mingw64\bin\cmake.exe -E cmake_copy_f90_mod status.mod CMakeFiles\bezier.dir\status.mod.stamp GNU
# [ 76%] Building Fortran object CMakeFiles/bezier.dir/curve_intersection.f90.obj
C:\msys64\mingw64\bin\gfortran.exe -Dbezier_EXPORTS  -g -fno-second-underscore -Wall -Wextra -Wno-compare-reals -Wno-conversion -Wimplicit-interface -fmax-errors=1 -std=f2008 -fcheck=all -fbacktrace -fimplicit-none -pedantic -g -c D:\a\bezier\bezier\src\fortran\curve_intersection.f90 -o CMakeFiles\bezier.dir\curve_intersection.f90.obj
C:\msys64\mingw64\bin\cmake.exe -E cmake_copy_f90_mod curve_intersection.mod CMakeFiles\bezier.dir\curve_intersection.mod.stamp GNU
C:\msys64\mingw64\bin\cmake.exe -E touch CMakeFiles/bezier.dir/curve_intersection.f90.obj.provides.build
C:\msys64\mingw64\bin\cmake.exe -E touch CMakeFiles/bezier.dir/helpers.f90.obj.provides.build
C:\msys64\mingw64\bin\cmake.exe -E touch CMakeFiles/bezier.dir/status.f90.obj.provides.build
# [ 84%] Building Fortran object CMakeFiles/bezier.dir/triangle.f90.obj
C:\msys64\mingw64\bin\gfortran.exe -Dbezier_EXPORTS  -g -fno-second-underscore -Wall -Wextra -Wno-compare-reals -Wno-conversion -Wimplicit-interface -fmax-errors=1 -std=f2008 -fcheck=all -fbacktrace -fimplicit-none -pedantic -g -c D:\a\bezier\bezier\src\fortran\triangle.f90 -o CMakeFiles\bezier.dir\triangle.f90.obj
C:\msys64\mingw64\bin\cmake.exe -E cmake_copy_f90_mod triangle.mod CMakeFiles\bezier.dir\triangle.mod.stamp GNU
C:\msys64\mingw64\bin\cmake.exe -E touch CMakeFiles/bezier.dir/triangle.f90.obj.provides.build
# [ 92%] Building Fortran object CMakeFiles/bezier.dir/triangle_intersection.f90.obj
C:\msys64\mingw64\bin\gfortran.exe -Dbezier_EXPORTS  -g -fno-second-underscore -Wall -Wextra -Wno-compare-reals -Wno-conversion -Wimplicit-interface -fmax-errors=1 -std=f2008 -fcheck=all -fbacktrace -fimplicit-none -pedantic -g -c D:\a\bezier\bezier\src\fortran\triangle_intersection.f90 -o CMakeFiles\bezier.dir\triangle_intersection.f90.obj
C:\msys64\mingw64\bin\cmake.exe -E cmake_copy_f90_mod triangle_intersection.mod CMakeFiles\bezier.dir\triangle_intersection.mod.stamp GNU
C:\msys64\mingw64\bin\cmake.exe -E touch CMakeFiles/bezier.dir/triangle_intersection.f90.obj.provides.build
C:\msys64\mingw64\bin\cmake.exe -E touch CMakeFiles/bezier.dir/types.f90.obj.provides.build
# [100%] Linking Fortran shared library bezier.dll
## C:\msys64\mingw64\bin\cmake.exe -E cmake_link_script CMakeFiles\bezier.dir\link.txt --verbose=1
C:\msys64\mingw64\bin\cmake.exe -E rm -f CMakeFiles\bezier.dir/objects.a
C:\msys64\mingw64\bin\ar.exe cr CMakeFiles\bezier.dir/objects.a @CMakeFiles\bezier.dir\objects1.rsp
C:\msys64\mingw64\bin\gfortran.exe -g  -static -shared -o bezier.dll "-Wl,--out-implib,bezier.lib" "-Wl,--major-image-version,2021,--minor-image-version,2" "-Wl,--whole-archive" CMakeFiles\bezier.dir/objects.a "-Wl,--no-whole-archive" @CMakeFiles\bezier.dir\linklibs.rsp -lquadmath
