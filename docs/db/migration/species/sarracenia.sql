-- Sarracenia purpurea
INSERT INTO Species (species_id, genre_name, species_name, is_hybrid, first_hybrid_id, second_hybrid_id)
VALUES (1, 'sarracenia', 'purpurea', false, NULL, NULL);

-- Sarracenia flava
INSERT INTO Species (species_id, genre_name, species_name, is_hybrid, first_hybrid_id, second_hybrid_id)
VALUES (2, 'sarracenia', 'flava', false, NULL, NULL);

-- Sarracenia catesbaei
INSERT INTO Species (species_id, genre_name, species_name, is_hybrid, first_hybrid_id, second_hybrid_id)
VALUES (3, 'sarracenia', 'catesbaei', true, 1, 2);

-- Sarracenia leucophylla
INSERT INTO Species (species_id, genre_name, species_name, is_hybrid, first_hybrid_id, second_hybrid_id)
VALUES (4, 'sarracenia', 'leucophylla', false, NULL, NULL);

-- Sarracenia stenvensii
INSERT INTO Species (species_id, genre_name, species_name, is_hybrid, first_hybrid_id, second_hybrid_id)
VALUES (5, 'sarracenia', 'stenvensii', false, 1, 4);

-- Sarracenia tygo
INSERT INTO Species (species_id, genre_name, species_name, is_hybrid, first_hybrid_id, second_hybrid_id)
VALUES (6, 'sarracenia', 'tygo', true, 2, NULL);

