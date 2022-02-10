# Run
docker build -t snmp-exporter .

# Example
docker run \
--env SNMP-EXPORTER-USERNAME="test" \
--env SNMP-SECURITY-LEVEL="authPriv" \
--env SNMP-EXPORTER-AUTH-PROTOCOL="SHA" \
--env SNMP-EXPORTER-PRIV-PROTOCOL="AES" \
--env SNMP-EXPORTER-PASSWORD="test" \
--env SNMP-EXPORTER-PRIV-PASSWORD="test" \
-p 9116:9116 \
-it snmp-exporter "$@"

