FROM ruby:2.3-alpine
RUN set -ex && \
  apk --update --upgrade add \
    bash curl-dev build-base \
    zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev postgresql-dev \
    git && \

  gem install -N bundler && \

  # cleanup and settings
  bundle config --global build.nokogiri  "--use-system-libraries" && \
  bundle config --global build.nokogumbo "--use-system-libraries" && \
  find / -type f -iname \*.apk-new -delete && \
  rm -rf /var/cache/apk/* && \
  rm -rf /usr/lib/lib/ruby/gems/*/cache/* && \
  rm -rf ~/.gem

WORKDIR /app
ADD . /app
