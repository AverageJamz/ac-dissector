-- 0xF747

fields.MsgRemoveItemObject             = ProtoField.uint32("ac.msg.remove_item.obj_id", "ObjectID",  base.HEX)

function msgRemoveItem(message, tree)
  tree = tree:add("Remove item")

  tree:add_le(fields.MsgRemoveItemObject, message(4, 4))
  tree:add_le(fields.FieldUnknownDWORD, message(8, 4))
end