-- 0xF7E1

fields.MsgServerInfoServerName = ProtoField.string("ac.msg.server_info.server_name", "Name")
fields.MsgServerInfoNumPlayers = ProtoField.uint32("ac.msg.server_info.num_players", "# players", base.DEC)

function msgServerInfo(message, tree)
  tree = tree:add("Server info")

  local world_name_len = message(12, 2):le_uint()
  tree:add_le(fields.MsgServerInfoNumPlayers, message(4, 4))
  tree:add_le(fields.FieldUnknownDWORD, message(8, 4))
  tree:add(fields.MsgServerInfoServerName, message(14, world_name_len + calc_pad(world_name_len+2, 4)))
end