FROM nginx:1.15.3

ARG apiurl

COPY . /usr/share/nginx/html

RUN sed -i -- 's/APIENDPOINT/'"$apiurl"'/g' /usr/share/nginx/html/index.html

