FROM trestletech/plumber
RUN mkdir -p /app/
WORKDIR /app/
COPY api.R /app/
CMD ["/app/api.R"]