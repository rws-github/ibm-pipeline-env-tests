#!/bin/bash
echo "" > _temp.xml

_num_tests=0
_num_failures=0

# Java 7
./unit-test-cli.sh "Java 7" "java is not available or not version 1.7.0" 'java -version | grep "java version \"1.7.0\""' 'java -version' >> _temp.xml
_test_exit_code=$?
source update_suite_totals.sh

# Java 8
export ORIGINAL_PATH=$PATH
export PATH=$JAVA8_HOME/bin:$PATH
./unit-test-cli.sh "Java 8" "java is not available or not version 1.8.0" 'java -version | grep "java version \"1.8.0\""' 'java -version' >> _temp.xml
_test_exit_code=$?
export PATH=$ORIGINAL_PATH
source update_suite_totals.sh

# Gradle
./unit-test-cli.sh "Gradle 1.12" "gradle is not available or not version 1.12" 'gradle -v | grep "Gradle 1.12"' 'gradle -v' >> _temp.xml
_test_exit_code=$?
source update_suite_totals.sh

# Gradle 2
export ORIGINAL_PATH=$PATH
export PATH=$GRADLE2_HOME/bin:$PATH
./unit-test-cli.sh "Gradle 2.9" "gradle is not available or not version 2.9" 'gradle -v | grep "Gradle 2.9"' 'gradle -v' >> _temp.xml
_test_exit_code=$?
export PATH=$ORIGINAL_PATH
source update_suite_totals.sh

# LogMet Repo
./unit-test-cli.sh "LogMet Repo" "Unable to install mt-logstash-forwarder" 'sudo apt-get update && sudo apt-get install -y mt-logstash-forwarder && sudo service mt-logstash-forwarder restart && sudo service mt-logstash-forwarder stop' >> _temp.xml
_test_exit_code=$?
source update_suite_totals.sh

echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > TEST-pipeline.xml
echo "<testsuite name=\"pipeline\" tests=\"$_num_tests\" errors=\"0\" failures=\"$_num_failures\" skip=\"0\">" >> TEST-pipeline.xml
cat _temp.xml >> TEST-pipeline.xml
echo "</testsuite>" >> TEST-pipeline.xml
rm _temp.xml
exit $_test_exit_code