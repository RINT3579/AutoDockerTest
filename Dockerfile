# ベースイメージの取得
FROM ubuntu:20.04

# メタデータの登録
LABEL maintainer="作成者の氏名"
LABEL version="2.0"
LABEL description="DockerFileのテスト Apacheサーバー起動"

# 必要パッケージのインストール
RUN apt update
RUN apt install -y tzdata
RUN apt install -y apache2
RUN apt install -y git

#ローカライズ
RUN apt-get install locales
RUN locale-gen ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LC_CTYPE ja_JP.UTF-8
RUN localedef -f UTF-8 -i ja_JP ja_JP.utf8

# 開発環境用のサイト構築（この部分が本番環境とは異なる！）
COPY ./dev_site.conf /etc/apache2/sites-available/
RUN git clone --depth 1 -b dev https://github.com/RINT3579/DockerTest.git /var/www/html/dev
RUN a2dissite 000-default
RUN a2ensite dev_site

# ポート開放
EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]