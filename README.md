# bx-lexical-cast
The `boost::lexical_cast<…>` template utility, as extracted from Boost 1.66.0 with BCP – http://www.boost.org/doc/libs/1_66_0/tools/bcp/doc/html/index.html#bcp.overview

* The `boost` namespace has been renamed to `bx` (so like you want to be like e.g. `bx::lexical_cast<…>`) to avoid clashes
* The [Boost Software License](http://www.boost.org/LICENSE_1_0.txt) has been retained
* The relevant include file, `boost/lexical_cast.hpp`, is symlinked here as `lexical_cast` (with no file suffix, as is customary for C++ STL includes) so just include the repo’s root directory and be like `#include <lexical_cast>` if you’re interested in makink some casts happen, lexically speaking
* Beyond that, the only sort of things you’ll find in this repo are include files (suffixed either `.h` and `.hpp`) – no compilation or build-system muckymuck are necessary
* Not that we let “necessary” dictate terms around here or anything – there’s `cmake` support, so you can add this repo as like a submodule to a `cmake`-tastic project of yours, and by using `add_directory(…)` in your `CMakeLists.txt`, you can get all these headers installed along with your project, which we accomplish that by setting up [a `cmake` “interface” target](https://cmake.org/cmake/help/v3.8/command/add_library.html#interface-libraries).
* Also, there is a convenience Makefile that will handle all of that `cmake` build stuff, if you just want to install the thing and be done with it – it’s pretty self-explanatory if you give it a read.
