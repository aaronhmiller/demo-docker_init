# Build stage
FROM denoland/deno:latest AS builder
WORKDIR /app
COPY . .
RUN deno cache app.ts

# Production stage
FROM denoland/deno:latest
WORKDIR /app
COPY --from=builder /app .
CMD ["deno", "run", "--allow-net", "app.ts"]
