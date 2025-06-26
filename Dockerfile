FROM node:20-alpine AS base

WORKDIR /app

COPY package*.json ./

RUN npm install

FROM base AS build
COPY --from=base /app/node_modules ./node_modules
COPY . .
RUN npm run build

FROM base AS production

WORKDIR /app

ENV NODE_ENV=production


RUN addgroup -g 1010 -S appgroup && \
    adduser -u 1010 -S -G appgroup appuser

COPY --from=build /app/public ./public
COPY --from=build --chown=appuser:appgroup /app/.next/standalone ./
COPY --from=build --chown=appuser:appgroup /app/.next/static ./static

RUN npm prune --omit=dev

USER appuser

EXPOSE 8080

ENV PORT 8080

CMD [ "node", "server.js" ]