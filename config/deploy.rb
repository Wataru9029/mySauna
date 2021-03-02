# capistranoのバージョンを記載。固定のバージョンを利用し続け、バージョン変更によるトラブルを防止する
lock '3.15.0'

# Capistranoのログの表示に利用する
set :application, 'mySauna'
set :deploy_to, '/var/www/rails/mySauna'
set :keep_releases, 5

# どのリポジトリからアプリをpullするかを指定する
set :repo_url,  'git@github.com:Wataru9029/mySauna.git'

# バージョンが変わっても共通で参照するディレクトリを指定
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :rbenv_type, :user
set :rbenv_ruby, '2.5.3'

# どの公開鍵を利用してデプロイするか
set :ssh_options, auth_methods: ['publickey'],
                  keys: ['~/.ssh/mysauna.pem']

# puma
set :puma_init_active_record, true