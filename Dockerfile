# 1. Empezar con la imagen completa de Node.js v18 para máxima compatibilidad
FROM node:18

# 2. Instalar wget para poder descargar archivos
RUN apt-get update && apt-get install -y wget

# 3. Descargar e instalar la versión estable de Google Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install -y google-chrome-stable --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# 4. Definir la variable de entorno para decirle a Puppeteer dónde está Chrome
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/google-chrome-stable

# 5. Instalar el resto de las dependencias del sistema que puedan ser necesarias
RUN apt-get update && apt-get install -y \
    gconf-service \
    libasound2 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
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
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# 6. Preparar la carpeta para el código de nuestro bot
WORKDIR /app

# 7. Copiar los archivos de dependencias e instalarlas
COPY package*.json ./
RUN npm install

# 8. Copiar el resto del código del bot
COPY . .

# 9. Definir el comando para iniciar el bot
CMD [ "npm", "start" ]