FROM node:14
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .  # Copy all files from the host to /usr/src/app in the container
CMD ["node", "index.js"]
