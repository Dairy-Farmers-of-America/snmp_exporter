FROM golang:alpine

#Install Packages
RUN apk add --no-cache git
RUN apk add --no-cache make
RUN apk add --no-cache curl
RUN apk add --no-cache gcc
RUN apk add --no-cache musl-dev
RUN apk add --no-cache net-snmp-dev
RUN apk add --no-cache python3
RUN apk add --no-cache py3-pip
RUN apk add --no-cache python3-dev
RUN apk add --no-cache libffi-dev
RUN apk add --no-cache openssl-dev
RUN apk add --no-cache cargo
RUN pip install azure-cli --no-cache-dir

#Pull Latest SNMP Exporter
RUN mkdir /home/build
WORKDIR /home/build
RUN git clone https://github.com/Dairy-Farmers-of-America/snmp_exporter.git
WORKDIR /home/build/snmp_exporter

#Compile SNMP Exporter
RUN make

#Copy to runspace
RUN mkdir /etc/snmp_exporter
RUN cp /home/build/snmp_exporter/snmp_exporter  /bin/snmp_exporter
RUN cp /home/build/snmp_exporter/snmp.yml       /etc/snmp_exporter/snmp.yml

#Copy entrypoint wrapper
COPY entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh

#Cleanup
RUN rm -Rf /home/build

EXPOSE      9116
ENTRYPOINT  [ "/bin/entrypoint.sh" ]
CMD         [ "--config.file=/etc/snmp_exporter/snmp.yml" ]