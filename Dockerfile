FROM ruby:2.7-buster

RUN apt-get update

ENV SRC_PATH /app
RUN mkdir -p $SRC_PATH
WORKDIR $SRC_PATH

ADD . .

CMD ["ruby", "docRep.rb"]
