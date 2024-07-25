FROM ruby:3.1.3
# yarn, curl, apt-transport-https, wget, nodejs をインストール。
# 最後に、不要なキャッシュやパッケージリストを削除し、Dockerイメージのサイズを最小限に抑える。
RUN apt-get update && apt-get install -y curl apt-transport-https wget nodejs && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
apt-get update && apt-get install -y yarn && \
apt-get clean && \
rm -rf /var/lib/apt/lists/*
FROM --platform=linux/amd64 nginx:latest

# 作業ディレクトリ
RUN mkdir /app
WORKDIR /app

# ローカルのGemfileをコンテナへコピー
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
# Gemfile に記載されているgem(ここでは Rails)をインストール
RUN bundle install

# ソースコードをコンテナへコピー
COPY . /app

# JSの依存パッケージをインストール、アセットをコンパイル
RUN yarn install --check-files

# Rails特有の問題を回避するために、コンテナ実行時にPIDファイルを削除
COPY entrypoint.zsh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.zsh
ENTRYPOINT ["entrypoint.zsh"]

# 3000番ポートを設定
EXPOSE 3000

# Railsサーバを起動
CMD ["rails", "server", "-b", "0.0.0.0"]