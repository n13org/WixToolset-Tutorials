FROM node:22-bookworm-slim

RUN apt-get update \
    && apt-get -y upgrade \
    && DEBIAN_FRONTEND=noninteractive \
    apt-get install --no-install-recommends --assume-yes \
    ca-certificates \
    curl \
    jq

WORKDIR /ws

COPY docker/scripts/*.sh .
RUN chmod +x /ws/*.sh

COPY docker/package.json .
COPY docker/package-lock.json .
COPY docker/playwright.config.ts .

COPY docker/tests/*.spec.ts ./tests/

RUN npm install
RUN npx playwright install
RUN npx playwright install-deps

VOLUME [ "/ws/data" ]
VOLUME [ "/ws/playwright-report" ]
