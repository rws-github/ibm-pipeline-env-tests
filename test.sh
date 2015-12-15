# Gradle
gradle -v

# Gradle 2
export ORIGINAL_PATH=$PATH
export PATH=$GRADLE2_HOME/bin:$PATH
gradle -v | grep
export PATH=$ORIGINAL_PATH

# LogMet install
sudo apt-get update
sudo apt-get -y install mt-logstash-forwarder
sudo service mt-logstash-forwarder restart