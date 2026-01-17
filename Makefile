# Not my favorite way to setup commands, but it was recommended in the Go Fiber docs.

.PHONY: help build run test clean docker-build docker-up docker-down docker-logs tidy

# Variables
BINARY_NAME=main
DOCKER_IMAGE=go-fiber-app
DOCKER_COMPOSE=docker-compose

# Main make target - help with commands 

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-15s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

# Go application commands

build: ## Build the application binary
	@echo "Building $(BINARY_NAME)..."
	go build -o $(BINARY_NAME) .

run: ## Run the application locally
	@echo "Running application..."
	go run main.go

test: ## Run tests
	@echo "Running tests..."
	go test -v ./...

clean: ## Remove binary and clean up
	@echo "Cleaning up..."
	rm -f $(BINARY_NAME)
	go clean

tidy: ## Tidy go.mod and go.sum
	@echo "Tidying go modules..."
	go mod tidy

# Docker compose commands

docker-build: ## Build Docker image
	@echo "Building Docker image..."
	$(DOCKER_COMPOSE) build

docker-up: ## Start Docker containers
	@echo "Starting Docker containers..."
	$(DOCKER_COMPOSE) up -d

docker-down: ## Stop Docker containers
	@echo "Stopping Docker containers..."
	$(DOCKER_COMPOSE) down

docker-logs: ## View Docker logs
	@echo "Viewing Docker logs..."
	$(DOCKER_COMPOSE) logs -f app

docker-restart: docker-down docker-up ## Restart Docker containers

docker-rebuild: docker-down ## Rebuild and restart Docker containers
	@echo "Rebuilding and restarting..."
	$(DOCKER_COMPOSE) up --build -d

# Go code formatting commands

fmt: ## Format Go code
	@echo "Formatting code..."
	go fmt ./...

vet: ## Run go vet
	@echo "Running go vet..."
	go vet ./...

dev: ## Run in development mode
	@echo "Starting development server..."
	go run main.go

.DEFAULT_GOAL := help
