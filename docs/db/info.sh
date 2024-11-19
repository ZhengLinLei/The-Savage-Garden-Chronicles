#!/bin/bash
SQLITE=sqlite3
DB=./inventory.db

GetInfoFromPlantId() {
    read -p "" plant_id

    read -r -d '' SQL << EOM
        SELECT p.plant_id, p.plant_name
        FROM plant p
        WHERE p.plant_id = '$plant_id'
        ;
EOM

    echo $SQL | $SQLITE $DB
}


while true; do
    GetInfoFromPlantId
done