-- 0xF658

function msgCharacterList(message, tree)
  tree = tree:add("Character List")
  pos = pos + 4 -- unknown
  local char_count = fragments(pos, 4):le_uint(); pos = pos + 4
  t:add("Count", char_count)
  for i=1, char_count do
    local c = t:add("Character")
    local obj_id = fragments(pos, 4):le_uint(); pos = pos + 4
    local name_len = fragments(pos, 2):le_uint(); pos = pos + 2
    local name = fragments(pos, name_len):string()
    pos = pos + name_len + calc_pad(name_len+2, 4)
    local delete_timeout = fragments(pos, 4):le_uint(); pos = pos + 4
    c:add("ObjectID:", obj_id, base.HEX)
    c:add("Name:", name)
    c:add("Delete Timeout:", delete_timeout)
  end
  pos = pos + 4
  local slot_count = fragments(pos, 4):le_uint(); pos = pos + 4
  t:add("Slot count:", slot_count)
  local zone_name_len = fragments(pos, 2):le_uint(); pos = pos + 2
  local zone_name = fragments(pos, zone_name_len):string()
  pos = pos + zone_name_len + calc_pad(zone_name_len+2, 4)
  local turbine_chat_enabled = fragments(pos, 4):le_uint(); pos = pos + 4
  pos = pos + 4
  t:add("Zone name:", zone_name)
  t:add("Turbine chat enabled:", turbine_chat_enabled)
end