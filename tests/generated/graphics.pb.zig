// Code generated by protoc-gen-zig
///! package graphics
const std = @import("std");
const Allocator = std.mem.Allocator;
const ArrayListU = std.ArrayListUnmanaged;

const protobuf = @import("protobuf");
const ManagedString = protobuf.ManagedString;
const fd = protobuf.fd;

test {
    std.testing.refAllDeclsRecursive(@This());
}

pub const InventoryItem = struct {
    slot: i32 = 0,
    name: ManagedString = .Empty,
    image: i32 = 0,
    quantity: i32 = 0,
    description: ManagedString = .Empty,
    id: i32 = 0,

    pub const _desc_table = .{
        .slot = fd(1, .{ .Varint = .Simple }),
        .name = fd(2, .String),
        .image = fd(3, .{ .Varint = .Simple }),
        .quantity = fd(4, .{ .Varint = .Simple }),
        .description = fd(5, .String),
        .id = fd(6, .{ .Varint = .Simple }),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const Character = struct {
    id: ManagedString = .Empty,
    class: i32 = 0,
    gender: i32 = 0,
    race: i32 = 0,
    head: i32 = 0,
    body: i32 = 0,
    helmet: i32 = 0,
    right_hand: i32 = 0,
    nick: ManagedString = .Empty,
    left_hand: i32 = 0,
    color: ManagedString = .Empty,
    clan: ManagedString = .Empty,
    enabled: bool = false,

    pub const _desc_table = .{
        .id = fd(1, .String),
        .class = fd(2, .{ .Varint = .Simple }),
        .gender = fd(3, .{ .Varint = .Simple }),
        .race = fd(4, .{ .Varint = .Simple }),
        .head = fd(5, .{ .Varint = .Simple }),
        .body = fd(6, .{ .Varint = .Simple }),
        .helmet = fd(7, .{ .Varint = .Simple }),
        .right_hand = fd(8, .{ .Varint = .Simple }),
        .nick = fd(9, .String),
        .left_hand = fd(10, .{ .Varint = .Simple }),
        .color = fd(11, .String),
        .clan = fd(12, .String),
        .enabled = fd(13, .{ .Varint = .Simple }),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const Alignment = struct {
    id: ManagedString = .Empty,
    name: ManagedString = .Empty,
    color: ManagedString = .Empty,

    pub const _desc_table = .{
        .id = fd(1, .String),
        .name = fd(2, .String),
        .color = fd(3, .String),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const Index = struct {
    id: i32 = 0,
    grh: ArrayListU(i32) = .{},
    offset_x: i32 = 0,
    offset_y: i32 = 0,
    animations: ArrayListU(Index.AnimationsEntry) = .{},
    name: ManagedString = .Empty,

    pub const _desc_table = .{
        .id = fd(1, .{ .Varint = .Simple }),
        .grh = fd(2, .{ .PackedList = .{ .Varint = .Simple } }),
        .offset_x = fd(3, .{ .Varint = .Simple }),
        .offset_y = fd(4, .{ .Varint = .Simple }),
        .animations = fd(5, .{ .List = .{ .SubMessage = {} } }),
        .name = fd(6, .String),
    };

    pub const AnimationsEntry = struct {
        key: ManagedString = .Empty,
        value: i32 = 0,

        pub const _desc_table = .{
            .key = fd(1, .String),
            .value = fd(2, .{ .Varint = .Simple }),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const StoredChunk = struct {
    chunk_id: i32 = 0,
    entities: ArrayListU(MapEntity) = .{},

    pub const _desc_table = .{
        .chunk_id = fd(1, .{ .Varint = .Simple }),
        .entities = fd(2, .{ .List = .{ .SubMessage = {} } }),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const MapEntity = struct {
    x: i32 = 0,
    y: i32 = 0,
    light: ?*const Light = null,
    collider: ?*const Shape = null,
    graphic_id: i32 = 0,
    entity_id: ManagedString = .Empty,
    vertical_graphic: bool = false,

    pub const _desc_table = .{
        .x = fd(1, .{ .Varint = .Simple }),
        .y = fd(2, .{ .Varint = .Simple }),
        .light = fd(3, .{ .AllocMessage = {} }),
        .collider = fd(4, .{ .AllocMessage = {} }),
        .graphic_id = fd(5, .{ .Varint = .Simple }),
        .entity_id = fd(6, .String),
        .vertical_graphic = fd(7, .{ .Varint = .Simple }),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const Light = struct {
    hue: f32 = 0,
    height: f32 = 0,
    radius: f32 = 0,
    saturation: f32 = 0,
    fall_off: f32 = 0,

    pub const _desc_table = .{
        .hue = fd(1, .{ .FixedInt = .I32 }),
        .height = fd(2, .{ .FixedInt = .I32 }),
        .radius = fd(3, .{ .FixedInt = .I32 }),
        .saturation = fd(4, .{ .FixedInt = .I32 }),
        .fall_off = fd(5, .{ .FixedInt = .I32 }),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const Point = struct {
    x: i32 = 0,
    y: i32 = 0,

    pub const _desc_table = .{
        .x = fd(1, .{ .Varint = .Simple }),
        .y = fd(2, .{ .Varint = .Simple }),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const Shape = struct {
    points: ArrayListU(Point) = .{},

    pub const _desc_table = .{
        .points = fd(1, .{ .List = .{ .SubMessage = {} } }),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const Npc = struct {
    x: i32 = 0,
    y: i32 = 0,
    items: ArrayListU(InventoryItem) = .{},
    name: ManagedString = .Empty,
    alignment: ManagedString = .Empty,
    ai: ManagedString = .Empty,
    min_hp: i32 = 0,
    max_hp: i32 = 0,
    min_mana: i32 = 0,
    max_mana: i32 = 0,
    min_strenght: i32 = 0,
    max_strenght: i32 = 0,
    skills: ArrayListU(Npc.SkillsEntry) = .{},
    abilities: ArrayListU(Npc.AbilitiesEntry) = .{},
    visual: ?*const Character = null,

    pub const _desc_table = .{
        .x = fd(1, .{ .Varint = .Simple }),
        .y = fd(2, .{ .Varint = .Simple }),
        .items = fd(3, .{ .List = .{ .SubMessage = {} } }),
        .name = fd(4, .String),
        .alignment = fd(5, .String),
        .ai = fd(6, .String),
        .min_hp = fd(7, .{ .Varint = .Simple }),
        .max_hp = fd(8, .{ .Varint = .Simple }),
        .min_mana = fd(9, .{ .Varint = .Simple }),
        .max_mana = fd(10, .{ .Varint = .Simple }),
        .min_strenght = fd(11, .{ .Varint = .Simple }),
        .max_strenght = fd(12, .{ .Varint = .Simple }),
        .skills = fd(13, .{ .List = .{ .SubMessage = {} } }),
        .abilities = fd(14, .{ .List = .{ .SubMessage = {} } }),
        .visual = fd(15, .{ .AllocMessage = {} }),
    };

    pub const SkillsEntry = struct {
        key: i32 = 0,
        value: i32 = 0,

        pub const _desc_table = .{
            .key = fd(1, .{ .Varint = .Simple }),
            .value = fd(2, .{ .Varint = .Simple }),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub const AbilitiesEntry = struct {
        key: i32 = 0,
        value: i32 = 0,

        pub const _desc_table = .{
            .key = fd(1, .{ .Varint = .Simple }),
            .value = fd(2, .{ .Varint = .Simple }),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const Tile = struct {
    x: i32 = 0,
    y: i32 = 0,
    tileset_grh: i32 = 0,
    tileset: i32 = 0,
    flags: i32 = 0,
    blocked: i32 = 0,
    layer2: i32 = 0,
    layer3: i32 = 0,
    layer4: i32 = 0,

    pub const _desc_table = .{
        .x = fd(1, .{ .Varint = .Simple }),
        .y = fd(2, .{ .Varint = .Simple }),
        .tileset_grh = fd(3, .{ .Varint = .Simple }),
        .tileset = fd(4, .{ .Varint = .Simple }),
        .flags = fd(5, .{ .Varint = .Simple }),
        .blocked = fd(6, .{ .Varint = .Simple }),
        .layer2 = fd(7, .{ .Varint = .Simple }),
        .layer3 = fd(8, .{ .Varint = .Simple }),
        .layer4 = fd(9, .{ .Varint = .Simple }),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const MapItem = struct {
    x: i32 = 0,
    y: i32 = 0,
    item: i32 = 0,
    amount: i32 = 0,

    pub const _desc_table = .{
        .x = fd(1, .{ .Varint = .Simple }),
        .y = fd(2, .{ .Varint = .Simple }),
        .item = fd(3, .{ .Varint = .Simple }),
        .amount = fd(4, .{ .Varint = .Simple }),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const GraphicsDB = struct {
    textures: ArrayListU(Texture) = .{},
    graphics: ArrayListU(Graphic) = .{},
    bodies: ArrayListU(Index) = .{},
    fxs: ArrayListU(Index) = .{},
    heads: ArrayListU(Index) = .{},
    helmets: ArrayListU(Index) = .{},
    shields: ArrayListU(Index) = .{},
    weapons: ArrayListU(Index) = .{},
    scripts: ArrayListU(Script) = .{},
    spine: ArrayListU(Spine) = .{},

    pub const _desc_table = .{
        .textures = fd(1, .{ .List = .{ .SubMessage = {} } }),
        .graphics = fd(2, .{ .List = .{ .SubMessage = {} } }),
        .bodies = fd(4, .{ .List = .{ .SubMessage = {} } }),
        .fxs = fd(5, .{ .List = .{ .SubMessage = {} } }),
        .heads = fd(6, .{ .List = .{ .SubMessage = {} } }),
        .helmets = fd(7, .{ .List = .{ .SubMessage = {} } }),
        .shields = fd(8, .{ .List = .{ .SubMessage = {} } }),
        .weapons = fd(9, .{ .List = .{ .SubMessage = {} } }),
        .scripts = fd(10, .{ .List = .{ .SubMessage = {} } }),
        .spine = fd(11, .{ .List = .{ .SubMessage = {} } }),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const Script = struct {
    path: ManagedString = .Empty,
    code: ManagedString = .Empty,

    pub const _desc_table = .{
        .path = fd(1, .String),
        .code = fd(2, .String),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const SubTexture = struct {
    diffuse: ManagedString = .Empty,
    normal: ManagedString = .Empty,
    emmisive: ManagedString = .Empty,
    width: i32 = 0,
    height: i32 = 0,

    pub const _desc_table = .{
        .diffuse = fd(1, .String),
        .normal = fd(2, .String),
        .emmisive = fd(3, .String),
        .width = fd(4, .{ .Varint = .Simple }),
        .height = fd(5, .{ .Varint = .Simple }),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const Texture = struct {
    diffuse: ManagedString = .Empty,
    normal: ManagedString = .Empty,
    emmisive: ManagedString = .Empty,
    width: i32 = 0,
    height: i32 = 0,
    dxt1: ?*const SubTexture = null,
    dxt3: ?*const SubTexture = null,
    dxt5: ?*const SubTexture = null,

    pub const _desc_table = .{
        .diffuse = fd(1, .String),
        .normal = fd(2, .String),
        .emmisive = fd(3, .String),
        .width = fd(4, .{ .Varint = .Simple }),
        .height = fd(5, .{ .Varint = .Simple }),
        .dxt1 = fd(6, .{ .AllocMessage = {} }),
        .dxt3 = fd(7, .{ .AllocMessage = {} }),
        .dxt5 = fd(8, .{ .AllocMessage = {} }),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const Graphic = struct {
    id: i32 = 0,
    name: ManagedString = .Empty,
    type: ?union(enum) {
        sprite: *const Sprite,
        animation: *const Animation,
        pub const _union_desc = .{
            .sprite = fd(2, .{ .AllocMessage = {} }),
            .animation = fd(3, .{ .AllocMessage = {} }),
        };
    },

    pub const _desc_table = .{
        .id = fd(1, .{ .Varint = .Simple }),
        .name = fd(4, .String),
        .type = fd(null, .{ .OneOf = std.meta.Child(std.meta.FieldType(@This(), .type)) }),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const Sprite = struct {
    texture: i32 = 0,
    x: i32 = 0,
    y: i32 = 0,
    w: i32 = 0,
    h: i32 = 0,
    pivot_x: i32 = 0,
    pivot_y: i32 = 0,

    pub const _desc_table = .{
        .texture = fd(1, .{ .Varint = .Simple }),
        .x = fd(2, .{ .Varint = .Simple }),
        .y = fd(3, .{ .Varint = .Simple }),
        .w = fd(4, .{ .Varint = .Simple }),
        .h = fd(5, .{ .Varint = .Simple }),
        .pivot_x = fd(6, .{ .Varint = .Simple }),
        .pivot_y = fd(7, .{ .Varint = .Simple }),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const Animation = struct {
    frames: ArrayListU(i32) = .{},
    speed: f32 = 0,

    pub const _desc_table = .{
        .frames = fd(1, .{ .PackedList = .{ .Varint = .Simple } }),
        .speed = fd(2, .{ .FixedInt = .I32 }),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const Spine = struct {
    name: ManagedString = .Empty,
    json: ManagedString = .Empty,
    atlas: ManagedString = .Empty,

    pub const _desc_table = .{
        .name = fd(1, .String),
        .json = fd(2, .String),
        .atlas = fd(3, .String),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};
