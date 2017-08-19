#!/bin/bash

openrestyhome="/usr/local/openresty"

resty \
    -I ${openrestyhome}/andromeda/module \
       ${openrestyhome}/tests/busted_runner.lua  \
    --verbose ${openrestyhome}/tests/test_logger.lua

