#!/bin/bash

SQLITE=sqlite3
DB=./inventory.sqlite

read -r -d '' SQL << EOM
SELECT p.plant_id, s.genre_name, s.species_name, v.variety_name, p.plant_name
FROM plant p
JOIN species s ON p.species_id = s.species_id
JOIN variety v ON p.variety_id = v.variety_id
;
EOM

echo $SQL | $SQLITE $DB