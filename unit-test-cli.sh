#!/bin/bash
# $1 - test name
# $2 - description of failure
# $3 - test cli
# $4 - failure output
eval $3 > _test_output.log 2>&1
_exit_code=$?
if [ "0" -eq "$_exit_code" ]; then
	echo "<testcase name=\"$1\"></testcase>"
else
	echo "<testcase name=\"$1\"><failure message=\"$2\">"
	if [ -z "$4" ]; then
		cat _test_output.log
	else
 		eval $4 2>&1
	fi
	echo "</failure></testcase>"
fi
rm _test_output.log
exit $_exit_code