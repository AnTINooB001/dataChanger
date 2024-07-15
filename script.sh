#!/bin/bash
 
if [ "$EUID" -ne 0 ]; then 
  zenity --password | sudo -S echo ""
fi


selected_date=$(zenity --calendar --title="select date" --date-format="%Y-%m-%d")
if [ $? -ne 0 ]; then
    zenity --error --text="date was not selected."
    exit 1
fi


selected_time=$(zenity --entry --title="enter time" --text="enter time in 24H format")
if [ $? -ne 0 ]; then
    zenity --error --text="time was no selected."
    exit 1
fi


datetime="${selected_date} ${selected_time}:00"


echo $datetime | sudo date -s "$datetime"
if [ $? -eq 0 ]; then
    zenity --info --text="date and time successfully changed on ${datetime}."
else
    zenity --error --text="wrong, date and time not changed."
fi
