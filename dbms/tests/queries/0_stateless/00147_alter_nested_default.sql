DROP TABLE IF EXISTS test.alter;

CREATE TABLE test.alter (d Date DEFAULT toDate('2015-01-01'), n Nested(x String)) ENGINE = MergeTree(d, d, 8192);

INSERT INTO test.alter (`n.x`) VALUES (['Hello', 'World']);

SELECT * FROM test.alter;
SELECT * FROM test.alter ARRAY JOIN n;
SELECT * FROM test.alter ARRAY JOIN n WHERE n.x LIKE '%Hello%';

ALTER TABLE test.alter ADD COLUMN n.y Array(UInt64);

SELECT * FROM test.alter;
SELECT * FROM test.alter ARRAY JOIN n;
SELECT * FROM test.alter ARRAY JOIN n WHERE n.x LIKE '%Hello%';

INSERT INTO test.alter (`n.x`, `n.y`) VALUES (['Hello2', 'World2'], [123, 456]);

SELECT * FROM test.alter;
SELECT * FROM test.alter ARRAY JOIN n;
SELECT * FROM test.alter ARRAY JOIN n WHERE n.x LIKE '%Hello%';

OPTIMIZE TABLE test.alter;

SELECT * FROM test.alter;
SELECT * FROM test.alter ARRAY JOIN n;
SELECT * FROM test.alter ARRAY JOIN n WHERE n.x LIKE '%Hello%';

DROP TABLE test.alter;
