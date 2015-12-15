#!/bin/bash
echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > TEST-pipeline.xml
echo "<testsuite name=\"pipeline\" tests=\"1\" errors=\"0\" failures=\"0\" skip=\"0\">" >> TEST-pipeline.xml

# Gradle
./unit-test-cli.sh "Gradle 1.12" "gradle is not available or not version 1.12" 'gradle -v | grep "Gradle 1.12"' 'gradle -v' >> TEST-pipeline.xml
_test_exit_code=$?

# Gradle 2
export ORIGINAL_PATH=$PATH
export PATH=$GRADLE2_HOME/bin:$PATH
./unit-test-cli.sh "Gradle 2.9" "gradle is not available or not version 2.9" 'gradle -v | grep "Gradle 2.9"' 'gradle -v' >> TEST-pipeline.xml
_test_exit_code=$?
export PATH=$ORIGINAL_PATH

# LogMet Repo
./unit-test-cli.sh "LogMet Repo" "Unable to install mt-logstash-forwarder" 'sudo apt-get update && sudo apt-get -y install mt-logstash-forwarder && sudo service mt-logstash-forwarder restart && sudo service mt-logstash-forwarder stop' >> TEST-pipeline.xml
_test_exit_code=$?

echo "</testsuite>" >> TEST-pipeline.xml
exit $_test_exit_code