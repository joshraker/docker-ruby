FROM quay.io/aptible/ubuntu:12.04

RUN apt-get update && \
    apt-get -y install wget build-essential zlib1g-dev libssl-dev \
    libreadline6-dev libyaml-dev && cd /tmp && \
    wget -q http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.2.tar.gz && \
    tar xzf ruby-2.2.2.tar.gz && \
    cd ruby-2.2.2 && ./configure --enable-shared --prefix=/usr && \
    make && make install && cd .. && rm -rf ruby-2.2.2*
RUN gem install bundler

ADD test /tmp/test
RUN bats /tmp/test
