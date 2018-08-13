FROM node:10.6.0

# Allow env overwrite for image
ARG ENV=production

COPY ./package.json ./package.json
COPY ./yarn.lock ./yarn.lock

# Set to production, we can always overwrite this
ENV NODE_ENV ${ENV}

# Install (with linked local modules)
RUN yarn install --ignore-scripts
RUN npm rebuild grpc

# Add dependency source files
COPY ./index.js ./index.js

# Safe user
USER node

# Serve, for a pure execution
CMD node ./index.js
