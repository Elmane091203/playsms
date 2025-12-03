#!/bin/bash
set -e

CFG=/var/www/html/config.php

# Remplacer les variables d'environnement dans config.php
php -r "
\$cfg = file_get_contents('$CFG');
\$cfg = preg_replace(\"/\\\$core_config\\['db'\\]\\['host'\\]\\s*=\\s*'.*';/\", \"\$core_config['db']['host'] = '\" . getenv('DB_HOST') . \"';\", \$cfg);
\$cfg = preg_replace(\"/\\\$core_config\\['db'\\]\\['name'\\]\\s*=\\s*'.*';/\", \"\$core_config['db']['name'] = '\" . getenv('DB_NAME') . \"';\", \$cfg);
\$cfg = preg_replace(\"/\\\$core_config\\['db'\\]\\['user'\\]\\s*=\\s*'.*';/\", \"\$core_config['db']['user'] = '\" . getenv('DB_USER') . \"';\", \$cfg);
\$cfg = preg_replace(\"/\\\$core_config\\['db'\\]\\['passwd'\\]\\s*=\\s*'.*';/\", \"\$core_config['db']['passwd'] = '\" . getenv('DB_PASS') . \"';\", \$cfg);
file_put_contents('$CFG', \$cfg);
"

# Droits Apache
chown -R www-data:www-data /var/www/html

# Lancer Apache
exec "$@"
