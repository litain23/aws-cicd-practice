#!/bin/bash

REPOSITORY=/home/ubuntu/simple-deploy
PROJECT_NAME=aws-cicd-practice

cd $REPOSITORY/$PROJECT_NAME

echo "> GIT PULL"

git pull

echo "> Start Project Build"

cd simpleservice

sudo ./gradlew build

cd $REPOSITORY/$PROJECT_NAME

rm *.jar

cp $REPOSITORY/$PROJECT_NAME/simpleservice/build/libs/*.jar $REPOSITORY

echo "> Kill current running application"

CURRENT_PID=$(pgrep -f simpleservice*.jar)

if [ -z "$CURRENT_PID" ]; then
    echo "> Not found pid"
else
    echo "> Kill running app"
    kill $CURRENT_PID
    sleep 5
fi

echo "> Publish new application"

JAR_NAME=$(ls -tr $REPOSITORY | grep *.jar | tail -n 1)

echo "> JAR NAME : $JAR_NAME"

nohup java -jar $REPOSITORY/$JAR_NAME 2>&1 &


