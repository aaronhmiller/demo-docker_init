// First, add these dependencies to your Cargo.toml:
// [dependencies]
// actix-web = "4.3.1"
// tokio = { version = "1.32.0", features = ["full"] }

use actix_web::{get, App, HttpResponse, HttpServer, Responder};

#[get("/")]
async fn hello_world() -> impl Responder {
    HttpResponse::Ok().body("Hello, World!")
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    println!("Server starting at http://0.0.0.0:8080");
    
    HttpServer::new(|| {
        App::new()
            .service(hello_world)
    })
    .bind(("0.0.0.0", 8080))?
    .run()
    .await
}
