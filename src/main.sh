#!/bin/sh
# Description : Check for battery status, if less than 15% produce audio warning
# if equal to 100, then also produce audio warning
# Author : Shubham Hibare (CR@2Y)
# Website : http://hibare.in

# Define constants
LOW_POWER_LEVEL=15
FULL_POWER_LEVEL=100

# Read current volume level
Current_volume=$(pactl list sinks | awk '/^\sVolume:/' | awk '{print $5}')

# Read power level
Power_level=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0|grep -E "percentage"| awk '{print($2)-O}')

# Read current state
Current_state=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0|grep -E "state"| awk '{print($2)}')

# Get current sink
Current_sink=$(pacmd list-sinks | awk '/index:/{i++} /* index:/{print i; exit}')
		
# Check the power level

# Check for low power level
if [ $Power_level -lt $LOW_POWER_LEVEL ]; then

	if [ "$Current_state" != "charging" ]; then
		# Mute all other applications
		pacmd list-sink-inputs|grep 'index:' | awk '{print $2}' | xargs -i"{}" pactl set-sink-input-mute {} true

        # Unmute and set volume to 100%
		pactl set-sink-volume $Current_sink 100% 
		pactl set-sink-mute $Current_sink 0
		
		# Play audio
		espeak -ven-us+f4 -s170 "warning! power level low"
				
		# Reset volume level
		pactl set-sink-volume $Current_sink $Current_volume
		
		# Unmute all other applications
		pacmd list-sink-inputs|grep 'index:' | awk '{print $2}' | xargs -i"{}" pactl set-sink-input-mute {} false
	fi
fi

# Check for full power level
if [ $Power_level -eq $FULL_POWER_LEVEL ]; then
	if [ "$Current_state" != "discharging" ]; then
		# Mute all other applications
		pacmd list-sink-inputs|grep 'index:' | awk '{print $2}' | xargs -i"{}" pactl set-sink-input-mute {} true
		
        # Unmute and set volume to 100%
		pactl set-sink-volume $Current_sink 100% 
		pactl set-sink-mute $Current_sink 0
		
		# Play audio
		espeak -ven-us+f4 -s170 "warning! power level critically high"
		
		# Reset volume level
		pactl set-sink-volume $Current_sink $Current_volume
		
		# Unmute all other applications
		pacmd list-sink-inputs|grep 'index:' | awk '{print $2}' | xargs -i"{}" pactl set-sink-input-mute {} false
	fi
fi

# End of script
