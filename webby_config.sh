sudo gem install rspec

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

rake tmp:create RAILS_ENV=production
rake app:bootstrap RAILS_ENV=production

chown www-data log