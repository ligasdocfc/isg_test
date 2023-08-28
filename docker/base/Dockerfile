FROM ruby:3.2.1-buster

ENV PG_MAJOR=15
ENV BUNDLER_VERSION=2.4.8

# Add PostgreSQL to sources list
RUN curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
  && echo 'deb https://apt.postgresql.org/pub/repos/apt/ buster-pgdg main' $PG_MAJOR > /etc/apt/sources.list.d/pgdg.list

RUN apt-get update -yqq \
  && apt-get install -yqq --no-install-recommends \
  libpq-dev \
  postgresql-client-$PG_MAJOR \
  $(cat /tmp/Aptfile | grep -v -s -e '^#' | grep -v -s -e "^:repo:") \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log

WORKDIR /app