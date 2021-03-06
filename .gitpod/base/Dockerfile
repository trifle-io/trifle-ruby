FROM ubuntu:20.04

ENV TZ=Europe/Bratislava
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN useradd gitpod -u 33333
RUN mkdir -p /home/gitpod && chown gitpod:gitpod /home/gitpod

# install ubuntu packages
RUN apt-get update -q \
 && apt-get install -y \
    build-essential \
    apt-transport-https \
    bash \
    xterm \
    xvfb \
    x11vnc \
    libpq-dev \
    git \
    curl \
    wget \
    unzip \
    dirmngr \
    gpg \
    gnupg2 \
    locales \
    autoconf \
    libncurses5-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libpng-dev \
    unixodbc-dev \
    libssl-dev \
    libreadline-dev \
    zlib1g-dev \
    ffmpeg \
    tmux \
    runit-systemd \
    htop \
    vim \
 && apt-get clean

#set the locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN curl -fsSL https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add -
RUN echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.4.list

RUN apt-get update -q \
 && apt-get install -y \
    postgresql postgresql-contrib \
    # mongodb-org \
    redis-server \
    mariadb-server \
 && apt-get clean

USER gitpod

#install asdf
ENV ASDF_ROOT /home/gitpod/.asdf
ENV PATH "${ASDF_ROOT}/bin:${ASDF_ROOT}/shims:$PATH"
RUN git clone https://github.com/asdf-vm/asdf.git ${ASDF_ROOT} --branch v0.8.0

RUN asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git

# install ruby
ENV RUBY_VERSION 3.0.0
RUN ASDF_RUBY_BUILD_VERSION=v20201225 asdf install ruby ${RUBY_VERSION} \
  && asdf global ruby ${RUBY_VERSION}

# throw errors if Gemfile has been modified since Gemfile.lock
RUN gem install bundler

CMD ["bash"]
