FROM openresty/openresty:alpine-fat


RUN apk update && \
    apk add yaml-dev && \
    /usr/local/openresty/luajit/bin/luarocks install lyaml && \
    /usr/local/openresty/luajit/bin/luarocks install lua-resty-http && \
    /usr/local/openresty/luajit/bin/luarocks install lua-resty-iputils && \
    /usr/local/openresty/luajit/bin/luarocks install lua-resty-jwt


ENTRYPOINT []
CMD ["/usr/local/openresty/bin/openresty", "-g", "daemon off;"]
