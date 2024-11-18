-- Drosera capensis
INSERT INTO Species (species_id, genre_name, species_name, is_hybrid, first_hybrid_id, second_hybrid_id) 
VALUES (1, 'drosera', 'capensis', false, NULL, NULL);

-- Drosera natalensis
INSERT INTO Species (species_id, genre_name, species_name, is_hybrid, first_hybrid_id, second_hybrid_id)
VALUES (2, 'drosera', 'natalensis', false, NULL, NULL);

-- Drosera dielsina
INSERT INTO Species (species_id, genre_name, species_name, is_hybrid, first_hybrid_id, second_hybrid_id)
VALUES (3, 'drosera', 'dielsina', false, NULL, NULL);

-- Drosera aliciae
INSERT INTO Species (species_id, genre_name, species_name, is_hybrid, first_hybrid_id, second_hybrid_id)
VALUES (4, 'drosera', 'aliciae', true, 2, 3);