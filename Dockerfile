FROM php:8.0-apache

# Habilitar mod_rewrite
RUN a2enmod rewrite

# Atualizar repositórios e instalar dependências de sistema
RUN apt-get update && apt-get install -y \
    git \
    zip \
    unzip \
    libzip-dev \
    && docker-php-ext-install zip mysqli pdo pdo_mysql \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
    
# Instalar o Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copiar os arquivos da aplicação
COPY . /var/www/html/

# Definir diretório de trabalho
WORKDIR /var/www/html/

# Instalar dependências PHP
RUN composer install

EXPOSE 80
