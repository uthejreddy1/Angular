# Use a stable Node.js LTS base image
FROM node:18 AS build

# Set working directory
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy application source
COPY . .

# Build the application
RUN npm run build --prod

# Use an nginx image to serve the app
FROM nginx:alpine
COPY --from=build /app/dist/helloworld /usr/share/nginx/html

# Expose port 80
EXPOSE 80
