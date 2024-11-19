#!/bin/bash

SQLITE=sqlite3
DB=./inventory.db

read -r -d '' SQL << EOM
SELECT s.plant_id, p.plant_name, s.size, s.quantity
FROM inventory s
JOIN plant p ON s.plant_id = p.plant_id
;
EOM

echo $SQL | $SQLITE $DB