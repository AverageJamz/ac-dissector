-- 0xF619

local PositionFlags = {
  VelocityVectorPresent    = 0x00000001,
  Unknown                  = 0x00000002,
  ObjectGrounded           = 0x00000004,
  OrientationQuartNoW      = 0x00000008,
  OrientationQuartNoX      = 0x00000010,
  OrientationQuartNoY      = 0x00000020,
  OrientationQuartNoZ      = 0x00000040,
}

fields.MsgLifestoneMaterializeObjectId      = ProtoField.uint32("ac.msg.lifestone_materialize.objectid", "ObjectID", base.HEX)
fields.MsgLifestoneMaterializePosition      = ProtoField.uint32("ac.msg.lifestone_materialize.position", "Position")
fields.MsgLifestoneMaterializePositionFlags = ProtoField.uint32("ac.msg.lifestone_materialize.position_flags", "Flags", base.HEX)
fields.MsgLifestoneMaterializeLandCell      = ProtoField.uint32("ac.msg.lifestone_materialize.land_cell", "Land cell", base.HEX)
fields.MsgLifestoneMaterializePositionX     = ProtoField.float("ac.msg.lifestone_materialize.pos_x", "X")
fields.MsgLifestoneMaterializePositionY     = ProtoField.float("ac.msg.lifestone_materialize.pos_y", "Y")
fields.MsgLifestoneMaterializePositionZ     = ProtoField.float("ac.msg.lifestone_materialize.pos_z", "Z")
fields.MsgLifestoneMaterializeOrientationW  = ProtoField.float("ac.msg.lifestone_materialize.or_w", "W")
fields.MsgLifestoneMaterializeOrientationX  = ProtoField.float("ac.msg.lifestone_materialize.or_x", "X")
fields.MsgLifestoneMaterializeOrientationY  = ProtoField.float("ac.msg.lifestone_materialize.or_y", "Y")
fields.MsgLifestoneMaterializeOrientationZ  = ProtoField.float("ac.msg.lifestone_materialize.or_z", "Z")
fields.MsgLifestoneMaterializeVelocityX     = ProtoField.float("ac.msg.lifestone_materialize.vel_x", "X")
fields.MsgLifestoneMaterializeVelocityY     = ProtoField.float("ac.msg.lifestone_materialize.vel_y", "Y")
fields.MsgLifestoneMaterializeVelocityZ     = ProtoField.float("ac.msg.lifestone_materialize.vel_z", "Z")

local function process_position_flags(flags, tree)
  for name, flag in pairs(PositionFlags) do
    local flag_state = "Not set"
    if bit32.btest(flags, flag) then
      flag_state = "Set"
    end
    tree:add(string.format("%-23s: %-7s", name, flag_state))
  end
end

function msgLifestoneMaterialize(message, tree)
  local tree = tree:add("Lifestone Materialize")

  tree:add_le(fields.MsgLifestoneMaterializeObjectId, message(4, 4))

  local flagtree = tree:add_le(fields.MsgLifestoneMaterializePositionFlags, message(8, 4))
  process_position_flags(message(8, 4):le_uint(), flagtree)

  tree:add_le(fields.MsgLifestoneMaterializeLandCell, message(12, 4))

  local postree = tree:add("Position")
  postree:add_le(fields.MsgLifestoneMaterializePositionX, message(16, 4))
  postree:add_le(fields.MsgLifestoneMaterializePositionY, message(20, 4))
  postree:add_le(fields.MsgLifestoneMaterializePositionZ, message(24, 4))

  local orientationtree = tree:add("Orientation")
  orientationtree:add_le(fields.MsgLifestoneMaterializeOrientationW, message(28,4))
  orientationtree:add_le(fields.MsgLifestoneMaterializeOrientationX, message(32,4))
  orientationtree:add_le(fields.MsgLifestoneMaterializeOrientationY, message(36,4))
  orientationtree:add_le(fields.MsgLifestoneMaterializeOrientationZ, message(40,4))

  local velocitytree = tree:add("Velocity")
  velocitytree:add_le(fields.MsgLifestoneMaterializeVelocityX, message(44, 4))
  velocitytree:add_le(fields.MsgLifestoneMaterializeVelocityY, message(48, 4))
  velocitytree:add_le(fields.MsgLifestoneMaterializeVelocityZ, message(52, 4))
  
  -- local flags = bit32.bxor(message(8, 4):le_uint(), 0x00000078)

  -- if bit32.btest(flags, PositionFlags.VelocityVectorPresent) then

  -- end
  -- if bit32.btest(flags, PositionFlags.Unknown) then

  -- end
  -- if bit32.btest(flags, PositionFlags.ObjectGrounded) then

  -- end
  -- if bit32.btest(flags, PositionFlags.OrientationQuartNoW) then

  -- end
  -- if bit32.btest(flags, PositionFlags.OrientationQuartNoX) then

  -- end
  -- if bit32.btest(flags, PositionFlags.OrientationQuartNoY) then

  -- end
  -- if bit32.btest(flags, PositionFlags.OrientationQuartNoZ) then

  -- end

end