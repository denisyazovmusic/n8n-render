FROM docker.n8n.io/n8nio/n8n:latest

# Устанавливаем зависимости для Puppeteer
RUN apt-get update && apt-get install -y \
  chromium-browser \
  libx11-xcb1 \
  libxcomposite1 \
  libxdamage1 \
  libxi6 \
  libxtst6 \
  libnss3 \
  libcups2 \
  libxss1 \
  libxrandr2 \
  libasound2 \
  libatk1.0-0 \
  libatk-bridge2.0-0 \
  libgtk-3-0 \
  --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

# Устанавливаем Puppeteer как зависимость проекта
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install puppeteer
COPY . .

# Указываем путь к Chromium (опционально, если уже в Render)
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Запускаем n8n
CMD ["n8n"]
