# Step 1: Use an official Node.js image to build the app
FROM node:16 AS build

# Step 2: Set the working directory
WORKDIR /app

# Step 3: Copy package.json and package-lock.json (or yarn.lock) to install dependencies
COPY package*.json ./

# Step 4: Install dependencies
RUN npm install

# Step 5: Install Angular CLI (ensure correct version)
RUN npm install -g @angular/cli

# Step 6: Copy the entire Angular project to the container
COPY . .

# Step 7: Build the Angular project (without --prod to test)
RUN npm run build || tail -n 50 /root/.npm/_logs/*.log

# Step 8: Use a lightweight web server (like Nginx) to serve the Angular app
FROM nginx:alpine

# Step 9: Copy the built Angular files from the build stage to the Nginx server
COPY --from=build /app/dist/hello-world /usr/share/nginx/html

# Step 10: Expose the default Nginx port
EXPOSE 80

# Step 11: Run Nginx to serve the app
CMD ["nginx", "-g", "daemon off;"]
