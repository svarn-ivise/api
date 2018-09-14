FROM trestletech/plumber
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get install libmariadbclient-dev -y
RUN apt-get update -y
RUN apt-get install -y mysql-client
RUN apt-get install -y r-cran-rcppeigen
RUN R -e 'install.packages("RMySQL",dependencies=T)'
RUN R -e 'install.packages("ranger",dependencies=T)'
#RUN mkdir -p /app/
#WORKDIR /app/
#COPY api.R /app/
#COPY rf.rds /app/
#CMD ["/app/api.R"]
CMD ["api.R"]
