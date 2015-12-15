#!/bin/bash
# $1 - test name
# $2 - description of failure
# $3 - test cli
# $4 - failure output
eval $3 > /dev/null
_exit_code=$?
if [ "0" -eq "$_exit_code" ]; then
	echo "<testcase name=\"$1\"></testcase>"
else
	echo "<testcase name=\"$1\"><failure message=\"$2\">"
	eval $4
	echo "</failure></testcase>"
fi
exit $_exit_code