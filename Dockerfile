# 1. Empezar con una imagen oficial de Node.js
FROM node:18-slim

# 2. Instalar todas las dependencias del sistema que Puppeteer necesita
# Esta es la parte que Railway estaba ignorando
RUN apt-get update && apt-get install -y \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libgtk-3-0 \
    libgbm-dev \
    libasound2 \
    libnss3 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libxfixes3 \
    libpango-1.0-0 \
    libcairo2 \
    libgobject-2.0-0 \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# 3. Preparar la carpeta para el código de nuestro bot
WORKDIR /app

# 4. Copiar los archivos de dependencias e instalarlas
COPY package*.json ./
RUN npm install

# 5. Copiar el resto del código del bot
COPY . .

# 6. Definir el comando para iniciar el bot
CMD [ "npm", "start" ]