    # Use an official PHP runtime as a parent image
    FROM php:8.2-fpm

    # Set the working directory
    WORKDIR /var/www/sipintar

    # Install Composer
    RUN curl -sS https://getcomposer.org/download/stable/composer.phar -o /usr/local/bin/composer
    RUN chmod a+x /usr/local/bin/composer

    # Copy application directory
    COPY . .

    # Install dependencies
    RUN composer install --no-dev

    # Set permissions
    RUN chown -R www-data:www-data ./storage ./bootstrap/cache

    # Set environment variable
    ENV APP_ENV=production
    ENV APP_DEBUG=false
    ENV APP_URL=http://localhost

    # User
    USER www-data

    # Set port 9000 to expose it for other container to reach
    EXPOSE 80

    # Command to run the application
    # In this case, we use the artisan command to run the application
    CMD ["php-fpm"]
