FROM jekyll/jekyll:3.8.3 as build-stage

ENV PORT=8080

WORKDIR /tmp

COPY Gemfile* ./

RUN bundle install

WORKDIR /usr/src/app

COPY . .

RUN chown -R jekyll .

RUN jekyll build

FROM nginx:alpine

EXPOSE $PORT

COPY --from=build-stage /usr/src/app/_site/ /usr/share/nginx/html
