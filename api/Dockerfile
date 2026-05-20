FROM node:20-alpine

WORKDIR /app

ENV API_PORT=3000

COPY package*.json ./
RUN npm install --only=production

COPY app.js ./

RUN addgroup -S nodejs && adduser -S nodeuser -G nodejs
USER nodeuser

EXPOSE ${API_PORT}

HEALTHCHECK --interval=30s --timeout=5s --start-period=15s --retries=3 \
  CMD wget -qO- "http://127.0.0.1:${API_PORT}/healthz" >/dev/null || exit 1

CMD ["npm", "start"]
