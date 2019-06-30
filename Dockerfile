FROM rmkn/nginx-lua

ENV REDIS2MOD_VERSION 0.15
ENV SETMISCMOD_VERSION 0.32

# download redis module for nginx
RUN curl -fSL https://github.com/openresty/redis2-nginx-module/archive/v${REDIS2MOD_VERSION}.tar.gz -o redis2_nginx_module.tar.gz \
	&& tar -zxC /usr/local/src -f redis2_nginx_module.tar.gz \
    && rm redis2_nginx_module.tar.gz

# download string module for nginx
RUN curl -fSL https://github.com/openresty/set-misc-nginx-module/archive/v${SETMISCMOD_VERSION}.tar.gz -o set_misc_nginx_module.tar.gz \
	&& tar -zxC /usr/local/src -f set_misc_nginx_module.tar.gz \
    && rm set_misc_nginx_module.tar.gz

# add 2 previous modules to nginx
RUN cd /usr/local/src/nginx-${NGINX_VERSION} \
	&& ./configure --prefix=/usr/local/nginx \
	    --with-ld-opt="-Wl,-rpath,/usr/local/luajit/lib" \
	    --with-http_sub_module \
	    --add-module=../ngx_devel_kit-${NDK_VERSION} \
	    --add-module=../lua-nginx-module-${LUAMOD_VERSION} \
	    --add-module=../redis2-nginx-module-${REDIS2MOD_VERSION} \
	    --add-module=../set-misc-nginx-module-${SETMISCMOD_VERSION} \
	&& make \
	&& make install

# create live link to nginx.conf
RUN ln -sf /nginx/nginx.conf /usr/local/nginx/conf/nginx.conf