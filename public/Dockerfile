FROM nginx:1.15.3

ARG apiurl

COPY ../../../.rvm/gems/ruby-2.4.4/gems/activestorage-5.2.1/app/assets/javascripts /usr/share/nginx/html

RUN sed -i -- 's/APIENDPOINT/'"$apiurl"'/g' /usr/share/nginx/html/index.html

