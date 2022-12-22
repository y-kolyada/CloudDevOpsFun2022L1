#!/bin/bash
mvn clean install

buildRes=$?

if [ $buildRes -eq 0 ]; then
  echo "Build successful: $buildRes"
  java -cp ./target/demo-0.0.1.jar com.ygorod.App
else
  echo "Build with errors: $buildRes"
fi
