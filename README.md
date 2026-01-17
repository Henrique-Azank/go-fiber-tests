# Go Fiber Microservice Tests

A microservice testing repository built with [Go Fiber](https://gofiber.io/) framework, PostgreSQL database, and Docker Compose for easy deployment.

## Features

- **Go Fiber Framework** - Fast, Express-inspired web framework
- **PostgreSQL Database** - Robust relational database with GORM ORM
- **Docker Compose** - Easy containerization and orchestration
- **RESTful API** - Complete CRUD operations for Users and Products
- **Health Check Endpoint** - Service monitoring
- **Auto-migrations** - Database schema managed by GORM

## Project Structure

```
.
├── main.go              # Application entry point and routing
├── database/
│   └── database.go     # Database connection and migrations
├── models/
│   ├── user.go         # User model definition
│   └── product.go      # Product model definition
├── handlers/
│   ├── user_handler.go # User CRUD handlers
│   └── product_handler.go # Product CRUD handlers
├── go.mod               # Go module dependencies
├── go.sum               # Go module checksums
├── .env                 # Environment variables (not in git)
├── .env.example         # Environment variables template
├── Dockerfile           # Multi-stage Docker build
├── .dockerignore        # Docker build exclusions
├── docker-compose.yml   # Docker Compose configuration
├── Makefile             # Build and development commands
├── LICENSE              # MIT License
└── README.md            # This file
```

## Prerequisites

- Docker and Docker Compose
- Go 1.21+ (for local development)

## Quick Start

### Using Docker Compose (Recommended)

1. **Clone and navigate to the repository**
   ```bash
   cd go-fiber-tests
   ```

2. **Set up environment variables**
   ```bash
   cp .env.example .env
   # Edit .env to customize your configuration
   ```

3. **Start the services**
   ```bash
   docker-compose up --build
   ```

4. **Access the API**
   - API: http://localhost:3000
   - Health Check: http://localhost:3000/health

5. **Stop the services**
   ```bash
   docker-compose down
   ```

   To remove volumes as well:
   ```bash
   docker-compose down -v
   ```

### Local Development

1. **Set up environment variables**
   ```bash
   cp .env.example .env
   # Edit .env and set DB_HOST=localhost
   ```

2. **Install dependencies**
   ```bash
   go mod download
   # or use make
   make tidy
   ```

3. **Start PostgreSQL** (using Docker)
   ```bash
   docker run --name postgres -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=fiberdb -p 5432:5432 -d postgres:16-alpine
   ```

4. **Run the application**
   ```bash
   go run main.go
   # or use make
   make run
   ```

### Using Make Commands

The project includes a Makefile for common tasks (Recommended in Fiber docs):

```bash
make help          # Show all available commands
make build         # Build the binary
make run           # Run locally
make test          # Run tests
make clean         # Clean up build artifacts
make tidy          # Tidy go modules
make docker-build  # Build Docker image
make docker-up     # Start containers in background
make docker-down   # Stop containers
make docker-logs   # View application logs
make docker-rebuild # Rebuild and restart
make fmt           # Format code
make vet           # Run go vet
```

## API Endpoints

### Health Check
- `GET /health` - Check service status

### Users
- `GET /api/v1/users` - Get all users
- `GET /api/v1/users/:id` - Get user by ID
- `POST /api/v1/users` - Create new user
- `PUT /api/v1/users/:id` - Update user
- `DELETE /api/v1/users/:id` - Delete user

### Products
- `GET /api/v1/products` - Get all products
- `GET /api/v1/products/:id` - Get product by ID
- `POST /api/v1/products` - Create new product
- `PUT /api/v1/products/:id` - Update product
- `DELETE /api/v1/products/:id` - Delete product

## Example Requests

### Create a User
```bash
curl -X POST http://localhost:3000/api/v1/users \
  -H "Content-Type: application/json" \
  -d '{"name":"John Doe","email":"john@example.com"}'
```

### Get All Users
```bash
curl http://localhost:3000/api/v1/users
```

### Create a Product
```bash
curl -X POST http://localhost:3000/api/v1/products \
  -H "Content-Type: application/json" \
  -d '{"name":"Laptop","description":"High-performance laptop","price":999.99}'
```

### Get All Products
```bash
curl http://localhost:3000/api/v1/products
```

## Environment Variables

The application uses a `.env` file for configuration. Copy `.env.example` to `.env` and customize as needed:

| Variable | Default | Description |
|----------|---------|-------------|
| `DB_HOST` | postgres | PostgreSQL host (use `localhost` for local dev) |
| `DB_USER` | postgres | Database user |
| `DB_PASSWORD` | postgres | Database password |
| `DB_NAME` | fiberdb | Database name |
| `DB_PORT` | 5432 | Database port |
| `PORT` | 3000 | Application port |
| `APP_NAME` | Go Fiber Microservice | Application name |
| `APP_VERSION` | 1.0.0 | Application version |

**Note**: The `.env` file is not tracked in git. Always use `.env.example` as a template.

## Database Models

### User
```go
type User struct {
    ID    uint   `json:"id"`
    Name  string `json:"name"`
    Email string `json:"email"`
}
```

### Product
```go
type Product struct {
    ID          uint    `json:"id"`
    Name        string  `json:"name"`
    Description string  `json:"description"`
    Price       float64 `json:"price"`
}
```

## Docker Services

### Application Service
- Built using multi-stage Docker build
- Runs on port 3000
- Automatically connects to PostgreSQL

### PostgreSQL Service
- PostgreSQL 16 Alpine
- Persistent volume for data
- Health checks enabled
- Runs on port 5432

## Development Tips

1. **View logs**
   ```bash
   docker-compose logs -f app
   ```

2. **Rebuild after code changes**
   ```bash
   docker-compose up --build
   ```

3. **Access PostgreSQL**
   ```bash
   docker exec -it fiber-postgres psql -U postgres -d fiberdb
   ```

4. **Reset database**
   ```bash
   docker-compose down -v
   docker-compose up --build
   ```

## Architecture

The project follows a clean, modular architecture:

- **`main.go`** - Application entry point, initializes database and sets up routes
- **`database/`** - Database connection management and migrations
- **`models/`** - Data models (User, Product) with GORM annotations
- **`handlers/`** - HTTP request handlers organized by resource
- **`.env`** - Environment-based configuration

This structure promotes:
- **Separation of concerns** - Each package has a single responsibility
- **Testability** - Handlers and database can be tested independently
- **Maintainability** - Easy to locate and modify specific functionality
- **Scalability** - Simple to add new models and handlers

## Technology Stack

- **Language**: Go 1.21
- **Web Framework**: Fiber v2
- **ORM**: GORM
- **Database**: PostgreSQL 16
- **Containerization**: Docker & Docker Compose

## License

MIT License - see [LICENSE](LICENSE) file for details

