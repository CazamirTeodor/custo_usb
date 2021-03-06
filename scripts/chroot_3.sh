#!/bin/bash

#-------------------------
# 1 argument
#linux-image-amd64 			for debian buster
#linux-image-generic:amd64 	for ubuntu focal
#-------------------------

if [ $# -eq 0 ]

	then

	echo "Nu au fost introduse argumentele necesare "
	exit 1

else

	touch executa.sh

	echo "#!/bin/bash

	apt-get install -y software-properties-common
	add-apt-repository universe
	apt-get update
	apt-get install --no-install-recommends $1 -y live-boot systemd-sysv" >> executa.sh

	sudo chmod +x executa.sh
	cat executa.sh
	sudo mv executa.sh LIVE_BOOT/chroot
	
	
	sudo chroot LIVE_BOOT/chroot bash -c /executa.sh $1
	sudo rm LIVE_BOOT/chroot/executa.sh

fi


