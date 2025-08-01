showArg() {
	for ((argnum = 1; argnum <= $#; argnum++)); do
		echo "${!argnum}"
	done
	printf '%s\n' "---------------------"
	printf '%s\n' "$#"

}

env

printf '%s\n' "---------------------"

for word in "$@"; do
	printf '%s\n' "$word"
done

printf '%s\n' "---------------------"

printf '%s\n' "$0"

printf '%s\n' "---------------------"

printf '%s\n' "$#"

printf '%s\n' "---------------------"

showArg 1 2 3

printf '%s\n' "---------------------"

showArg x1 x2 x3

printf '%s\n' "---------------------"

showArg "x 1" x2 x3
