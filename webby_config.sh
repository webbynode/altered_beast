sudo gem install rspec highline ruby-debug RedCloth --no-rdoc --no-ri
sudo gem install rails --version=2.1.1 --no-rdoc --no-ri

echo WC_DB_ENGINE=${WC_DB_ENGINE}
 
if [ "${WC_DB_ENGINE}" == "mysql" ]; then
echo "
production:
    adapter: mysql
    database: ${WC_APP_NAME}
    username: ${WC_APP_NAME}
    password: ${WC_DB_PASSWORD}
    host: localhost
    encoding: utf8
" > config/database.yml
fi
 
if [ "${WC_DB_ENGINE}" == "postgresql" ]; then
echo "
production:
    adapter: postgresql
    encoding: unicode
    database: ${WC_APP_NAME}
    pool: 5
    username: ${WC_APP_NAME}
    password: ${WC_DB_PASSWORD}
    host: localhost
    port: 5432
" > config/database.yml
fi

rake gems:install

rake tmp:create RAILS_ENV=production
rake app:bootstrap RAILS_ENV=production << EOF
n
y
localhost
Beast
admin
${WC_DB_PASSWORD}
you@example.com
EOF

chown www-data log