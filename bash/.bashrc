bind -x '"\C-g": tv'
colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}
unstbl() { 
    curl -G -s --data-urlencode 'query=channel_update_time{channel="nixos-unstable"}' "https://prometheus.nixos.org/api/v1/query" | 
    jq -r --arg now $(date +%s) '.data.result[0].value[1] | tonumber | ($now | tonumber) - . | . / 60 | floor | "\(./60/24 | floor)d \(./60%24 | floor)h \(. % 60)m ago"'
}
fastfetch