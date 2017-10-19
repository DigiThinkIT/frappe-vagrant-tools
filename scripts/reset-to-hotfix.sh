#!/bin/bash

if [ -z "$USER" ]; then
	ME=`whoami`
else
	ME=$USER
fi

FRAPPE_BASE=/home/$ME/frappe-bench

for dir in $FRAPPE_BASE/apps/*/;
do
	dir=${dir%*/}
	app=${dir##*/}
	app_path=$FRAPPE_BASE/apps/$app

	echo "-- APP: $app";
	cd $app_path || { echo "Path not found: $app_path"; exit 1; }
	git stash
	branch=hotfix

	git config core.filemode false
	git config --global core.autocrlf true

	if [ "$app" == "frappe" ] || [ "$app" == "erpnext" ]; then
		branch=customv9
	fi
		
	git checkout $branch

	git fetch --all
	git reset --hard @{u}
	git clean -f -d
	
done
