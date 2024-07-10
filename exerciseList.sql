-- Create a database and table with the following data. The values in blank should 
-- be null.
  -- DATA
    -- 1, 1, 1, 25.00, 10, 5
    -- 1, 2, 2, 13.50, 3, 
    -- 1, 3, 3, 15.00, 2, 
    -- 1, 4, 4, 10.00, 1, 
    -- 1, 5, 5, 30.00, 1, 
    -- 2, 1, 3, 15.00, 4, 
    -- 2, 2, 4, 10.00, 5, 
    -- 2, 3, 5, 30.00, 7, 
    -- 3, 1, 1, 25.00, 5, 
    -- 3, 2, 4, 10.00, 4, 
    -- 3, 3, 5, 30.00, 5, 
    -- 3, 4, 2, 13.50, 7, 
    -- 4, 1, 5, 30.00, 10, 15
    -- 4, 2, 4, 10.00, 12, 5
    -- 4, 3, 1, 25.00, 13, 5
    -- 4, 4, 2, 13.50, 15, 5
    -- 5, 1, 3, 15.00, 3, 
    -- 5, 2, 5, 30.00, 6, 
    -- 6, 1, 1, 25.00, 22, 15
    -- 6, 2, 3, 15.00, 25, 20
    -- 7, 1, 1, 25.00, 10, 3
    -- 7, 2, 2, 13.50, 10, 4
    -- 7, 3, 3, 15.00, 10, 4
    -- 7, 4, 5, 30.00, 10, 

  CREATE DATABASE items_sold;
  USE items_sold;

  CREATE TABLE invoices (
    ID_NF INT, 
    ID_ITEM INT NOT NULL, 
    COD_PROD INT NOT NULL, 
    VALOR_UNIT DECIMAL(5, 2) NOT NULL, 
    QUANTIDADE INT NOT NULL, 
    PORC_DESC INT
  );

  INSERT INTO invoices (ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT, QUANTIDADE, PORC_DESC) 
    VALUES 
      (1, 1, 1, 25.00, 10, 5), 
      (1, 2, 2, 13.50, 3, NULL), 
      (1, 3, 3, 15.00, 2, NULL),
      (1, 4, 4, 10.00, 1, NULL),
      (1, 5, 5, 30.00, 1, NULL),
      (2, 1, 3, 15.00, 4, NULL),
      (2, 2, 4, 10.00, 5, NULL),
      (2, 3, 5, 30.00, 7, NULL),
      (3, 1, 1, 25.00, 5, NULL),
      (3, 2, 4, 10.00, 4, NULL),
      (3, 3, 5, 30.00, 5, NULL),
      (3, 4, 2, 13.50, 7, NULL),
      (4, 1, 5, 30.00, 10, 15),
      (4, 2, 4, 10.00, 12, 5),
      (4, 3, 1, 25.00, 13, 5),
      (4, 4, 2, 13.50, 15, 5),
      (5, 1, 3, 15.00, 3, NULL),
      (5, 2, 5, 30.00, 6, NULL),
      (6, 1, 1, 25.00, 22, 15),
      (6, 2, 3, 15.00, 25, 20),
      (7, 1, 1, 25.00, 10, 3),
      (7, 2, 2, 13.50, 10, 4),
      (7, 3, 3, 15.00, 10, 4),
      (7, 4, 5, 30.00, 10, 1)
  ;

  SELECT * FROM invoices;

  -- Search for items that were sold without a discount. The columns present in the 
  -- query results are: ID_NF, ID_ITEM, COD_PROD & VALOR_UNIT.

  SELECT ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT FROM invoices WHERE PORC_DESC IS NULL;

  -- Search for items that were sold at a discount. The columns present in the query 
  -- results are ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT & VALOR_VENDIDO. PS: VALOR_VENDIDO
  -- is equal to VALOR_UNIT - (VALOR_UNIT * (PORC_DESC / 100)).

  SELECT 
    ID_NF, 
    ID_ITEM, 
    COD_PROD, 
    VALOR_UNIT, 
    VALOR_UNIT - (VALOR_UNIT * (PORC_DESC / 100)) AS VALOR_VENDIDO 
    FROM invoices 
    WHERE PORC_DESC >= 1
  ;

  -- Alter the value of the discount (to zero) of every field where this field is null.

  UPDATE invoices SET PORC_DESC = 0 WHERE PORC_DESC IS NULL;

  -- Search the items that were sold. The columns present in the query results are:
  -- ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT, VALOR_TOTAL, PORC_DESC, VALOR_VENDIDO.
  -- PS: VALOR_TOTAL is obtained by the formula QUANTIDADE * VALOR_UNIT. The VALOR_VENDIDO
  -- is equal to VALOR_UNIT - (VALOR_UNIT * (PORC_DESC / 100)).

  SELECT  ID_NF,
  ID_ITEM,
  COD_PROD,
  VALOR_UNIT,
  QUANTIDADE * VALOR_UNIT AS VALOR_TOTAL,
  PORC_DESC, 
  VALOR_UNIT - (VALOR_UNIT * (PORC_DESC / 100)) AS VALOR_VENDIDO 
  FROM invoices
  ;

  -- Search for the total value of the invoices and order the result from highest value to
  -- lowest. The columns present in the query result are: NF_ID, VALOR_TOTAL. NOTE: THE
  -- VALOR_TOTAL is obtained by the formula: ∑ QUANTIDADE * VALOR_UNIT. Group the query
  -- result by ID_NF.

  SELECT 
    ID_NF,  
    SUM(QUANTIDADE * VALOR_UNIT) AS VALOR_TOTAL 
  FROM invoices 
  GROUP BY ID_NF 
  ORDER BY VALOR_TOTAL DESC
  ;

  -- Search the sold value of the invoice and order the result from highest value to lowest.
  -- The columns present in the query result are: ID_NF, VALOR_VENDIDO. NOTE: The 
  -- VALOR_TOTAL is obtained by the formula: ∑ QUANTIDADE * VALOR_UNITARIO. O VALOR_VENDIDO
  -- is equal to ∑ VALOR_UNIT - (VALOR_UNIT*(DISCOUNT/100)). Group the result of the query
  -- by ID_NF.

  SELECT 
    ID_NF, 
    SUM(VALOR_UNIT - (VALOR_UNIT * (PORC_DESC / 100))) AS VALOR_VENDIDO, 
    SUM(QUANTIDADE * VALOR_UNIT) AS VALOR_TOTAL 
  FROM invoices 
  GROUP BY ID_NF 
  ;

  -- Get the product that sold the most overall. The columns present in the result of the
  -- query are: COD_PROD, QUANTITY. Group the query result by COD_PROD.

  SELECT 
    COD_PROD, 
    SUM(QUANTIDADE) AS QUANT_VEND 
  FROM invoices 
  GROUP BY COD_PROD 
  ORDER BY QUANT_VEND DESC 
  LIMIT 1
  ;

  -- Get the invoices where more than 10 units of at least one product were sold. 
  -- The columns present in the query result are: ID_NF, COD_PROD, QUANTIDADE.
  -- Group the query result by ID_NF, COD_PROD.

  SELECT 
    ID_NF, 
    COD_PROD, 
    QUANTIDADE 
  FROM invoices 
  WHERE QUANTIDADE > 10 
  GROUP BY ID_NF, COD_PROD
  ;

  SELECT 
    ID_NF, 
    COD_PROD, 
    QUANTIDADE 
  FROM invoices 
  WHERE QUANTIDADE > 10
  ;

  -- Search for the total value of the invoices, where this value is greater than 500, and
  -- sort the result from the highest value to the lowest. The columns present in the query
  -- result are: ID_NF, VALOR_TOTAL. NOTE: THE VALOR_TOTAL is obtained by the formula: 
  -- ∑ QUANTIDADE * VALOR_TOTAL. Group the query result by ID_NF.

  SELECT 
    ID_NF, 
    SUM(QUANTIDADE * VALOR_UNIT) AS VALOR_TOTAL 
  FROM invoices 
  GROUP BY ID_NF
  HAVING VALOR_TOTAL > 500
  ORDER BY VALOR_TOTAL DESC
  ;

  -- What is the average value of discounts given per product. The columns present in the
  -- query results are: COD_PROD, MEDIA. Group the query result by COD_PROD.

  SELECT COD_PROD, AVG(PORC_DESC) AS MEDIA FROM invoices GROUP BY COD_PROD;

  -- What is the lowest, highest and average value of discounts given per product. The
  -- columns present in the query result are: COD_PROD, SMALLEST, MAJOR, AVERAGE. Group the -- result of the query by COD_PROD.

  SELECT  
    COD_PROD, 
    MIN(PORC_DESC) AS MENOR, 
    MAX(PORC_DESC) AS MAIOR, 
    AVG(PORC_DESC) AS MEDIA 
  FROM invoices 
  GROUP BY COD_PROD
  ;

  -- Which NFs have more than 3 items sold. The columns present in the result of the
  -- query are: ID_NF, QTD_ITENS. NOTE: this isn't related to the quantity of itens sold -- but to the quantity of itens per invoice. Group the query result by ID_NF.

  SELECT 
    ID_NF, 
    COUNT(QUANTIDADE) AS QTD_ITENS 
  FROM invoices 
  GROUP BY ID_NF 
  HAVING QTD_ITENS > 3
  ;

