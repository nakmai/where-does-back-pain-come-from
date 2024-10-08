FROM ruby:3.1.4
ENV LANG C.UTF-8
ENV TZ Asia/Tokyo

RUN apt-get update -qq \
&& apt-get install -y ca-certificates curl gnupg \
&& mkdir -p /etc/apt/keyrings \
&& curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
&& NODE_MAJOR=20 \
&& echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
&& wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
&& echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn vim

# 作業ディレクトリの作成
RUN mkdir /where-does-back-pain-come-from
WORKDIR /where-does-back-pain-come-from

# GemfileとGemfile.lockを先にコピー
COPY Gemfile Gemfile.lock ./

# 依存関係のインストール
RUN gem install bundler
RUN bundle install

# アプリケーションコードをコピー
COPY . /where-does-back-pain-come-from

# Railsをインストール（すでにGemfileで管理している場合は不要）
# RUN gem install rails

CMD ["bash", "-c", "bundle exec rails server -b 0.0.0.0 -p ${PORT}"]
RUN bundle exec rake assets:precompile

