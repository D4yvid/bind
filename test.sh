#!/bin/bash

ESC="\033"

RESET="$ESC[m"

BOLD="$ESC[1m"
DIM="$ESC[2m"

GREEN="$ESC[32m"
RED="$ESC[31m"

log() {
	echo -e "$BOLD * $RESET$DIM$1$RESET: $2"
}

info() {
	echo -e "$BOLD * $RESET$@$RESET"
}

pass() {
	echo -e "$BOLD * ${GREEN}PASS $@$RESET"
}

fail() {
	echo -e "$BOLD * ${RED}FAIL $@$RESET"
}

info "Running tests... ($(date))"

TEST_FILES="$(find ./test -type f -not -name '*.c')"
FAIL="0"
SUCCESS="0"

for file in $TEST_FILES; do
	info "Running test $DIM$file$RESET..."

	sh -c "$file" 2>&1 | while read -r line; do
		log "$file" "$line"
	done

	CODE=$?

	if [ "$CODE" != "0" ]; then
		fail "$file"
		FAIL=$((FAILED+1))
	else
		pass "$file"
		SUCCESS=$((SUCCESS+1))
	fi
done

info "Summary:"
info "  ${GREEN}Tests passed:${RESET} $SUCCESS"
info "  ${RED}Tests failed:${RESET} $FAIL"

if [ $FAIL -gt 0 ]; then exit 1; fi
