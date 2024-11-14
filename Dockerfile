# Step 1: Use an official Node.js image to build the app
FROM node:16 AS build

# Step 2: Set the working directory
WORKDIR /app

# Step 3: Copy package.json and package-lock.json (or yarn.lock) to install dependencies
COPY package*.json ./

# Step 4: Install dependencies
RUN npm install

# Step 5: Copy the entire Angular project to the container
COPY . .

# Step 6: Build the Angular project
RUN npm run build --prod

# Step 7: Use a lightweight web server (like Nginx) to serve the Angular app
FROM nginx:alpine

# Step 8: Copy the built Angular files from the build stage to the Nginx server
COPY --from=build /app/dist/your-app-name /usr/share/nginx/html

# Step 9: Expose the default Nginx port
EXPOSE 80

# Step 10: Run Nginx to serve the app
CMD ["nginx", "-g", "daemon off;"]

