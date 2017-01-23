FROM debian:jessie-backports

RUN set -x \
    \
    && tmppkgs='autoconf automake libtool g++ make ca-certificates wget unzip' \
    && apt-get update && apt-get install -y $tmppkgs --no-install-recommends && rm -rf /var/lib/apt/lists/* \
    \
    && cd /tmp \
    && tag=1.0.1.1 \
    && wget -O glb-$tag.zip "https://github.com/pierredavidbelanger/glb/archive/$tag.zip" \
    && unzip glb-$tag.zip \
    && cd glb-$tag \
    && ./bootstrap.sh && ./configure \
    && make && make install \
    && cd .. \
    && rm -rf glb-$tag.zip glb-$tag \
    && cd \
    \
    && apt-get purge -y --auto-remove $tmppkgs

ENTRYPOINT ["/usr/local/sbin/glbd"]