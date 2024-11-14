
# Step 8: Use a lightweight web server (like Nginx) to serve the Angular app
FROM nginx:alpine

# Step 9: Copy the built Angular files from the build stage to the Nginx server
COPY --from=build /app/dist/hello-world /usr/share/nginx/html
