# Use the official WordPress image as the base
FROM wordpress:latest

# Set the database configuration directly in wp-config.php
RUN { \
        echo "define('DB_NAME', 'wordpress');"; \
        echo "define('DB_USER', 'ppm-staging');"; \
        echo "define('DB_PASSWORD', 'R@9jL#7Gz$4Tn&2W');"; \
        echo "define('DB_HOST', '10.20.50.84');"; \
        echo "define('DB_CHARSET', 'utf8mb4');"; \
        echo "define('DB_COLLATE', '');"; \
        echo "define('AUTH_KEY',         'put your unique phrase here');"; \
        echo "define('SECURE_AUTH_KEY',  'put your unique phrase here');"; \
        echo "define('LOGGED_IN_KEY',    'put your unique phrase here');"; \
        echo "define('NONCE_KEY',        'put your unique phrase here');"; \
        echo "define('AUTH_SALT',        'put your unique phrase here');"; \
        echo "define('SECURE_AUTH_SALT', 'put your unique phrase here');"; \
        echo "define('LOGGED_IN_SALT',   'put your unique phrase here');"; \
        echo "define('NONCE_SALT',       'put your unique phrase here');"; \
    } > /usr/src/wordpress/wp-config.php
