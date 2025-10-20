# 1. Empezar con la imagen completa de Node.js v18 para máxima compatibilidad
FROM node:18

# 2. Definir una variable de entorno para decirle a Puppeteer dónde está Chrome
# Esto a menudo soluciona los problemas de "no se encuentra el archivo"
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/google-chrome-stable

# 3. Instalar la lista de dependencias completa y verificada
# Usamos un comando ligeramente diferente para asegurar que todo se instale correctamente
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    gconf-service \
    libasound2 \
    libatk1.0-0 \
    libc6 \
    libcairo2 \
    libcups2 \
    libdbus-1-3 \
    libexpat1 \
    libfontconfig1 \
    libgcc1 \
    libgconf-2-4 \
    libgdk-pixbuf2.0-0 \
    libglib2.0-0 \
    libgtk-3-0 \
    libnspr4 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libstdc++6 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxss1 \
    libxtst6 \
    ca-certificates \
    fonts-liberation \
    libappindicator1 \
    libnss3 \
    lsb-release \
    xdg-utils \
    wget \
    && rm -rf /var/lib/apt/lists/*

# 4. Preparar la carpeta para el código de nuestro bot
WORKDIR /app

# 5. Copiar los archivos de dependencias e instalarlas
COPY package*.json ./
RUN npm install

# 6. Copiar el resto del código del bot
COPY . .

# 7. Definir el comando para iniciar el bot
CMD [ "npm", "start" ]