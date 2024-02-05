set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_VERSION 1)
set(CMAKE_SYSTEM_PROCESSOR arm)

SET(cross_triple $ENV{CROSS_TRIPLE})
SET(cross_root $ENV{CROSS_ROOT})

SET(CMAKE_C_COMPILER $ENV{CC})
SET(CMAKE_CXX_COMPILER $ENV{CXX})

SET(CMAKE_AR      ${cross_triple}-ar)
SET(CMAKE_LINKER  ${cross_triple}-ld)
SET(CMAKE_OBJCOPY ${cross_triple}-objcopy)
SET(CMAKE_RANLIB  ${cross_triple}-ranlib)
SET(CMAKE_SIZE    ${cross_triple}-size)
SET(CMAKE_STRIP   ${cross_triple}-strip)

SET(CMAKE_C_FLAGS "-I ${cross_root}/include/")
SET(CMAKE_CXX_FLAGS "-I ${cross_root}/include/")

SET(CMAKE_FIND_ROOT_PATH ${cross_root} ${cross_root}/${cross_triple})
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY BOTH)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE BOTH)
SET(CMAKE_SYSROOT $ENV{CROSS_SYSROOT})

SET(CMAKE_CROSSCOMPILING_EMULATOR /usr/bin/qemu-arm-static)

SET(CMAKE_LIBRARY_ARCHITECTURE arm-none-linux-gnueabihf)