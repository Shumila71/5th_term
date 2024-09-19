-- Вставка данных в таблицу Agent
INSERT INTO `mydb`.`Agent` (`name`, `phoneNumber`, `email`, `num_of_succs_deals`, `walrus`)
VALUES 
('Agent A', '123-456-7890', 'agenta@example.com', 5, 100),
('Agent B', '098-765-4321', 'agentb@example.com', 3, 150);

-- Вставка данных в таблицу Client
INSERT INTO `mydb`.`Client` (`name`, `phoneNumber`, `age`, `date_of_born`)
VALUES 
('Client A', '111-222-3333', 30, '1994-01-01 00:00:00'),
('Client B', '444-555-6666', 25, '1999-05-15 00:00:00');

-- Вставка данных в таблицу Object
INSERT INTO `mydb`.`Object` (`address`, `cost`, `area`)
VALUES 
('123 Street A', 200000, 100),
('456 Street B', 300000, 120),
('789 Street C', 250000, 110),
('101 Street D', 400000, 130),
('202 Street E', 350000, 140),
('303 Street F', 450000, 150),
('404 Street G', 500000, 160),
('505 Street H', 550000, 170),
('606 Street I', 600000, 180),
('707 Street J', 700000, 190);

-- Вставка данных в таблицу inspection
INSERT INTO `mydb`.`inspection` (`date`, `Agent_agent_id`, `Client_client_id`, `Object_object_id`)
VALUES 
('2024-09-18 10:00:00', 1, 1, 1),
('2024-09-19 14:30:00', 2, 2, 2);

-- Вставка данных в таблицу Deal
INSERT INTO `mydb`.`Deal` (`date`, `status`, `Object_object_id`, `Client_client_id`)
VALUES 
('2024-09-20 12:00:00', 'Pending', 1, 1),
('2024-09-21 13:00:00', 'Completed', 2, 2);

-- Вставка данных в таблицу Payment
INSERT INTO `mydb`.`Payment` (`date`, `status`, `total_cost`, `Deal_deal_id`)
VALUES 
('2024-09-22 12:00:00', 'Paid', 200000, 1),
('2024-09-23 15:00:00', 'Expected', 300000, 2);

-- Вставка данных в таблицу Contract
INSERT INTO `mydb`.`Contract` (`date_signed`, `conditions`, `Agent_agent_id`, `Deal_deal_id`)
VALUES 
('2024-09-23 15:00:00', 'Condition A', 1, 1),
('2023-07-13 12:30:00', 'Condition B', 2, 2);
