FROM node:20-alpine AS builder

RUN npm install -g pnpm

WORKDIR /app

COPY ./pnpm-workspace.yaml ./pnpm-workspace.yaml 
COPY ./packages ./packages
COPY ./pnpm-lock.yaml ./pnpm-lock.yaml

COPY ./package.json ./package.json
COPY ./turbo.json ./turbo.json

COPY ./apps/ws ./apps/ws

RUN pnpm install --frozen-lockfile

RUN pnpm run db:migrate

RUN pnpm run build --filter=ws


FROM node:20-alpine AS runner

RUN npm install -g pnpm
WORKDIR /app

COPY --from=builder /app/apps/ws/package.json ./
COPY --from=builder /app/apps/ws/dist ./dist

EXPOSE 8080

CMD ["node", "dist/index.js"]