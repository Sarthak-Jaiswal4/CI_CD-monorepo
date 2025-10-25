#!/bin/bash

# Docker Compose Startup Script for Todo App
# This script helps you start all three services (frontend, backend, websocket) 
# connected to the same Docker network

set -e

echo "🚀 Starting Todo App with Docker Compose..."

# Check if .env file exists
if [ ! -f .env ]; then
    echo "⚠️  .env file not found. Creating from .env.example..."
    if [ -f .env.example ]; then
        cp .env.example .env
        echo "📝 Please edit .env file with your actual DATABASE_URL"
        echo "   Current DATABASE_URL: your_database_url_here"
        echo ""
        read -p "Press Enter to continue after updating .env file..."
    else
        echo "❌ .env.example file not found. Please create .env file manually."
        exit 1
    fi
fi

# Check if docker-compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "❌ docker-compose is not installed. Please install Docker Compose first."
    exit 1
fi

# Check if Docker is running
if ! docker info &> /dev/null; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi

echo "🔧 Building and starting services..."

# Build and start all services
docker-compose up --build -d

echo ""
echo "✅ All services are now running!"
echo ""
echo "🌐 Access your applications:"
echo "   Frontend:  http://localhost:3000"
echo "   Backend:   http://localhost:3001"
echo "   WebSocket: http://localhost:8080"
echo ""
echo "📊 To view logs:"
echo "   docker-compose logs -f"
echo ""
echo "🛑 To stop all services:"
echo "   docker-compose down"
echo ""
echo "🔄 To restart services:"
echo "   docker-compose restart"
echo ""

# Show running containers
echo "📋 Currently running containers:"
docker-compose ps
