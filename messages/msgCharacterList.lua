-- 0xF658

fields.MsgCharacterListObjectId             = ProtoField.uint32("ac.msg.char_list.obj_id", "ObjectID",  base.HEX)
fields.MsgCharacterListCharacterName        = ProtoField.string("ac.msg.char_list.char_name", "Name")
fields.MsgCharacterListDeleteTimeout        = ProtoField.uint32("ac.msg.char_list.del_timeout", "Delete timeout")
fields.MsgCharacterListSlotCount            = ProtoField.uint32("ac.msg.char_list.slot_count", "Slot count")
fields.MsgCharacterListZoneName             = ProtoField.string("ac.msg.char_list.zone_name", "Zone name")
fields.MsgCharacterListTurbineChatEnabled   = ProtoField.uint32("ac.msg.char_list.turbine_chat_enabled", "Turbine chat enabled")

function msgCharacterList(message, tree)
  local tree = tree:add("Character List")
  local offset = 4

  tree:add_le(fields.FieldUnknownDWORD, message(offset, 4)); offset = offset + 4

  local char_count = message(offset, 4):le_uint()
  tree:add("Count", char_count); offset = offset + 4

  for i=1, char_count do
    local tree = tree:add("Character")
    tree:add_le(fields.MsgCharacterListObjectId, message(offset, 4)); offset = offset + 4
    local name_len = message(offset, 2):le_uint(); offset = offset + 2
    local name_pad = calc_pad(name_len + 2, 4)
    tree:add(fields.MsgCharacterListCharacterName, message(offset, name_len + name_pad)); offset = offset + name_len + name_pad
    tree:add_le(fields.MsgCharacterListDeleteTimeout, message(offset, 4)); offset = offset + 4
  end

  tree:add_le(fields.FieldUnknownDWORD, message(offset, 4)); offset = offset + 4
  tree:add_le(fields.MsgCharacterListSlotCount, message(offset, 4)); offset = offset + 4
  
  local zone_name_len = message(offset, 2):le_uint(); offset = offset + 2
  local zone_name_pad = calc_pad(zone_name_len + 2, 4)
  tree:add(fields.MsgCharacterListZoneName, message(offset, zone_name_len + zone_name_pad)); offset = offset + zone_name_len + zone_name_pad
  tree:add_le(fields.MsgCharacterListTurbineChatEnabled, message(offset, 4)); offset = offset + 4
  tree:add_le(fields.FieldUnknownDWORD, message(offset, 4)); offset = offset + 4
end