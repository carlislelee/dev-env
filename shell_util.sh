#! /bin/bash

hadoop="/opt/tiger/yarn_deploy/hadoop/bin/hadoop"
hive="/opt/tiger/hive_deploy/bin/hive"

wait_partition(){
    db=$1
    table=$2
    part=$3
    chktime=1
    maxchktime=720
    if [ $# -gt 3 ];then
        maxchktime=$4
    fi
    ret=$(${hive} -e "use $db;show partitions $table"|grep -P "$part"|wc -l)
    while [ $ret -lt 1 ];do
        echo "Waiting for partition $part of ${db}.${table}, check time:$chktime ..."
        sleep 10
        ((chktime++))
        if [ $chktime -gt $maxchktime ];then
            return 1
        fi
        ret=$(${hive} -e "use $db;show partitions $table"|grep -P "$part"|wc -l)
    done
    echo "Found partition $part of ${db}.${table} ~"
    return 0
}

wait_path(){
    hpath=$1
    chktime=1
    maxchktime=720
    if [ $# -gt 1 ];then
        maxchktime=$2
    fi
    ${hadoop} fs -test -e "${hpath}"
    while [ $? -ne 0 ];do
        echo "Waiting for hdfs path : $hpath, check time:$chktime ..."
        sleep 10
        ((chktime++))
        if [ $chktime -gt $maxchktime ];then
            return 1
        fi
        ${hadoop} fs -test -e "${hpath}"
    done
    echo "Found hdfs path : $hpath"
    return 0
}

hdistcp(){
    if [ $# -lt 3 ];then
        echo "usage : hdistcp [sourcePath] [targetPath] [jobname]"
        exit 1
    fi
    sourcePath=$1
    targetPath=$2
    jobname=$3
    wait_path ${sourcePath}
    ${hadoop} fs -rm -r "${sourcePath}/_SUCCESS"
    ${hadoop} fs -rm -r "${targetPath}"
    HADOOP_USER_NAME=tiger ${hadoop} distcp -Dmapreduce.job.queuename="offline.data" -Dmapreduce.job.name="${jobname}" -skipcrccheck -update "${sourcePath}" "${targetPath}"
    if [ $? -ne 0 ];then
        return $?
    fi
    ${hadoop} fs -touchz "${sourcePath}/_SUCCESS"
    ${hadoop} fs -touchz "${targetPath}/_SUCCESS"
    return $?
}
