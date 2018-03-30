#!/bin/bash
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%35s%s%-20s\n' "TCP Tweaker 1.0" ; tput sgr0
if [[ `grep -c "^#PH56" /etc/sysctl.conf` -eq 1 ]]
then
	echo ""
	echo "Las configuraciones de red TCP Tweaker ya se han agregado en el sistema!"
	echo ""
	read -p "¿Desea quitar la configuración de TCP Tweaker? [s/n]: " -e -i n resposta0
	if [[ "$resposta0" = 's' ]]; then
		grep -v "^#PH56
net.ipv4.tcp_window_scaling = 1
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_rmem = 4096 87380 16777216
net.ipv4.tcp_wmem = 4096 16384 16777216
net.ipv4.tcp_low_latency = 1
net.ipv4.tcp_slow_start_after_idle = 0" /etc/sysctl.conf > /tmp/syscl && mv /tmp/syscl /etc/sysctl.conf
sysctl -p /etc/sysctl.conf > /dev/null
		echo ""
		echo "Las configuraciones de red TCP Tweaker se han eliminado correctamente."
		echo ""
	exit
	else 
		echo ""
		exit
	fi
else
	echo ""
	echo "Este script es experimental, uselo con su propio riesgo!"
	echo "Este script alterara configuraciones de red"
	echo "del sistema para reducir la latencia y mejorar la velocidad."
	echo ""
	read -p "¿Desea continuar con la instalacion? [s/n]: " -e -i n resposta
	if [[ "$resposta" = 's' ]]; then
	echo ""
	echo "Modificando las siguientes configuraciones:"
	echo " " >> /etc/sysctl.conf
	echo "#PH56" >> /etc/sysctl.conf
echo "net.ipv4.tcp_window_scaling = 1
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_rmem = 4096 87380 16777216
net.ipv4.tcp_wmem = 4096 16384 16777216
net.ipv4.tcp_low_latency = 1
net.ipv4.tcp_slow_start_after_idle = 0" >> /etc/sysctl.conf
echo ""
sysctl -p /etc/sysctl.conf
		echo ""
		echo "La configuración de red TCP Tweaker se ha agregado correctamente."
		echo ""
	else
		echo ""
		echo "¡La instalación ha sido cancelada por el usuario!"
		echo ""
	fi
fi
exit