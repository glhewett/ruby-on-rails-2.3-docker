FROM alpine:3.7

WORKDIR /supetube/build
RUN apk add --update \
    build-base \
    dev86 \
    imagemagick \
    libxml2-dev \
    libxslt-dev \
    perl \
    readline-dev \
    zlib-dev \
    && rm -rf /var/cache/apk/*

ADD https://cache.ruby-lang.org/pub/ruby/1.8/ruby-1.8.7-p352.tar.gz .
RUN tar zxf ruby-1.8.7-p352.tar.gz
WORKDIR /supetube/build/ruby-1.8.7-p352
RUN ./configure && make && make install && make clean

WORKDIR /supetube/build
ADD https://rubygems.org/rubygems/rubygems-1.3.1.tgz .
RUN tar zxf rubygems-1.3.1.tgz
WORKDIR /supetube/build/rubygems-1.3.1
RUN /usr/local/bin/ruby setup.rb 

# rubygems
WORKDIR /supetube/build/
ADD https://rubygems.org/downloads/rubygems-update-1.3.7.gem .
RUN gem install rubygems-update --local --no-rdoc --no-ri

# rails
WORKDIR /supetube/build/
ADD https://rubygems.org/downloads/rails-2.3.17.gem .
ADD https://rubygems.org/downloads/rake-0.8.3.gem .
ADD https://rubygems.org/downloads/rack-1.1.0.gem .
ADD https://rubygems.org/downloads/actionmailer-2.3.17.gem .
ADD https://rubygems.org/downloads/actionpack-2.3.17.gem .
ADD https://rubygems.org/downloads/activerecord-2.3.17.gem .
ADD https://rubygems.org/downloads/activeresource-2.3.17.gem .
ADD https://rubygems.org/downloads/activesupport-2.3.17.gem .
RUN gem install rails --local --no-rdoc --no-ri


# pg
WORKDIR /supetube/build/
ADD https://ftp.postgresql.org/pub/source/v8.4.22/postgresql-8.4.22.tar.gz .
RUN tar zxf postgresql-8.4.22.tar.gz
WORKDIR /supetube/build/postgresql-8.4.22
RUN ./configure --prefix=/usr/local
RUN make -j4
RUN make install
ADD https://rubygems.org/downloads/pg-0.9.0.gem .
RUN gem install pg --local --no-rdoc --no-ri

# texticle
WORKDIR /supetube/build/
ADD https://rubygems.org/downloads/texticle-1.0.3.gem .
RUN gem install texticle --local --no-rdoc --no-ri

# paperclip
WORKDIR /supetube/build/
ADD https://rubygems.org/downloads/paperclip-2.3.1.1.gem .
RUN gem install paperclip --local --no-rdoc --no-ri

# authlogic
WORKDIR /supetube/build/
ADD https://rubygems.org/downloads/authlogic-2.1.3.gem .
RUN gem install authlogic --local --no-rdoc --no-ri

# will_paginate
WORKDIR /supetube/build/
ADD https://rubygems.org/downloads/will_paginate-2.3.12.gem .
RUN gem install will_paginate --local --no-rdoc --no-ri

# declarative_authorization
WORKDIR /supetube/build/
ADD https://rubygems.org/downloads/declarative_authorization-0.4.1.gem .
RUN gem install declarative_authorization --local --no-rdoc --no-ri

# nokogiri
WORKDIR /supetube/build/
ADD https://rubygems.org/downloads/nokogiri-1.4.4.gem .
RUN gem install nokogiri --local --no-rdoc --no-ri

# delayed_job
WORKDIR /supetube/build/
ADD https://rubygems.org/downloads/daemons-1.0.10.gem .
ADD https://rubygems.org/downloads/delayed_job-2.0.7.gem .
RUN gem install delayed_job --local --no-rdoc --no-ri
