# pull official base image
FROM node:14.2.0-alpine as build

# set working directory
WORKDIR /app

# add app
COPY . ./

# install app dependencies
RUN yarn

# build application
RUN yarn build

# production environment
FROM nginx:stable-alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]