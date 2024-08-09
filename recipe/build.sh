#!/bin/bash

if [[ ${HOST} =~ .*darwin.* ]]; then
  export PKG_CPPFLAGS=-Wl,-rpath,${PREFIX}/lib
  # 'Autobrew' is being used by more and more packages these days
  # to grab static libraries from Homebrew bottles. These bottles
  # are fetched via Homebrew's --force-bottle option which grabs
  # a bottle for the build machine which may not be macOS 10.9.
  # Also, we want to use conda packages (and shared libraries) for
  # these 'system' dependencies. See:
  # https://github.com/jeroen/autobrew/issues/3
  export DISABLE_AUTOBREW=1
fi

# R refuses to build packages that mark themselves as Priority: Recommended
mv DESCRIPTION DESCRIPTION.old
grep -va '^Priority: ' DESCRIPTION.old > DESCRIPTION
# shellcheck disable=SC2086
${R} CMD INSTALL --build . ${R_ARGS}
