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

# Use a lightweight server to serve the static assets
FROM nginx:alpine

# Copy the built React app (from the previous stage) to Nginx's web root
COPY --from=0 /app/build /usr/share/nginx/html

# Expose port 80 for the Nginx server
EXPOSE 80

# Optional:  Add a health check
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD curl -f http://localhost/ || exit 1