-- Create a database named Universidade with the following tables:
  -- alunos (MAT, nome, endereco, cidade)
  -- disciplinas (COD_DISC, nome_disc, carga_hor)
  -- professores (COD_PROF, nome, endereco, cidade)
  -- turma (COD_DISC, COD_TURMA, COD_PROF, ANO, horario)
  -- COD_DISC references disciplinas
  -- COD_PROF references professores
  -- historico (MAT, COD_DISC, COD_TURMA, COD_PROF, ANO, frequencia, nota)
  -- MAT references alunos
  -- COD_DISC, COD_TURMA, COD_PROF, ANO references turma

  -- DATA
    INSERT INTO alunos (MAT, nome, endereco, cidade) VALUES 
      (2015010101, 'JOSE DE ALENCAR', 'RUA DAS ALMAS', 'NATAL'),
      (2015010102, 'JOÃO JOSÉ', 'AVENIDA RUY CARNEIRO', 'JOÃO PESSOA'),
      (2015010103, 'MARIA JOAQUINA', 'RUA CARROSSEL', 'RECIFE'),
      (2015010104, 'MARIA DAS DORES', 'RUA DAS LADEIRAS', 'FORTALEZA'),
      (2015010105, 'JOSUÉ CLAUDINO DOS SANTOS', 'CENTRO', 'NATAL'),
      (2015010106, 'JOSUÉLISSON CLAUDINO DOS SANTOS', 'CENTRO', 'NATAL');

    INSERT INTO disciplinas (COD_DISC, nome_disc, carga_hor) VALUES
      ('BD', 'BANCO DE DADOS', 100),
      ('POO', 'PROGRAMAÇÃO COM ACESSO A BANCO DE DADOS', 100),
      ('WEB', 'AUTORIA WEB', 50),
      ('ENG', 'ENGENHARIA DE SOFTWARE', 80);

    INSERT INTO professores (COD_PROF, nome, endereco, cidade) VALUES
      (212131, 'NICKERSON FERREIRA', 'RUA MANAÍRA', 'JOÃO PESSOA'),
      (122135, 'ADORILSON BEZERRA', 'AVENIDA SALGADO FILHO', 'NATAL'),
      (192011, 'DIEGO OLIVEIRA', 'AVENIDA ROBERTO FREIRE', 'NATAL');
    
    INSERT INTO turma (COD_DISC, COD_TURMA, COD_PROF, ANO, horario) VALUES
      ('BD', 1, 212131, 2015, '11H-12H'),
      ('BD', 2, 212131, 2015, '13H-14H'),
      ('POO', 1, 192011, 2015, '08H-09H'),
      ('WEB', 1, 192011, 2015, '07H-08H'),
      ('ENG', 1, 122135, 2015, '10H-11H');

    INSERT INTO historico (MAT, COD_DISC, COD_TURMA, COD_PROF, ANO, frequencia, nota)
    VALUES 
      (2015010101, 'BD', 1, 212131, 2015, 90.5, 8.5),
      (2015010102, 'BD', 1, 212131, 2015, 85.0, 7.8),
      (2015010103, 'POO', 1, 192011, 2015, 92.0, 9.3),
      (2015010101, 'BD', 2, 212131, 2015, 88.0, 8.0),
      (2015010104, 'ENG', 1, 122135, 2015, 87.5, 8.7),
      (2015010105, 'WEB', 1, 192011, 2015, 90.0, 8.9),
      (2015010102, 'POO', 1, 192011, 2015, 86.5, 7.5),
      (2015010103, 'POO', 1, 192011, 2015, 91.0, 9.1),
      (2015010101, 'WEB', 1, 192011, 2015, 83.0, 7.9),
      (2015010104, 'BD', 2, 212131, 2015, 86.0, 8.2);

  CREATE DATABASE Universidade;
  
  USE Universidade;

  CREATE TABLE alunos (
    MAT INT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    cidade VARCHAR(255) NOT NULL
  );

  CREATE TABLE disciplinas (
    COD_DISC VARCHAR(10) PRIMARY KEY,
    nome_disc VARCHAR(255) NOT NULL,
    carga_hor INT NOT NULL
  );

  CREATE TABLE professores (
    COD_PROF INT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    cidade VARCHAR(255) NOT NULL
  );

  CREATE TABLE turma (
    COD_DISC VARCHAR(10),
    COD_TURMA INT,
    COD_PROF INT,
    ANO INT,
    horario VARCHAR(255) NOT NULL,
    PRIMARY KEY (COD_DISC, COD_TURMA, COD_PROF, ANO),
    FOREIGN KEY (COD_DISC) REFERENCES disciplinas(COD_DISC),
    FOREIGN KEY (COD_PROF) REFERENCES professores(COD_PROF)
  );

  CREATE TABLE historico (
   MAT INT NOT NULL, 
   COD_DISC VARCHAR(10),
   COD_TURMA INT,
   COD_PROF INT,
   ANO INT NOT NULL,
   frequencia DECIMAL(5,2) NOT NULL,
   nota DECIMAL(5,2) NOT NULL,
   FOREIGN KEY (MAT) REFERENCES alunos(MAT),
   FOREIGN KEY (
    COD_DISC, 
    COD_TURMA, 
    COD_PROF, 
    ANO
   ) REFERENCES turma(COD_DISC, COD_TURMA, COD_PROF, ANO)
  );

  -- Get the MAT of alunos with BD in 2015 less than 5. PS: BD = COD_DISC.
  
  SELECT MAT FROM historico WHERE COD_DISC = 'BD' AND ANO = 2015 AND nota < 5;

  -- Get the MAT and calculate the average student grade in the POO subject in 2015.

  SELECT 
    MAT, 
    AVG(nota) AS media 
  FROM historico 
  WHERE COD_DISC = 'POO' 
    AND ano = 2015 
  GROUP BY MAT;

  -- Find the MAT and calculate the average of students' grades in the POO subject
  -- in 2015 that are above 6.
  
  SELECT 
    MAT, 
    AVG(nota) AS media 
  FROM historico 
  WHERE COD_DISC = 'POO' 
    AND ano = 2015 
    HAVING AVG(nota) > 6
  ;

  -- Find out how many students aren't from Natal.
  SELECT COUNT(*) AS Result FROM alunos WHERE cidade != 'NATAL';
