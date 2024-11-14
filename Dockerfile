# Use a stable Node.js LTS base image
FROM tiangolo/node-frontend:10 as build-stage
# Set working directory
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy application source
COPY ./ /app/

# Build the application
RUN npm run build

# Check if the output path is correct
RUN ls -la /app/dist
RUN ls -la /app/dist/hello-world

# Use an nginx image to serve the app
FROM nginx:stable
COPY --from=build /app/dist/hello-world/ /usr/share/nginx/html

COPY --from=build-stage /nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80
