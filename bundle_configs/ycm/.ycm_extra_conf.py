# This file is NOT licensed under the GPLv3, which is the license for the rest
# of YouCompleteMe.
#
# Here's the license text for this file:
#
# This is free and unencumbered software released into the public domain.
#
# Anyone is free to copy, modify, publish, use, compile, sell, or
# distribute this software, either in source code form or as a compiled
# binary, for any purpose, commercial or non-commercial, and by any
# means.
#
# In jurisdictions that recognize copyright laws, the author or authors
# of this software dedicate any and all copyright interest in the
# software to the public domain. We make this dedication for the benefit
# of the public at large and to the detriment of our heirs and
# successors. We intend this dedication to be an overt act of
# relinquishment in perpetuity of all present and future rights to this
# software under copyright law.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#
# For more information, please refer to <http://unlicense.org/>

import os
import ycm_core

# These are the compilation flags that will be used in case there's no
# compilation database set (by default, one is not set).
# CHANGE THIS LIST OF FLAGS. YES, THIS IS THE DROID YOU HAVE BEEN LOOKING FOR.
flags = [
'-Wall',
'-Wextra',
#'-Werror',
#'-Wno-long-long',
#'-Wno-variadic-macros',
'-fexceptions',
# THIS IS IMPORTANT! Without a "-std=<something>" flag, clang won't know which
# language to use when compiling headers. So it will guess. Badly. So C++
# headers will be compiled as C headers. You don't want that so ALWAYS specify
# a "-std=<something>".
# For a C project, you would set this to something like 'c99' instead of
# 'c++11'.
'-std=c++11',
'-stdlib=libc++',
# ...and the same thing goes for the magic -x option which specifies the
# language that the files to be compiled are written in. This is mostly
# relevant for c++ headers.
# For a C project, you would set this to 'c' instead of 'c++'.
'-x',
'c++',
'-F/System/Library/Frameworks',
'-F/opt/local/Library/Frameworks',
'-F/Library/Frameworks',
'-isystem',
#'-I',
'/usr/include',
#'-I',
'-isystem',
'/opt/local/libexec/llvm-3.3/lib/c++/v1',
#'-I',
'-isystem',
'/opt/local/libexec/llvm-3.3/lib/clang/3.3/include',
'-isystem',
#'-I',
'/opt/local/include',
'-isystem',
#'-I',
'/usr/local/include',
#'-L',
#'/opt/local/lib',
# This path will only work on OS X, but extra paths that don't exist are not
# harmful
#'-isystem',
#'-I',
#'/opt/local/Library/Frameworks/Python.framework/Headers',
#'-isystem',
'-I',
'.'
]

# Set this to the absolute path to the folder (NOT the file!) containing the
# compile_commands.json file to use that instead of 'flags'. See here for
# more details: http://clang.llvm.org/docs/JSONCompilationDatabase.html
#
# Most projects will NOT need to set this to anything; you can just change the
# 'flags' list of compilation flags. Notice that YCM itself uses that approach.
SOURCE_EXTENSIONS = [ '.cpp', '.cxx', '.cc', '.c', '.m', '.mm' ]

def FlagsForFile( filename, **kwargs ):
  #if database:
    ## Bear in mind that compilation_info.compiler_flags_ does NOT return a
    ## python list, but a "list-like" StringVec object
    #compilation_info = GetCompilationInfoForFile( filename )
    #if not compilation_info:
      #return None

    #final_flags = MakeRelativePathsInFlagsAbsolute(
      #compilation_info.compiler_flags_,
      #compilation_info.compiler_working_dir_ )

    ## NOTE: This is just for YouCompleteMe; it's highly likely that your project
    ## does NOT need to remove the stdlib flag. DO NOT USE THIS IN YOUR
    ## ycm_extra_conf IF YOU'RE NOT 100% SURE YOU NEED IT.
    ##try:
      ##final_flags.remove( '-stdlib=libc++' )
    ##except ValueError:
      ##pass
  #else:
    #relative_to = DirectoryOfThisScript()
    #final_flags = MakeRelativePathsInFlagsAbsolute( flags, relative_to )
  final_flags = flags

  return {
    'flags': final_flags,
    'do_cache': True
  }
