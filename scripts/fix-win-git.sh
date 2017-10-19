#!/bin/bash

default_branch=hotfix

apps_path=$1

if [ -z "$apps_path" ]; then
	echo "Missing apps path"
	exit 1
fi


for dir in $apps_path/*
do
	app_path=${dir%*/}
	app_name=${dir##*/}

	cd $apps_path/$app_name

	echo "--- APP: $appspath/$app_name"

	git config core.filemode false
	git config --global core.autocrlf true

	git fetch --all
	
	if [ "$app_name" == "frappe" ] || [ "$app_name" == "erpnext" ]; then
		git checkout develop
	else
		git checkout $default_branch
	fi

	git reset --hard @{u}


	cd ../..
done
