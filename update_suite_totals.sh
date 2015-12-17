if [ $_test_exit_code -ne "0" ]; then
	_num_failures=$((_num_failures + 1))
fi
_num_tests=$((_num_tests + 1))