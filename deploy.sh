#!/bin/bash

REPOSITORY=/home/ubuntu/codedeploy

cd $REPOSITORY

echo "Kill curren running application"

CURRENT_PID=$(pgrep -f simpleservice*.jar)

if [ -z "$CURRENT_PID" ]; then
    echo "Not Found pid"
else 
    echo "Kill running app"
    kill $CURRENT_PID
    sleep 3
fi

JAR_NAME=$(ls -tr $REPOSITORY | grep *.jar | tail -n 1)

nohup java -jar $REPOSITORY/$JAR_NAME > $REPOSITORY/nohup.out 2>&1 &


