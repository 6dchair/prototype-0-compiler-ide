FROM node:20-bookworm

RUN apt-get update && \
    apt-get install -y \
    flex \
    bison \
    build-essential && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

# Build the P0 compiler
RUN make

# Build the React frontend
RUN npm --prefix frontend install
RUN npm --prefix frontend run build

# Install backend dependencies
RUN npm --prefix web-backend install

CMD ["node", "web-backend/server.js"]