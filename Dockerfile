# Use the official Node.js 18 image
FROM node:18-alpine

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install --legacy-peer-deps

# Copy the entire React app source code to the container
COPY . .

# Build the React app
RUN npm run build

# Expose port 3000 (the port your Node.js app runs on)
EXPOSE 3000

# Start the Node.js app
CMD ["npm", "start"]


# Optional:  Add a health check
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD curl -f http://localhost/ || exit 1
