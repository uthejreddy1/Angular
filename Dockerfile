# Use a stable Node.js LTS base image
FROM node:18.17.1-apline AS build

# Set working directory
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy application source
COPY . .

# Build the application
RUN npm run build

# Check if the output path is correct
RUN ls -la /app/dist
RUN ls -la /app/dist/hello-world

# Use an nginx image to serve the app
FROM nginx:stable
COPY --from=build /app/hello-world /usr/share/nginx/html

# Expose port 80
EXPOSE 80
