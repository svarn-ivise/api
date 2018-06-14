FROM trestletech/plumber
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get install apt-utils -y
RUN apt-get install libmariadbclient-dev -y
RUN apt-get install dialog apt-utils -y
RUN apt-get update -y
RUN apt-get install -y mysql-client
RUN R -e 'install.packages("RMySQL")'
RUN mkdir -p /app/
WORKDIR /app/
COPY api.R /app/
CMD ["/app/api.R"]
