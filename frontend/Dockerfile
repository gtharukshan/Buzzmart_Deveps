# Stage 1: Build the React App
FROM node:18 AS build

WORKDIR /app

COPY package.json ./
RUN npm install

COPY . .
RUN npm run build

# Stage 2: Serve the Build with Nginx
FROM nginx:alpine

# Copy built files to Nginx HTML directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 3000 (Nginx default port)
EXPOSE 80

# Start Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf
CMD ["nginx", "-g", "daemon off;"]

