BEGIN;

CREATE TYPE tgl_dtypes_enum AS ENUM ( -- Here 'dtypes' is contraction for 'data types'.
    'tgl_i1',
    'tgl_i2',
    'tgl_i3',
    'tgl_i4',
    'tgl_i5',
    'tgl_i6',
    'tgl_i7',
    'tgl_i8',
    'tgl_i16',
    'tgl_i24',
    'tgl_i32',
    'tgl_i64',
    'tgl_u1',
    'tgl_u2',
    'tgl_u3',
    'tgl_u4',
    'tgl_u5',
    'tgl_u6',
    'tgl_u7',
    'tgl_u8',
    'tgl_u16',
    'tgl_u24',
    'tgl_u32',
    'tgl_u64',
    'tgl_bool',
    'tgl_blittable',
    'tgl_ch',
    'tgl_ne_str',
    'tgl_ipv4',
    'tgl_ipv6',

    -- nullable types
    'tgl_i1_or_null',
    'tgl_i2_or_null',
    'tgl_i3_or_null',
    'tgl_i4_or_null',
    'tgl_i5_or_null',
    'tgl_i6_or_null',
    'tgl_i7_or_null',
    'tgl_i8_or_null',
    'tgl_i16_or_null',
    'tgl_i24_or_null',
    'tgl_i32_or_null',
    'tgl_i64_or_null',
    'tgl_u1_or_null',
    'tgl_u2_or_null',
    'tgl_u3_or_null',
    'tgl_u4_or_null',
    'tgl_u5_or_null',
    'tgl_u6_or_null',
    'tgl_u7_or_null',
    'tgl_u8_or_null',
    'tgl_u16_or_null',
    'tgl_u24_or_null',
    'tgl_u32_or_null',
    'tgl_u64_or_null',
    'tgl_bool_or_null',
    'tgl_blittable_or_null',
    'tgl_ch_or_null',
    'tgl_ne_str_or_null',
    'tgl_ipv4_or_null',
    'tgl_ipv6_or_null'
);


CREATE DOMAIN tgl_bool_or_null AS
    bool;

CREATE DOMAIN tgl_blittable_or_null AS
    -- Blittable means one contiguous block of bytes.
    -- Non-blittable means many non-adjacent contiguous block of bytes.
    bool;

CREATE DOMAIN tgl_ch_or_null AS
    -- https://www.postgresql.org/docs/current/datatype-character.html
    --   In fact CHARACTER(n) is usually the slowest of the three because of its additional storage costs.
    --   In most situations TEXT or VARCHAR should be used instead.
    varchar(1) CHECK (char_length(value) > 0);

CREATE DOMAIN tgl_ne_str_or_null AS  -- '_ne_' means non-empty
    TEXT CHECK (char_length(value) > 0);


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

CREATE DOMAIN tgl_ipv4_or_null AS
    inet CHECK ( family(value) = 4);

CREATE DOMAIN tgl_ipv6_or_null AS
    inet CHECK ( family(value) = 6);

-- i<N> = [ -(2^(N-1)); +(2^(N-1)-1) ]
CREATE DOMAIN tgl_i1_or_null AS
    int CHECK (value >= -1 AND value <= 0);
CREATE DOMAIN tgl_i2_or_null AS
    int CHECK (value >= -2 AND value <= 1);
CREATE DOMAIN tgl_i3_or_null AS
    int CHECK (value >= -4 AND value <= 3);
CREATE DOMAIN tgl_i4_or_null AS
    int CHECK (value >= -8 AND value <= 7);
CREATE DOMAIN tgl_i5_or_null AS
    int CHECK (value >= -16 AND value <= 15);
CREATE DOMAIN tgl_i6_or_null AS
    int CHECK (value >= -32 AND value <= 31);
CREATE DOMAIN tgl_i7_or_null AS
    int CHECK (value >= -64 AND value <= 63);
CREATE DOMAIN tgl_i8_or_null AS
    int CHECK (value >= -128 AND value <= 127);

CREATE DOMAIN tgl_i16_or_null AS
    -- [ 32_768; +32_767 ]
    smallint; -- CHECK (value >= -32768 AND value <= 32767);

CREATE DOMAIN tgl_i24_or_null AS
    -- [ -8_388_608; +8_388_607 ]
    int CHECK (value >= -8388608 AND value <= 8388607);

CREATE DOMAIN tgl_i32_or_null AS
    -- [ -2_147_483_648; +2_147_483_647 ]
    int;  -- CHECK (value >= -2147483648 AND value <= 2147483647);

CREATE DOMAIN tgl_i64_or_null AS
    -- [ -9_223_372_036_854_775_808; +9_223_372_036_854_775_807 ]
    bigint; -- CHECK (value >= -9223372036854775808 AND value <= 9223372036854775807);

-- u<N> = [ 0; +((2^N)-1) ]
CREATE DOMAIN tgl_u1_or_null AS
    int CHECK (value >= 0 AND value <= 1);
CREATE DOMAIN tgl_u2_or_null AS
    int CHECK (value >= 0 AND value <= 3);
CREATE DOMAIN tgl_u3_or_null AS
    int CHECK (value >= 0 AND value <= 7);
CREATE DOMAIN tgl_u4_or_null AS
    int CHECK (value >= 0 AND value <= 15);
CREATE DOMAIN tgl_u5_or_null AS
    int CHECK (value >= 0 AND value <= 31);
CREATE DOMAIN tgl_u6_or_null AS
    int CHECK (value >= 0 AND value <= 63);
CREATE DOMAIN tgl_u7_or_null AS
    int CHECK (value >= 0 AND value <= 127);
CREATE DOMAIN tgl_u8_or_null AS
    int CHECK (value >= 0 AND value <= 255);

CREATE DOMAIN tgl_u16_or_null AS
    -- [0; +65_535]
    int CHECK (value >= 0 AND value <= 65535);

CREATE DOMAIN tgl_u24_or_null AS
    -- [0; +16_777_215]
    int CHECK (value >= 0 AND value <= 16777215);

CREATE DOMAIN tgl_u32_or_null AS
    -- [0; +4_294_967_295]
    bigint CHECK (value >= 0 AND value <= 4294967295);

CREATE DOMAIN tgl_u63_or_null AS
    -- [ 0; +9_223_372_036_854_775_807 ]
    bigint CHECK (value >= 0 AND value <= 9223372036854775807);

-- CREATE DOMAIN tgl_u64_or_null AS
--   -- Unimplemented in PGSQL
--   -- [ 0; +18_446_744_073_709_551_615 ]
--   -- select (9223372036854775808 * 2) - 1;
--   --        ?column?
--   -- ----------------------
--   --  18446744073709551615
--   -- (1 row)
--   int CHECK (value >= 0 AND value <= 18446744073709551615);

CREATE DOMAIN tgl_fk_id15_or_null AS
    -- [ 1; +32_767 ]
    tgl_id15;

CREATE DOMAIN tgl_fk_id31_or_null AS
    -- [ 1; +2_147_483_647 ]
    tgl_id31;

CREATE DOMAIN tgl_fk_id63_or_null AS
    -- [ 1; +9_223_372_036_854_775_807 ]
    tgl_id63;

CREATE DOMAIN tgl_direction_or_null AS
    tgl_directions_enum;


-- -- Create new TYPE or DOMAIN and suppres error if its exists.
-- DO $$ BEGIN
--  -- ...
-- EXCEPTION
--     WHEN duplicate_object THEN NULL;
-- END $$;

COMMIT;