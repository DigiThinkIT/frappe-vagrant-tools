#!/bin/bash

apps_path=$1

if [ -z "$apps_path" ]; then
	echo "Missing apps path"
	exit 1
fi


for dir in $apps_path/*
do
	app_path=${dir%*/}

	if [ ${dir##*/} == "frappe" ] || [ ${dir##*/} == "erpnext" ]; then
		continue
	fi

	echo "Installing $apps_path"

	cd $app_path

	if [ -f requirements.txt ]; then
		echo "--- Installing Requirements"
		pip install -r requirements.txt
	else
		echo "Requirements not found..."
	fi

	if [ -f setup.py ]; then
		echo "--- Installing app"
		pip install -e ./
	fi

	cd ..
done
