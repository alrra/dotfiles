FROM debian:jessie
MAINTAINER thiagoalessio <thiagoalessio@me.com>

RUN apt-get -y update &&\
	apt-get -y install python python-pip git-core vim \
	--no-install-recommends

RUN git clone https://github.com/junegunn/vader.vim.git
RUN pip install covimerage codecov
