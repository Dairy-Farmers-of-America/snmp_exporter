#!/bin/sh
echo "Custom script can go here."
exec /bin/snmp_exporter "$@"