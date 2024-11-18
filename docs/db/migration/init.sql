
-- Species table
CREATE TABLE IF NOT EXISTS Species (
    species_id                 int          NOT NULL,
    genre_name         varchar(255) NOT NULL,
    species_name       varchar(255) NOT NULL,
    is_hybrid          boolean      NOT NULL,
    -- Optional fields, if hybrid is true
    first_hybrid_id    int,
    second_hybrid_id   int,

    -- Primary keys (id, genre, species)
    PRIMARY KEY (species_id, genre_name, species_name)
);


-- Variety table
CREATE TABLE IF NOT EXISTS Variety (
    variety_id      int          NOT NULL,
    genre_name      varchar(255) NOT NULL,
    species_id      int          NOT NULL,
    -- Optional fields, if variety is a hybrid
    variety_name    varchar(255) NOT NULL,

    -- Primary keys (id, genre, species, variety)
    PRIMARY KEY (variety_id, genre_name, species_id),
    -- Foreign key to Species table
    FOREIGN KEY (genre_name, species_id) REFERENCES Species(genre_name, species_id)
);


-- Plant table
CREATE TABLE IF NOT EXISTS Plant (
    plant_id        varchar(255) NOT NULL,
    species_id      int          NOT NULL,
    variety_id      int          NOT NULL,

    plant_description       text,
    plant_name              varchar(255),

    -- Primary keys (id, variety)
    PRIMARY KEY (plant_id, variety_id, species_id),
    -- Foreign key to Variety table and Species table
    FOREIGN KEY (variety_id) REFERENCES Variety(variety_id),
    FOREIGN KEY (species_id) REFERENCES Species(species_id)
);

-- Inventory table
CREATE TABLE IF NOT EXISTS Inventory (
    plant_id    int           NOT NULL,
    size        varchar(2)    NOT NULL,
    quantity    int           NOT NULL,
    price       decimal(10,2) NOT NULL,
    stock       boolean       NOT NULL,
    for_sale    int           NOT NULL,

    -- Primary keys (id, plant_id)
    PRIMARY KEY (size, plant_id),
    -- Foreign key to Plant table
    FOREIGN KEY (plant_id) REFERENCES Plant(plant_id)
);