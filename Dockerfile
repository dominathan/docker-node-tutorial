# FROM node:14.15.4-alpine
# ENV NPM_CACHE_FOLDER /root/.npm
# ARG NPM_TOKEN

# # RUN apk add --no-cache .gyp python3 make \
# #   && npm install \
# #   && apk del .gyp \
# #   && rm -rf /var/cache/apk/*
  

# WORKDIR /app
# COPY package*.json ./
# RUN --mount=type=cache,id=npm-cache-docker-ci,target=${NPM_CACHE_FOLDER} \
#   npm ci --cache ${NPM_CACHE_FOLDER} --prefer-offline

# # RUN echo "//registry.npmjs.org/:_authToken=$NPM_TOKEN" > .npmrc \
# #  && npm install \
# #  && rm -f .npmrc

# # COPY .npmrc . && echo "ECHO echo echoo..." > .npmrc
# # RUN npm install
# # RUN rm .npmrc

# COPY . .

# # RUN npm run test

# RUN npm prune --production

# RUN chown -R node:node /app 
# USER node

# EXPOSE 3000
# # ENTRYPOINT ["node", "app.js"]

FROM node:14.15.4-alpine as base
ENV NPM_CACHE_FOLDER /root/.npm
ARG NPM_TOKEN
WORKDIR /app
COPY package*.json .
RUN --mount=type=cache,id=npm-cache-docker-ci,target=${NPM_CACHE_FOLDER} \
  echo "//registry.npmjs.org/:_authToken=$NPM_TOKEN" > .npmrc \
  && npm ci --cache ${NPM_CACHE_FOLDER} --prefer-offline \
  && rm .npmrc

COPY . /app

FROM base as local
RUN apk add --update bash curl
EXPOSE 3000
ENTRYPOINT ["npm", "run", "dev"]

FROM node:14.15.4-alpine as production
WORKDIR /app
COPY --from=base /app /app/
RUN npm prune --production
RUN chown -R node:node /app 
USER node
EXPOSE 3000
ENTRYPOINT ["node", "app.js"]


FROM local
