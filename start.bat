@echo off
REM Docker Compose Startup Script for Todo App (Windows)
REM This script helps you start all three services (frontend, backend, websocket) 
REM connected to the same Docker network

echo 🚀 Starting Todo App with Docker Compose...

REM Check if .env file exists
if not exist .env (
    echo ⚠️  .env file not found. Creating from .env.example...
    if exist .env.example (
        copy .env.example .env
        echo 📝 Please edit .env file with your actual DATABASE_URL
        echo    Current DATABASE_URL: your_database_url_here
        echo.
        pause
    ) else (
        echo ❌ .env.example file not found. Please create .env file manually.
        exit /b 1
    )
)

REM Check if docker-compose is installed
docker-compose --version >nul 2>&1
if errorlevel 1 (
    echo ❌ docker-compose is not installed. Please install Docker Compose first.
    exit /b 1
)

REM Check if Docker is running
docker info >nul 2>&1
if errorlevel 1 (
    echo ❌ Docker is not running. Please start Docker first.
    exit /b 1
)

echo 🔧 Building and starting services...

REM Build and start all services
docker-compose up --build -d

echo.
echo ✅ All services are now running!
echo.
echo 🌐 Access your applications:
echo    Frontend:  http://localhost:3000
echo    Backend:   http://localhost:3001
echo    WebSocket: http://localhost:8080
echo.
echo 📊 To view logs:
echo    docker-compose logs -f
echo.
echo 🛑 To stop all services:
echo    docker-compose down
echo.
echo 🔄 To restart services:
echo    docker-compose restart
echo.

REM Show running containers
echo 📋 Currently running containers:
docker-compose ps

pause
