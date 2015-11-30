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

CREATE VIEW live_neighbours AS
  SELECT simulation, generation, x+dx as xx, y+dy as yy, sum(weight) as cnt
  FROM life
  JOIN neighbour_coordinates
  GROUP BY simulation, generation, xx, yy
;

CREATE VIEW alive_next_generation AS
  SELECT simulation, generation+1 as generation, xx as x, yy as y FROM live_neighbours
  WHERE cnt BETWEEN 5 and 7;
