
CREATE TABLE IF NOT EXISTS product (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    description VARCHAR(255),
    price DOUBLE,
    in_stock BOOLEAN,
    stock_status VARCHAR(3),
    number_of_items INT
);

-- Add new columns if the table already exists
ALTER TABLE product ADD COLUMN IF NOT EXISTS in_stock BOOLEAN;
ALTER TABLE product ADD COLUMN IF NOT EXISTS stock_status VARCHAR(3);
ALTER TABLE product ADD COLUMN IF NOT EXISTS number_of_items INT;