# Build Stage
FROM node:22-alpine AS builder
WORKDIR /app


COPY package.json  ./
COPY package-lock.json ./
RUN npm install --frozen-lockfile
COPY . . 
RUN npm run build

# Production Stage
FROM node:22-alpine AS runner

WORKDIR /app

COPY --from=builder /app/package.json . 
COPY --from=builder /app/package-lock.json .

# Install production dependencies only
RUN npm install --prod

# Copy necessary project files
COPY --from=builder /app/node_modules ./node_modules
COPY --from=build /app/.nginx/nginx.conf /etc/nginx/conf.d/default.conf

ENV NODE_ENV=production

CMD ["npm", "run", "build"]

FROM nginx:1.13-alpine

COPY --from=builder /app/build /usr/share/nginx/html

ENTRYPOINT ["nginx", "-g", "daemon off;"]