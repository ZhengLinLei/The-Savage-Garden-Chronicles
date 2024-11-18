#!/bin/bash

# Apply all migrations
SQLITE=sqlite3
DB=../inventory.sqlite

SPECIES="dionaea drosera nepenthes sarracenia"

# Table creation
$SQLITE $DB < init.sql

# Species
for SPECIE in $SPECIES; do
    echo "Applying species/$SPECIE.sql"
    $SQLITE $DB < species/$SPECIE.sql
done

# Varieties
for SPECIE in $SPECIES; do
    echo "Applying varieties/$SPECIE.sql"
    $SQLITE $DB < varieties/$SPECIE.sql
done

# Plants
for SPECIE in $SPECIES; do
    echo "Applying plants/$SPECIE.sql"
    $SQLITE $DB < plants/$SPECIE.sql
done