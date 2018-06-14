FROM trestletech/plumber
RUN R -e 'install.packages(c("RMySQL"))'
RUN mkdir -p /app/
WORKDIR /app/
COPY api.R /app/
CMD ["/app/api.R"]
