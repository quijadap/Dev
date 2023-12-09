#!/bin/bash

for sqlFile in /home/oracle/scripts/setup/*.sql; do
   echo "##############################################################################################################"
   echo "Aplicando control de cambio $sqlFile"
   echo "##############################################################################################################"
   sqlplus / as sysdba << EOF
@$sqlFile
exit;
EOF
done

echo "#################################################################"
echo "#                                                               #"
echo "#          Control(es) aplicado(s) satisfactoriamente!          #"
echo "#                                                               #"
echo "#################################################################"

