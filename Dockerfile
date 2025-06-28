# 1. Choose the base image - this is your starting point
FROM node:18-alpine

# 2. Set the working directory inside the container
WORKDIR /app

# 3. Copy package.json and package-lock.json first (for better caching)
COPY package*.json ./

# 4. Install dependencies
RUN npm ci --only=production

# 5. Copy the rest of your application code
COPY . .

# 6. Create uploads directory for file storage
RUN mkdir -p public/uploads

# 7. Expose the port your app runs on
EXPOSE 1234

# 8. Create a non-root user for security
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nodejs -u 1001
RUN chown -R nodejs:nodejs /app
USER nodejs

# 9. Define the command to start your application
CMD ["npm", "start"]
