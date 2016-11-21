FROM ruby:2.2

RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs

RUN mkdir -p /code
WORKDIR /code

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
