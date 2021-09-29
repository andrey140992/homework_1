FROM ruby:2.7-buster


ADD . /Sinatra-Docker
WORKDIR /Sinatra-Docker
RUN bundle install

EXPOSE 4567

CMD ["/bin/bash"]