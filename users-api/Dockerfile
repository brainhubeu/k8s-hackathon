FROM node AS builder

RUN mkdir /build
WORKDIR /build

COPY package.json yarn.lock ./

RUN yarn install

COPY . .

RUN yarn build

FROM node

WORKDIR /app

COPY package.json ./

RUN yarn install --production

COPY --from=builder /build/dist ./dist

CMD ["npm", "run", "start:prod"]

