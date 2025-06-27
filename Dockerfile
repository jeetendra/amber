FROM node:20-alpine AS build

WORKDIR /app

COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

COPY . .
RUN yarn build

# --------------------------------------
FROM node:20-alpine AS production
WORKDIR /app
ENV NODE_ENV=production

COPY --from=build /app/public ./public
COPY --from=build /app/.next/standalone ./
COPY --from=build /app/.next/static ./.next/static

RUN yarn install --production --frozen-lockfile --ignore-scripts && \
    yarn cache clean && \
    addgroup -g 1010 -S appgroup && \
    adduser -u 1010 -S -G appgroup appuser

USER appuser
EXPOSE 8080
ENV PORT 8080
CMD [ "node", "server.js" ]