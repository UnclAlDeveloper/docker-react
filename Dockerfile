# Use an existing docker image as a base
FROM node:alpine as builder

# Set working directory
WORKDIR "/usr/app"

# Copy files into container and install dependencies
COPY package.json .
RUN npm install
COPY . .

# Tell the image what to do when it starts as a container
RUN npm run build

FROM nginx 
COPY --from=builder /usr/app/build /usr/share/nginx/html

