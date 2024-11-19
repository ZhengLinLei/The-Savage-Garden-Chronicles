#!/bin/bash

SQLITE=sqlite3
DB=./inventory.db

print() {
    >&2 echo -e "$@"
}

printOptions() {
    print "Options:"
    print "  1. Add new species"
    print "  2. Add new varieties"
    print "  3. Add new plants"
    print "  4. Add new inventory"
    print "  5. Get species from genre"
    print "  6. Get varieties from species"
    print "  7. Get all plants"
    print "  8. Get all inventory"
    print "  9. Get info from plant id"
    print "  10. Exit"
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
    id=$((echo "SELECT species_id FROM Species WHERE genre_name = '$genre' ORDER BY species_id DESC LIMIT 1;" | $SQLITE $DB) || echo 0)

    if [ -z $id ]; then
        id=1
    else
        id=$((id + 1))
    fi

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

# 2. Add new varieties
AddNewVarities() {
    read -p "Enter genre name: " genre
    read -p "Do you have species id? (true/false): " has_species_id

    if [ $has_species_id == "true" ]; then
        read -p "Enter species id: " species_id
    else
        # Get species_id from species name
        read -p "Enter species name: " species

        species_id=$((echo "SELECT species_id FROM Species WHERE species_name = '$species' AND genre_name = '$genre' ORDER BY species_id DESC LIMIT 1;" | $SQLITE $DB) || echo 0)
    fi

    # Get last variety_id from species
    id=$((echo "SELECT variety_id FROM Variety WHERE species_id = $species_id ORDER BY variety_id DESC LIMIT 1;" | $SQLITE $DB) || echo 0)

    if [ -z $id ]; then
        id=1
    else
        id=$((id + 1))
    fi

    read -p "Enter variety name: " variety

    read -r -d '' SQL <<- EOM
        INSERT INTO Variety (variety_id, genre_name, species_id, variety_name)
        VALUES ($id, '$genre', $species_id, '$variety');
EOM
    
    echo $SQL | $SQLITE $DB

    print "Genre: $genre"
    print "Species id: $species_id"
    print "Variety: $variety"
    print "Operation finished"
}

# 3. Add new plants
AddNewPlants() {
    read -p "Do you have species id? (true/false): " has_species_id
    if [ $has_species_id == "true" ]; then
        read -p "Enter species id: " species_id
    else
        # Get species_id from species name
        read -p "Enter species name: " species
        read -p "Enter genre name: " genre

        species_id=$((echo "SELECT species_id FROM Species WHERE species_name = '$species' AND genre_name = '$genre' ORDER BY species_id DESC LIMIT 1;" | $SQLITE $DB) || echo 0)
    fi

    read -p "Do you have variety id? (true/false): " has_variety_id
    if [ $has_variety_id == "true" ]; then
        read -p "Enter variety id: " variety_id
    else
        # Get variety_id from variety name
        read -p "Enter variety name: " variety

        variety_id=$((echo "SELECT variety_id FROM Variety WHERE variety_name = '$variety' AND genre_name = '$genre' AND species_id = $species_id ORDER BY variety_id DESC LIMIT 1;" | $SQLITE $DB) || echo 0)
    fi

    if [ -z $species_id ]; then
        print "Species not found"
        return
    fi

    if [ -z $variety_id ]; then
        print "Variety not found"
        return
    fi

    read -p "Enter plant name: " plant
    read -p "Enter plant description: " description

    # Create plant id
    # If {
    #   dionaea = V,
    #   drosera = D,
    #   nepenthes = N,
    #   sarracenia = S
    # }

    case $genre in
        dionaea)
            plant_id="V"
            ;;
        drosera)
            plant_id="D"
            ;;
        nepenthes)
            plant_id="N"
            ;;
        sarracenia)
            plant_id="S"
            ;;
    esac

    # Add species_id + "/" + variety_id
    plant_id="$plant_id$species_id/$variety_id"

    read -r -d '' SQL <<- EOM
        INSERT INTO Plant (plant_id, species_id, variety_id, plant_description, plant_name)
        VALUES ('$plant_id', $species_id, $variety_id, '$description', '$plant');
EOM

    echo $SQL | $SQLITE $DB

    print "Plant id: $plant_id"
    print "Species id: $species_id"
    print "Variety id: $variety_id"
    print "Plant name: $plant"
    print "Plant description: $description"
    print "Operation finished"
}

# 4. Add new inventory
AddNewInventory() {
    read -p "Enter plant id: " plant_id
    read -p "Enter size: " size
    read -p "Enter quantity: " quantity
    read -p "Enter price: " price
    read -p "Enter stock: " stock
    read -p "Enter for sale: " for_sale
    
    read -r -d '' SQL <<- EOM
        INSERT INTO Inventory (plant_id, size, quantity, price, stock, for_sale)
        VALUES ('$plant_id', '$size', $quantity, $price, $stock, $for_sale);
EOM

    echo $SQL | $SQLITE $DB
}

# 5. Get species from genre
GetSpeciesFromGenre() {
    read -p "Enter genre name: " genre
    echo "SELECT * FROM Species WHERE genre_name = '$genre';" | $SQLITE $DB
}

# 6. Get varieties from species
GetVarietiesFromSpecies() {
    read -p "Enter species name: " species
    read -p "Enter genre name: " genre
    echo "SELECT * FROM Variety WHERE species_id = (SELECT species_id FROM Species WHERE species_name = '$species' AND genre_name = '$genre');" | $SQLITE $DB
}

# 7. Get all plants
GetAllPlants() {
    echo "SELECT * FROM Plant;" | $SQLITE $DB
}

# 8. Get all inventory
GetAllInventory() {
    echo "SELECT * FROM Inventory;" | $SQLITE $DB
}

# 9. Get info from plant id
GetInfoFromPlantId() {
    read -p "Enter plant id: " plant_id

    read -r -d '' SQL << EOM
        SELECT p.plant_id, p.plant_name
        FROM plant p
        WHERE p.plant_id = '$plant_id'
        ;
EOM

    echo $SQL | $SQLITE $DB
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
            AddNewVarities
            ;;
        3)
            AddNewPlants
            ;;
        4)
            AddNewInventory
            ;;
        5)
            GetSpeciesFromGenre
            ;;
        6)
            GetVarietiesFromSpecies
            ;;
        7)
            GetAllPlants
            ;;
        8)
            GetAllInventory
            ;;
        9)
            GetInfoFromPlantId
            ;;
        10)
            exit 0
            ;;
        *)
            print "Invalid option"
            ;;
    esac
done