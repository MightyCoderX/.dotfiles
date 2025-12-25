#!/usr/bin/env bash

# remove commands ending in \ from history
# that where ran by mistake when
# using compact physical keyboard layout where the
# top part of what is supposed to be an the L shaped
# enter key is actually another key
# identifying them by checking if the command right after
# is the same without the ending \

mistakes=()

HISTFILE=~/.bash_history
HISTTIMEFORMAT=
history -r

prev_match=""
prev_lineno=0
while read -r entry; do
	IFS=' ' read -r lineno cmd <<<"$entry"
	if [[ "$cmd" =~ ^.*\\$ ]]; then
		prev_match="${BASH_REMATCH[0]}"
		prev_lineno=$lineno
		continue
	fi

	shopt -s extglob
	if [[ -n $prev_match && "${prev_match%%*( )\\}" == "$cmd" ]]; then
		shopt -u extglob
		echo "  '$prev_match'"
		echo "  '$cmd'"
		echo found match
		mistakes+=("$prev_lineno")
		prev_match=
		prev_lineno=
	fi
done < <(history)
echo

echo Deleting...
printf '%s\n' "${mistakes[@]}"

echo
for ((i = ${#mistakes[@]} - 1; i >= 0; i--)); do
	history -d "${mistakes[i]}"
done

history -w
