#!/bin/bash

# 看门狗脚本，调用crontab定时检查任务，挂掉则重启

user=""
task_num=$(ps -ef|grep user|grep -v grep|grep xxx|wc -l)

echo `date +"%F %T"`" task num : $task_num"
if [[ $task_num -lt 1 ]];then
    echo -e "\tTask is not running, restart."
    bash xxx.sh 1 1>>log/xxx.log 2>&1 &
else
    echo -e "\tTask is running, do nothing."
fi
