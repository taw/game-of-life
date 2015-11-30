CREATE TABLE life(
  simulation string,
  generation int,
  x int,
  y int
);

CREATE TABLE neighbour_coordinates(
  dx int,
  dy int
);

INSERT INTO neighbour_coordinates VALUES (-1,-1), (-1,0), (-1,+1), (0,-1), (0,+1), (+1,-1), (+1,0), (+1, +1);

CREATE VIEW live_neighbours AS
  SELECT simulation, generation, x+dx as xx, y+dy as yy, count(*) as cnt FROM life JOIN neighbour_coordinates group by simulation, generation, xx, yy
;

CREATE VIEW current_status AS
  SELECT live_neighbours.simulation, live_neighbours.generation, live_neighbours.xx as x, live_neighbours.yy as y, live_neighbours.cnt, (life.simulation NOT NULL) as alive FROM live_neighbours LEFT OUTER JOIN life ON
     life.x = live_neighbours.xx AND
     life.y = live_neighbours.yy AND
     life.simulation = live_neighbours.simulation AND
     life.generation = live_neighbours.generation;

CREATE VIEW alive_next_generation AS
  SELECT simulation, generation+1 as generation, x, y FROM current_status
  WHERE (alive AND (cnt = 2 or cnt = 3)) or
        ((not alive) and (cnt = 3));

