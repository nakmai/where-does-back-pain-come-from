# ベースイメージ
FROM ruby:3.1.4

# 環境設定
ENV LANG C.UTF-8
ENV TZ Asia/Tokyo

# Node.jsとYarnのインストール
RUN curl -sL https://deb.nodesource.com/setup_19.x | bash - \
  && wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -y build-essential libpq-dev postgresql-client nodejs yarn

# Chrome関連の依存パッケージをインストール（オプション）
RUN apt-get install -y curl unzip xvfb libxi6 libgconf-2-4

# 作業ディレクトリを作成
RUN mkdir /app
WORKDIR /app

# Bundlerのインストール
RUN gem install bundler

# GemfileとGemfile.lockをコピー
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# Yarnのロックファイルをコピー
COPY yarn.lock /app/yarn.lock

# 必要なGemとYarnパッケージをインストール
RUN bundle install
RUN yarn install

# アプリケーションコードをコピー
COPY . /app

# ポート3000を公開
EXPOSE 3000

# wait-for-it.sh をコンテナにコピー
COPY wait-for-it.sh /usr/bin/wait-for-it.sh
RUN chmod +x /usr/bin/wait-for-it.sh

# Railsサーバーを0.0.0.0で起動（Herokuなど外部からの接続に対応）
# 起動前に tmp/pids/server.pid を削除する
CMD ["bash", "-c", "rm -f tmp/pids/server.pid && bundle exec rails server -b '0.0.0.0'"]



