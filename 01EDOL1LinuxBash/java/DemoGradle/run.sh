#!/bin/bash
gradle init

buildRes=$?

if [ $buildRes -eq 0 ]; then
  echo "Build successful: $buildRes"
  ./gradlew run  
else
  echo "Build with errors: $buildRes"
fi
