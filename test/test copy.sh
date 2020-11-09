#!/bin/bash


sqlite3 data/tpch.sqlite < db.sql > output/$i.out
	
javac BarcodeDatabase.java
java -classpath ".:sqlite-jdbc-3.32.3.2.jar" BarcodeDatabase





