# bx-lexical-cast
The `boost::lexical_cast<…>` template utility, as extracted from Boost 1.66.0 with BCP – http://www.boost.org/doc/libs/1_66_0/tools/bcp/doc/html/index.html#bcp.overview

* The `boost` namespace has been renamed to `bx` (so like you want to be like e.g. `bx::lexical_cast<…>`) to avoid clashes
* The [Boost Software License](http://www.boost.org/LICENSE_1_0.txt) has been retained
* The relevant include file, `boost/lexical_cast.hpp`, is symlinked here as `lexical_cast` (with no file suffix, as is customary for C++ STL includes) so just include the repo’s root directory and be like `#include <lexical_cast>` if you’re interested in makink some casts happen, lexically speaking
* Beyond that, the only sort of things you’ll find in this repo are include files (suffixed either `.h` and `.hpp`) – no compilation or build-system muckymuck are necessary
