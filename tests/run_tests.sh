#!/bin/bash

resty \
    -I /usr/local/openresty/lua_script/module \
       /usr/local/openresty/tests/busted_runner.lua  \
    --verbose /usr/local/openresty/tests/test_logger.lua

