#!/bin/bash
echo "🚀 Installing Complete n8n AI Stack with Models..."

# Update system
echo "📦 Updating system..."
apt update && apt upgrade -y

# Install Node.js
echo "📦 Installing Node.js..."
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt install -y nodejs postgresql postgresql-contrib curl wget git vim htop

# Install n8n
echo "📦 Installing n8n..."
npm install -g n8n

# Install Ollama
echo "📦 Installing Ollama..."
curl -fsSL https://ollama.ai/install.sh | sh

# Install Qdrant
echo "📦 Installing Qdrant..."
cd /tmp
wget -q https://github.com/qdrant/qdrant/releases/latest/download/qdrant-x86_64-unknown-linux-gnu.tar.gz
tar -xzf qdrant-x86_64-unknown-linux-gnu.tar.gz
mv qdrant /usr/local/bin/
chmod +x /usr/local/bin/qdrant

# Setup PostgreSQL
echo "🗄️ Setting up PostgreSQL..."
service postgresql start
sudo -u postgres psql -c "CREATE DATABASE n8n;"
sudo -u postgres psql -c "CREATE USER n8n_user WITH PASSWORD 'n8n_password';"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE n8n TO n8n_user;"
sudo -u postgres psql -c "ALTER USER n8n_user SUPERUSER;"

# Start Ollama and pull models
echo "🤖 Starting Ollama and downloading AI models..."
ollama serve &
sleep 10

echo "📥 Downloading Llama 3.2 (3B) - Chat model..."
ollama pull llama3.2:3b

echo "📥 Downloading nomic-embed-text - Embedding model..."
ollama pull nomic-embed-text

echo "📥 Downloading mxbai-embed-large - Alternative embedding model..."
ollama pull mxbai-embed-large

echo "✅ Verifying installed models..."
ollama list

# Clone n8n starter kit for reference
echo "📁 Cloning n8n AI starter kit..."
cd /workspace
git clone https://github.com/n8n-io/self-hosted-ai-starter-kit.git

echo "📦 Step X: Installing Open WebUI..."

# Install Open WebUI via pip
pip install open-webui

echo "✅ Open WebUI installed successfully!"
echo "📋 Open WebUI will use built-in ChromaDB for document storage"

echo ""
echo "🎉 INSTALLATION COMPLETE!"
echo ""
echo "📋 What was installed:"
echo "  ✅ n8n workflow platform"
echo "  ✅ Ollama LLM server"
echo "  ✅ Llama 3.2:3b (chat model)"
echo "  ✅ nomic-embed-text (embedding model)"
echo "  ✅ mxbai-embed-large (embedding model)"
echo "  ✅ Qdrant vector database"
echo "  ✅ PostgreSQL database"
echo ""
echo "🚀 Next steps:"
echo "  1. Run: /workspace/start-services.sh"
echo "  2. Create tunnels for ports: 5678, 11434, 6333"
echo "  3. Import your workflow in n8n"
echo "  4. Ready to use!"
echo ""
