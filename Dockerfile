FROM node:18-alpine AS builder
WORKDIR /app
COPY app/package*.json ./
RUN npm install --only=production
COPY app/. .

FROM gcr.io/distroless/nodejs18
WORKDIR /app
COPY --from=builder /app /app
USER 1001
CMD ["index.js"]
