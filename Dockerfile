FROM node:alpine As development

WORKDIR /usr/src/app

COPY . .

# RUN npm install -g pnpm

RUN npm install
# RUN pnpm install

COPY . .

RUN npm run build
# RUN pnpm run build

FROM node:alpine as production

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /usr/src/app

COPY package.json ./
# COPY pnpm-lock.yaml ./

# RUN npm install -g pnpm

RUN npm install --prod
# RUN pnpm install --prod

COPY --from=development /usr/src/app/dist ./dist

CMD ["node", "dist/main"]