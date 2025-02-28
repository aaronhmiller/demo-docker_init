// app.ts
import { Application, Router } from "https://deno.land/x/oak@v12.6.1/mod.ts";

// Create a new application instance
const app = new Application();
const router = new Router();

// Define a simple route
router.get("/", (ctx) => {
  ctx.response.body = {
    message: "Hello World from Deno with Oak!",
  };
});

// Add a route to serve HTML
router.get("/hello", (ctx) => {
  ctx.response.headers.set("Content-Type", "text/html");
  ctx.response.body = `
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Deno Hello World</title>
      <style>
        body {
          font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
          max-width: 800px;
          margin: 0 auto;
          padding: 2rem;
          text-align: center;
          line-height: 1.6;
        }
        h1 {
          color: #333;
        }
        .card {
          background-color: #f9f9f9;
          border-radius: 8px;
          padding: 2rem;
          box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
          margin-top: 2rem;
        }
      </style>
    </head>
    <body>
      <h1>Hello World from Deno!</h1>
      <div class="card">
        <p>This is a simple web application built with Deno and Oak framework.</p>
        <p>Current time: ${new Date().toLocaleString()}</p>
      </div>
    </body>
    </html>
  `;
});

// Register middleware
app.use(router.routes());
app.use(router.allowedMethods());

// Add a basic logging middleware
app.use(async (ctx, next) => {
  const start = Date.now();
  await next();
  const ms = Date.now() - start;
  console.log(`${ctx.request.method} ${ctx.request.url} - ${ms}ms`);
});

// Start the server
const PORT = 8080;
console.log(`Server running on http://localhost:${PORT}`);

await app.listen({ port: PORT });
