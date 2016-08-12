#!/bin/bash


# Using flag files should be avoided - for real-world usage, I would investigate deeper
# into hadoop to determine if each step needs to be run
[[ -f /.configure-hadoop ]] || { echo "Not configuring hadoop, flag file missing" >&2; exit 1; }

# Format the NameNode
sudo -u hdfs hdfs namenode -format
_ret=${?}
if [ ${_ret} -ne 0 ]; then
   echo "error formatting namenode hdfs" >&2
   exit ${_ret}
fi

# Start HDFS
cd /etc/init.d
for service in `ls hadoop-hdfs-*`; do
   service ${service} start
   _ret=${?}
   if [ ${_ret} -ne 0 ]; then
      echo "error starting service ${service}" >&2
      exit ${_ret}
   fi
done

# Create Hadoop directories
/usr/lib/hadoop/libexec/init-hdfs.sh
_ret=${?}
if [ ${_ret} -ne 0 ]; then
   echo "error initializing hdfs" >&2
   exit ${_ret}
fi

# Start YARN
for service in hadoop-yarn-resourcemanager hadoop-yarn-nodemanager hadoop-mapreduce-historyserver; do
   service ${service} start
   _ret=${?}
   if [ ${_ret} -ne 0 ]; then
      echo "error starting yarn services: ${service}" >&2
      exit ${_ret}
   fi
done

# Create the directory for synthesys
sudo -u hdfs hadoop fs -mkdir /Synthesys
sudo -u hdfs hadoop fs -chown synthesys /Synthesys
