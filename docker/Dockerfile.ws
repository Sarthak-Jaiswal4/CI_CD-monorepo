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

COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/pnpm-workspace.yaml ./pnpm-workspace.yaml
COPY --from=builder /app/pnpm-lock.yaml ./pnpm-lock.yaml
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/packages ./packages
COPY --from=builder /app/apps/ws/dist ./apps/ws/dist
COPY --from=builder /app/apps/ws/package.json ./apps/ws/package.json

RUN pnpm install --frozen-lockfile

EXPOSE 8080

CMD ["node", "apps/ws/dist/index.js"]