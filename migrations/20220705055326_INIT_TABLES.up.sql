BEGIN;

CREATE TABLE IF NOT EXISTS tgl_nodes (
    -- Columns --
    id BIGSERIAL,
    content tgl_ne_str,

    -- Constraints --
    PRIMARY KEY (id),
    UNIQUE(content)
);

CREATE TABLE IF NOT EXISTS tgl_edges (
    -- Columns --
    id BIGSERIAL,
    lid tgl_fk_id63,
    rid tgl_fk_id63,
    direction tgl_direction,

    -- Constraints --
    PRIMARY KEY (id),
    UNIQUE(lid, rid, direction)
);

CREATE TABLE IF NOT EXISTS tgl_labels (
    -- Columns --
    id BIGSERIAL,
    label tgl_ne_str,

    -- Constraints --
    PRIMARY KEY (id),
    UNIQUE(label)
);

CREATE TABLE IF NOT EXISTS tgl_walks ( 
    -- Traversing a graph forms a walk. A walk is a sequence of adjacent edges.
    -- Vertices and edges in a walk can be repeated.

    -- Columns --
    id BIGSERIAL,

    -- Constraints --
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS tgl_w2e ( -- 'w2e' means 'walks to edges'
    -- Columns --
    id BIGSERIAL,
    walk_id tgl_fk_id63,
    edge_id tgl_fk_id63,

    -- Constraints --
    PRIMARY KEY (id),
    FOREIGN KEY (walk_id) REFERENCES tgl_walks (id),
    FOREIGN KEY (edge_id) REFERENCES tgl_edges (id)
);

CREATE TABLE IF NOT EXISTS tgl_l2n ( -- 'l2n' means 'labels to nodes'
    -- Columns --
    id BIGSERIAL,
    label_id tgl_fk_id63,
    node_id tgl_fk_id63,

    -- Constraints --
    PRIMARY KEY (id),
    FOREIGN KEY (label_id) REFERENCES tgl_labels (id),
    FOREIGN KEY (node_id) REFERENCES tgl_nodes (id),
    UNIQUE(label_id, node_id)
);

CREATE TABLE IF NOT EXISTS tgl_l2w ( -- 'l2w' means 'labels to walks'
    -- Columns --
    id BIGSERIAL,
    label_id tgl_fk_id63,
    walk_id tgl_fk_id63,

    -- Constraints --
    PRIMARY KEY (id),
    FOREIGN KEY (label_id) REFERENCES tgl_labels (id),
    FOREIGN KEY (walk_id) REFERENCES tgl_walks (id),
    UNIQUE(label_id, walk_id)
);

COMMIT;