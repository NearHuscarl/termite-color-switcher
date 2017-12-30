#!/bin/env bash

# Usage:
# $ ./setup.sh

USAGE="Usage: setup.sh [-h|--help]"
HELP="\
setup.sh
Commands:
  -h, --help      print this help message
  A script to set up termite config to work"

SUCCESS_INFO="\
Your termite config ~/.config/termite/config has been split into two other
configs (~/.config/termite/option && ~/.config/termite/color/default) which you
should use to edit your settings from now on because the original file
(~/.config/termite/config) will be overwrite when using the color command

The ~/.config/termite/color/default stores info in the color section and the
~/.config/termite/option stores the rest of the config (options and hints
section)."

set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace

function die () {
	echo "$*" >&2
	exit 1
}

function usage() {
	die "$USAGE"
}

function help() {
	echo "$HELP"
}

function backup_config() {
	cp "$CONFIG" "$BACKUP_CONFIG"
}

function set_current_colorscheme() {
	local color_name="$1"
	echo "$color_name" > "$THEME"
}

function print_info() {
	echo "$SUCCESS_INFO"
}

function split_config_into_two() {
	backup_config
	mkdir -p "$COLOR_PATH"

	local color_section=false
	while read -r line || [[ -n "$line" ]]; do
		if [[ "$line" =~ ^\[colors\]$ ]]; then
			color_section=true
		elif [[ "$line" =~ ^\[(hints|options)\]$ ]]; then
			color_section=false
		fi

		if [[ "$color_section" == true ]]; then
			echo "$line" >> "$COLOR_PATH"/default
		elif [[ "$color_section" == false ]]; then
			echo "$line" >> "$OPTION"
		fi
	done < "$BACKUP_CONFIG"
	print_info
}

function add_sample_colorschemes() {
	[[ -d "$COLOR_PATH" ]] || mkdir -p "$COLOR_PATH"
	cp color/* "$COLOR_PATH"
}

function setup() {
	[[ ! -f "$CONFIG" ]] && die 'termite config ~/.config/termite/config not exists'

	set_current_colorscheme 'default'
	split_config_into_two
	add_sample_colorschemes
}

function main() {
	local termite_path="$HOME"'/.config/termite'
	local OPTION="$termite_path"'/option'
	local CONFIG="$termite_path"'/config'
	local BACKUP_CONFIG="$termite_path"'/config.backup'
	local THEME="$termite_path"'/theme'
	local COLOR_PATH="$termite_path"'/color'

	local flag="$@"
	case "$#" in
		0)
			setup ;;
		*)
			case "$flag" in
				-h|--help)
					help ;;
				*)
					usage ;;
			esac
	esac
}

main "$@"
