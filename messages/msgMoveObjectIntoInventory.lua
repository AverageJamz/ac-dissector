-- 0xF74A

fields.MsgMoveObjectIntoInventoryObject            = ProtoField.uint32("ac.msg.move_obj_to_inv.obj", "ObjectID",  base.HEX)

function msgMoveObjectIntoInventory(message, tree)
  tree = tree:add("Move object into inventory")

  tree:add_le(fields.MsgMoveObjectIntoInventoryObject, message(4, 4))
  tree:add_le(fields.FieldUnknownWORD, message(8, 2))
  tree:add_le(fields.FieldUnknownWORD, message(10, 2))
end