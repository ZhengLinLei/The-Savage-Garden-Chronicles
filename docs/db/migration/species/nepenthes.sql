-- Nepenthes rafflesiana
INSERT INTO Species (species_id, genre_name, species_name, is_hybrid, first_hybrid_id, second_hybrid_id)
VALUES (1, 'nepenthes', 'rafflesiana', false, NULL, NULL);

-- Nepenthes alata
INSERT INTO Species (species_id, genre_name, species_name, is_hybrid, first_hybrid_id, second_hybrid_id)
VALUES (2, 'nepenthes', 'alata', false, NULL, NULL);

-- Nepenthes ampullaria
INSERT INTO Species (species_id, genre_name, species_name, is_hybrid, first_hybrid_id, second_hybrid_id)
VALUES (3, 'nepenthes', 'ampullaria', false, NULL, NULL);

-- Nepenthes hookeriana
INSERT INTO Species (species_id, genre_name, species_name, is_hybrid, first_hybrid_id, second_hybrid_id)
VALUES (4, 'nepenthes', 'hookeriana', true, 2, 3);

-- Nepenthes ventricosa
INSERT INTO Species (species_id, genre_name, species_name, is_hybrid, first_hybrid_id, second_hybrid_id)
VALUES (5, 'nepenthes', 'ventricosa', false, NULL, NULL);

-- Nepenthes northiana
INSERT INTO Species (species_id, genre_name, species_name, is_hybrid, first_hybrid_id, second_hybrid_id)
VALUES (6, 'nepenthes', 'northiana', false, NULL, NULL);

-- Nepenthes diana
INSERT INTO Species (species_id, genre_name, species_name, is_hybrid, first_hybrid_id, second_hybrid_id)
VALUES (7, 'nepenthes', 'diana', true, 5, 6);