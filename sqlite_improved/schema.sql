CREATE TABLE life(
  simulation string,
  generation int,
  x int,
  y int
);

CREATE TABLE neighbour_coordinates(
  dx int,
  dy int,
  weight int
);

INSERT INTO neighbour_coordinates VALUES
  (-1,-1, 2),
  (-1, 0, 2),
  (-1,+1, 2),
  ( 0,-1, 2),
  ( 0, 0, 1),
  ( 0,+1, 2),
  (+1,-1, 2),
  (+1, 0, 2),
  (+1,+1, 2);

CREATE VIEW alive_next_generation AS
  SELECT
    simulation,
    generation+1 AS generation,
    x+dx as x,
    y+dy as y
  FROM life
  JOIN neighbour_coordinates
  GROUP BY simulation, generation, life.x+dx, life.y+dy
  HAVING SUM(weight) BETWEEN 5 and 7
;
