-- 0xF74E

fields.MsgJumpingObject            = ProtoField.uint32("ac.msg.jump.obj", "ObjectID",  base.HEX)
fields.MsgJumpingHeading           = ProtoField.float("ac.msg.jump.heading", "Heading")
fields.MsgJumpingHeight            = ProtoField.float("ac.msg.jump.height", "Height")
fields.MsgJumpingLogins            = ProtoField.uint16("ac.msg.jump.logins", "Logins #")
fields.MsgJumpingNumJumps          = ProtoField.uint16("ac.msg.jump.num_jumps", "Jumps #")


function msgJumping(message, tree)
  tree = tree:add("Object jumping")

  tree:add_le(fields.MsgJumpingObject, message(4, 4))
  tree:add_le(fields.FieldUnknownDWORD, message(8, 4))
  tree:add_le(fields.MsgJumpingHeading, message(12, 4))
  tree:add_le(fields.MsgJumpingHeight, message(16, 4))
  tree:add_le(fields.FieldUnknownDWORD, message(20, 4))
  tree:add_le(fields.FieldUnknownDWORD, message(24, 4))
  tree:add_le(fields.FieldUnknownDWORD, message(28, 4))
  tree:add_le(fields.MsgJumpingLogins, message(32, 2))
  tree:add_le(fields.MsgJumpingNumJumps, message(34, 2))
end