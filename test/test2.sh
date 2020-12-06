#!/bin/bash
javac BarcodeDatabase.java
java -classpath ".:sqlite-jdbc-3.32.3.2.jar" BarcodeDatabase


sqlite3 data/inventory.sqlite < queries.sql > output/1.out
