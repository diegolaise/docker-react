################################################
# Docker en mode prod avec nginx
#
# nginx is in 80 port
#
# RUN:
# docker build .
# docker run -p 8080:80 <container-id>
#
# LAUNCH :
# http://localhost:8080
#
################################################

#--- BUILD PHASE ----
# Builder
FROM node:current-alpine as builder

# Volume
WORKDIR '/app'
COPY package.json .  
RUN npm install
# copy . of the volume from . : local
COPY . .
# Build phase
RUN npm run build

#--- RUN PHASE ---
FROM nginx

# COPY static-html-directory /usr/share/nginx/html
COPY --from=builder /app/build /usr/share/nginx/html
