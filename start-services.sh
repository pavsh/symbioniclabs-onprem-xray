#!/bin/bash
echo "🚀 Starting n8n AI Stack Services..."

# Start PostgreSQL
echo "🗄️ Starting PostgreSQL..."
service postgresql start

# Start Ollama (models already downloaded)
echo "🤖 Starting Ollama..."
ollama serve &
sleep 5

echo "📋 Available models:"
ollama list

# Start Qdrant
echo "🔍 Starting Qdrant..."
qdrant &
sleep 5

# Set environment and start n8n
echo "⚙️ Setting up n8n environment..."
export N8N_PORT=5678
export DB_TYPE=postgresdb
export DB_POSTGRESDB_HOST=localhost
export DB_POSTGRESDB_USER=n8n_user
export DB_POSTGRESDB_PASSWORD=n8n_password
export N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=false

echo ""
echo "🎉 Starting n8n on port 5678..."
echo ""
echo "📡 Service URLs (create tunnels for these):"
echo "  🌐 n8n: http://localhost:5678"
echo "  🤖 Ollama: http://localhost:11434"
echo "  🔍 Qdrant: http://localhost:6333"
echo ""
echo "✅ All services starting..."
echo "💡 Create tunnels in vast.ai for ports: 5678, 11434, 6333"
echo ""

n8n start
