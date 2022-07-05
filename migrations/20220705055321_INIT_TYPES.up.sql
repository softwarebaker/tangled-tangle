BEGIN;

CREATE TYPE dtypes_enum AS ENUM ( -- Here 'dtypes' is contraction for 'data types'.
    'i1',
    'i2',
    'i3',
    'i4',
    'i5',
    'i6',
    'i7',
    'i8',
    'i16',
    'i24',
    'i32',
    'i64',
    'u1',
    'u2',
    'u3',
    'u4',
    'u5',
    'u6',
    'u7',
    'u8',
    'u16',
    'u24',
    'u32',
    'u64',
    'bool',
    'blittable',
    'ch',
    'str',
    'ipv4',
    'ipv6'
);

CREATE DOMAIN bool_t AS
    bool NOT NULL;

CREATE DOMAIN blittable AS
    -- Blittable means one contiguous block of bytes.
    -- Non-blittable means many non-adjacent contiguous block of bytes.
    bool NOT NULL;

CREATE DOMAIN ch AS
    -- https://www.postgresql.org/docs/current/datatype-character.html
    --   In fact CHARACTER(n) is usually the slowest of the three because of its additional storage costs.
    --   In most situations TEXT or VARCHAR should be used instead.
    varchar(1) NOT NULL CHECK (char_length(value) > 0);

CREATE DOMAIN str AS
    TEXT NOT NULL CHECK (char_length(value) > 0);


-- inet
--   The inet type holds an IPv4 or IPv6 host address, and optionally its subnet, all in one field.
--   The input format for this type is address/y where address is an IPv4 or IPv6 address and y is the number of bits in the netmask.
--   If the /y portion is omitted, the netmask is taken to be 32 for IPv4 or 128 for IPv6, so the value represents just a single host.
--   On display, the /y portion is suppressed if the netmask specifies a single host.
-- cidr
--   The cidr type holds an IPv4 or IPv6 network specification.
--   The format for specifying networks is address/y where address is the network's lowest address represented as an IPv4 or IPv6 address,
--   and y is the number of bits in the netmask.
--   If y is omitted, it is calculated using assumptions from the older classful network numbering system, except it will be at least
--   large enough to include all of the octets written in the input.

CREATE DOMAIN ipv4 AS
    inet NOT NULL CHECK ( family(value) = 4);

CREATE DOMAIN ipv6 AS
    inet NOT NULL CHECK ( family(value) = 6);

-- i<N> = [ -(2^(N-1)); +(2^(N-1)-1) ]
CREATE DOMAIN i1 AS
    int NOT NULL CHECK (value >= -1 AND value <= 0);
CREATE DOMAIN i2 AS
    int NOT NULL CHECK (value >= -2 AND value <= 1);
CREATE DOMAIN i3 AS
    int NOT NULL CHECK (value >= -4 AND value <= 3);
CREATE DOMAIN i4 AS
    int NOT NULL CHECK (value >= -8 AND value <= 7);
CREATE DOMAIN i5 AS
    int NOT NULL CHECK (value >= -16 AND value <= 15);
CREATE DOMAIN i6 AS
    int NOT NULL CHECK (value >= -32 AND value <= 31);
CREATE DOMAIN i7 AS
    int NOT NULL CHECK (value >= -64 AND value <= 63);
CREATE DOMAIN i8 AS
    int NOT NULL CHECK (value >= -128 AND value <= 127);

CREATE DOMAIN i16 AS
    -- [ 32_768; +32_767 ]
    smallint NOT NULL; -- CHECK (value >= -32768 AND value <= 32767);

CREATE DOMAIN i24 AS
    -- [ -8_388_608; +8_388_607 ]
    int NOT NULL CHECK (value >= -8388608 AND value <= 8388607);

CREATE DOMAIN i32 AS
    -- [ -2_147_483_648; +2_147_483_647 ]
    int NOT NULL;  -- CHECK (value >= -2147483648 AND value <= 2147483647);

CREATE DOMAIN i64 AS
    -- [ -9_223_372_036_854_775_808; +9_223_372_036_854_775_807 ]
    bigint NOT NULL; -- CHECK (value >= -9223372036854775808 AND value <= 9223372036854775807);

-- u<N> = [ 0; +((2^N)-1) ]
CREATE DOMAIN u1 AS
    int NOT NULL CHECK (value >= 0 AND value <= 1);
CREATE DOMAIN u2 AS
    int NOT NULL CHECK (value >= 0 AND value <= 3);
CREATE DOMAIN u3 AS
    int NOT NULL CHECK (value >= 0 AND value <= 7);
CREATE DOMAIN u4 AS
    int NOT NULL CHECK (value >= 0 AND value <= 15);
CREATE DOMAIN u5 AS
    int NOT NULL CHECK (value >= 0 AND value <= 31);
CREATE DOMAIN u6 AS
    int NOT NULL CHECK (value >= 0 AND value <= 63);
CREATE DOMAIN u7 AS
    int NOT NULL CHECK (value >= 0 AND value <= 127);
CREATE DOMAIN u8 AS
    int NOT NULL CHECK (value >= 0 AND value <= 255);

CREATE DOMAIN u16 AS
    -- [0; +65_535]
    int NOT NULL CHECK (value >= 0 AND value <= 65535);

CREATE DOMAIN u24 AS
    -- [0; +16_777_215]
    int NOT NULL CHECK (value >= 0 AND value <= 16777215);

CREATE DOMAIN u32 AS
    -- [0; +4_294_967_295]
    bigint NOT NULL CHECK (value >= 0 AND value <= 4294967295);

CREATE DOMAIN u63 AS
    -- [ 0; +9_223_372_036_854_775_807 ]
    bigint NOT NULL CHECK (value >= 0 AND value <= 9223372036854775807);

-- CREATE DOMAIN u64 AS
--   -- Unimplemented in PGSQL
--   -- [ 0; +18_446_744_073_709_551_615 ]
--   -- select (9223372036854775808 * 2) - 1;
--   --        ?column?
--   -- ----------------------
--   --  18446744073709551615
--   -- (1 row)
--   int NOT NULL CHECK (value >= 0 AND value <= 18446744073709551615);

CREATE DOMAIN id15 AS
    -- [ 1; +2_147_483_647 ]
    smallint NOT NULL CHECK (value >= 1 AND value <= 32767);  -- It is not possible to refer to 'smallserial' here

CREATE DOMAIN id31 AS
    -- [ 1; +2_147_483_647 ]
    int NOT NULL CHECK (value >= 1 AND value <= 2147483647);  -- It is not possible to refer to 'serial' here

CREATE DOMAIN id63 AS
    -- [ 1; +9_223_372_036_854_775_807 ]
    bigint NOT NULL CHECK (value >= 1 AND value <= 9223372036854775807);  -- It is not possible to refer to 'bigserial' here

CREATE DOMAIN fk_id15 AS
    -- [ 1; +32_767 ]
    id15 NOT NULL;

CREATE DOMAIN fk_id31 AS
    -- [ 1; +2_147_483_647 ]
    id31 NOT NULL;

CREATE DOMAIN fk_id63 AS
    -- [ 1; +9_223_372_036_854_775_807 ]
    id63 NOT NULL;


CREATE TYPE directions_enum AS ENUM (
    'bi',
    'l2r',
    'r2l',
    'no'
);

CREATE DOMAIN direction AS
    directions_enum NOT NULL;


-- -- Create new TYPE or DOMAIN and suppres error if its exists.
-- DO $$ BEGIN
--  -- ...
-- EXCEPTION
--     WHEN duplicate_object THEN NULL;
-- END $$;

COMMIT;