# Stage 1 (build) :

FROM node:20-alpine AS build
WORKDIR /app

COPY mon-app/package*.json ./
RUN npm install

COPY mon-app/ ./

ARG BUILD_ID=local
ENV VITE_BUILD_ID=$BUILD_ID
RUN npm run build

# Stage 2 (production) :
FROM nginx:alpine AS production
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]