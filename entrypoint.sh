#!/bin/bash
set -e

CONFIG_FILE="/var/www/html/config.php"

echo "🔧 Initialisation de PlaySMS..."

# Création du fichier config.php si absent
if [ ! -f "$CONFIG_FILE" ]; then
    echo "🆕 Création du fichier config.php..."

cat <<EOF > $CONFIG_FILE
<?php
\$core_config['db']['type'] = 'mysql';
\$core_config['db']['host'] = getenv('DB_HOST');
\$core_config['db']['user'] = getenv('DB_USER');
\$core_config['db']['pass'] = getenv('DB_PASS');
\$core_config['db']['name'] = getenv('DB_NAME');
\$core_config['webservices']['enable'] = true;
\$core_config['webservices']['auth'] = true;
EOF

    echo "✔ config.php généré."
else
    echo "✔ config.php déjà présent."
fi

echo "🚀 Démarrage d'Apache..."
exec apache2-foreground
