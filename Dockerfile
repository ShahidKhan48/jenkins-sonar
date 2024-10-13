# Step 1: Specify the base image
FROM node:14 as build

# Step 2: Set the working directory
WORKDIR /app

# Step 3: Copy package.json and package-lock.json
COPY package.json package-lock.json ./

# Step 4: Install dependencies
RUN npm install

# Step 5: Copy the rest of the application files
COPY . .

# Step 6: Build the application
RUN npm run build

# Step 7: Serve the application using a lightweight server
FROM nginx:alpine

# Step 8: Copy build files to nginx's html directory
COPY --from=build /app/build /usr/share/nginx/html

# Step 9: Expose the port the app runs on
EXPOSE 80

# Step 10: Command to run the server
CMD ["nginx", "-g", "daemon off;"]
