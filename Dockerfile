FROM node:14.21.3 as builder

USER root
WORKDIR /workspace
COPY package.json ./
RUN yarn
COPY ./ ./
RUN npm run build


FROM nginx
WORKDIR /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /usr/src/app/dist  /usr/share/nginx/html/

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
