#!/bin/bash

SQLITE=sqlite3
DB=./inventory.sqlite

print() {
    >&2 echo -e "$@"
}

printOptions() {
    print "Options:"
    print "  1. Add new species"
    print "  2. Add new varieties"
    print "  3. Add new plants"
    print "  4. Get species from genre"
    print "  5. Get varieties from species"
    print "  6. Get all plants"
    print "  7. Get all inventory"
    print "  8. Exit"
}


# Functions

# 1. Add new species
AddNewSpecies() {
    read -p "Enter genre name: " genre
    read -p "Enter species name: " species
    read -p "Is hybrid? (true/false): " is_hybrid
    if [ $is_hybrid == "true" ]; then
        read -p "Enter first hybrid id: " first_hybrid_id
        read -p "Enter second hybrid id: " second_hybrid_id
    else
        first_hybrid_id=NULL
        second_hybrid_id=NULL
        is_hybrid=false
    fi

    # Get last species_id from genre
    id=$(echo "SELECT species_id FROM Species WHERE genre_name = '$genre' ORDER BY species_id DESC LIMIT 1;" | $SQLITE $DB)

    read -r -d '' SQL <<- EOM
        INSERT INTO Species (species_id, genre_name, species_name, is_hybrid, first_hybrid_id, second_hybrid_id) 
        VALUES ($id, '$genre', '$species', $is_hybrid, ${first_hybrid_id:-NULL}, ${second_hybrid_id:-NULL});
EOM
    
    echo $SQL | $SQLITE $DB

    print "Genre: $genre"
    print "Species: $species"
    print "Is hybrid: $is_hybrid"
    print "First hybrid id: $first_hybrid_id"
    print "Second hybrid id: $second_hybrid_id"
    print "Operation finished"
    print "\n\n"
}

# Loop main
while true; do
    printOptions
    read -p "Select an option: " option
    case $option in
        1)
            AddNewSpecies
            ;;
        2)
            read -p "Enter species name: " species
            read -p "Enter variety name: " variety
            $SQLITE $DB < varieties/add.sql
            ;;
        3)
            read -p "Enter species name: " species
            read -p "Enter variety name: " variety
            read -p "Enter plant name: " plant
            $SQLITE $DB < plants/add.sql
            ;;
        4)
            read -p "Enter genre name: " genre
            $SQLITE $DB < species/get.sql
            ;;
        5)
            read -p "Enter species name: " species
            $SQLITE $DB < varieties/get.sql
            ;;
        6)
            $SQLITE $DB < plants/get.sql
            ;;
        7)
            $SQLITE $DB < inventory/get.sql
            ;;
        8)
            break
            ;;
        *)
            print "Invalid option"
            ;;
    esac
done