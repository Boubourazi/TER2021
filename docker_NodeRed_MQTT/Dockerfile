# From the doc of nodered -> https://nodered.org/docs/getting-started/docker
FROM nodered/node-red

# install custom package
COPY node-red/package.json .
RUN npm install --unsafe-perm 

# load custom settings
COPY node-red/settings.js /data/settings.js
COPY node-red/flows.json /data/flows.json