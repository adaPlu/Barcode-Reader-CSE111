#!/bin/bash
sqlite3 data/inventory.sqlite < createTables.sql > output/1.out
sqlite3 data/inventory.sqlite < queries.sql > output/1.out



