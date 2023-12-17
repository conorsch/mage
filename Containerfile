FROM debian:stable AS builder

# Install Java dependencies
RUN apt-get update && apt-get install -y \
        --no-install-recommends \
        openjdk-17-jre-headless \
        maven \
        make \
        unzip \
        && apt-get clean \
        && rm -r /var/lib/apt/lists/*

# Copy in source code
WORKDIR /usr/src/freemage
COPY . .
# Build it
RUN make install
# Unpack built ZIP artifacts
RUN mkdir -p /opt/freemage/server && mkdir -p /opt/freemage/public
# Also provide the ZIP artifacts so it's easier to host installers.
# RUN cp /usr/src/freemage/deploy/mage-server.zip /opt/freemage/public/
RUN cp /usr/src/freemage/deploy/mage-client.zip /opt/freemage/public/
RUN unzip /usr/src/freemage/deploy/mage-server.zip -d /opt/freemage/server

# Prepare runtime image
FROM harbor.ruin.dev/library/default
RUN apt-get update && apt-get install -y \
        --no-install-recommends \
        openjdk-17-jre-headless \
        python3 \
        && apt-get clean \
        && rm -r /var/lib/apt/lists/*
COPY --from=builder /opt/freemage /opt/freemage
RUN chown user:user -R /opt/freemage
WORKDIR /opt/freemage/server

# Run start server script
CMD ["/opt/freemage/server/startServer.sh"]

# Run webserver to share client zip. It's not static, so unlikely
# to work on all targets.
# CMD ["python3", "-m", "http.server", "-d", "/opt/freemage/public"]
