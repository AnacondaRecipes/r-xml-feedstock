#!/bin/bash

if [[ ${HOST} =~ .*darwin.* ]]; then
  export PKG_CPPFLAGS=-Wl,-rpath,${PREFIX}/lib
fi
$R CMD INSTALL --build .
