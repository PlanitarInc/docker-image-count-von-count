FROM planitar/base

# Install openresty
ADD ./out/openresty /opt/openresty
ADD nginx.conf /opt/openresty/nginx/conf/nginx.conf
ENV PATH /opt/openresty/nginx/sbin:$PATH
ENV LD_LIBRARY_PATH /opt/openresty/lualib:/opt/openresty/luajit/lib:$LD_LIBRARY_PATH

# Install redis
ADD ./out/redis /opt/redis/
ENV PATH /opt/redis/bin:$PATH

# Install count-von-count
ADD ./count-von-count /count-von-count

# Install supervisord
RUN apt-get install -y supervisor
ADD ./supervisord.conf /opt/supervisor/supervisord.conf

EXPOSE 80
EXPOSE 6379
CMD ["supervisord", "-n", "-c", "/opt/supervisor/supervisord.conf"]
