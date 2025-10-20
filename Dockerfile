# nginx alpine image for smaller size and better security
FROM nginxinc/nginx-unprivileged:1.28-alpine3.21

# Set metadata labels
LABEL maintainer="hextris-team"
LABEL description="Hextris - An addictive puzzle game inspired by Tetris"
LABEL version="1.0"
LABEL org.opencontainers.image.title="Hextris"
LABEL org.opencontainers.image.description="Hextris - An addictive puzzle game inspired by Tetris"
LABEL org.opencontainers.image.url="https://hextris.github.io/hextris"
LABEL org.opencontainers.image.source="https://github.com/hextris/hextris"
LABEL org.opencontainers.image.licenses="GPL-3.0-or-later"
LABEL org.opencontainers.image.authors="hextris-team"

# Update base OS packages to ensure latest security patches (requires root during build)
USER root
RUN apk upgrade --no-cache

# Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

# Copy the hextris application to nginx html directory
COPY app/hextris/ /usr/share/nginx/html/

# Copy nginx configuration optimized for static content
COPY app/nginx/default.conf /etc/nginx/conf.d/default.conf

# Ensure nginx user has read access to content and config
RUN chown -R nginx:nginx /usr/share/nginx/html /etc/nginx/conf.d

# Drop privileges for runtime
USER nginx

# Expose port 8080
EXPOSE 8080

# Add health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:8080/health || exit 1

# Ensure container stops gracefully
STOPSIGNAL SIGTERM

# Start nginx
CMD ["nginx", "-g", "daemon off;"]