FROM debian:stable-slim

RUN apt-get update && \
    apt-get install -y curl python && \
    rm -rf /var/lib/apt/lists/*

RUN curl -s https://shopify.github.io/themekit/scripts/install.py | python

COPY "predeploy.sh" "/predeploy.sh"
RUN chmod +x /predeploy.sh
RUN ./predeploy.sh -p $MAIN_SHOPIFY_PASSWORD -s $MAIN_SHOPIFY_STORE_URL -t $MAIN_SHOPIFY_THEME_ID

COPY "entrypoint.sh" "/entrypoint.sh"
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
