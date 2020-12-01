#!/bin/bash

rm -f score.res
rm -f output/*

score=0
qnum=5

javac BarcodeDatabase.java
java -classpath ".:sqlite-jdbc-3.32.3.2.jar" BarcodeDatabase

