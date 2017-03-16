-- 0xF7B1

fields.MsgGameActionSequence     = ProtoField.uint32("ac.msg.game_act.seq", "Sequence #")
fields.MsgGameActionAction       = ProtoField.uint32("ac.msg.game_act.act_id", "Action ID", base.HEX)

local act_dir = persconffile_path("ac-dissector/GameActions")

-- load GameAction definitions
for f in Dir.open(act_dir) do
  if f:match(".lua$") then
    local act_path = act_dir .. "/" .. f
    message("Loading " .. act_path)
    dofile(act_path)
  end
end

-- Actions table. Must be defined after GameAction function definitions are loaded
local actions = {
  -- ACT_05000000 = actSetSingleCharacterOption,
  -- ACT_10000000 = actSetAFKMessage,
  -- ACT_19000000 = actStoreItem,
}

function msgGameAction(message, tree)
  tree = tree:add("Game action")

  local action_id = "ACT_" .. tostring(message(8, 4):bytes())

  tree:add_le(fields.MsgGameActionSequence, message(4, 4))
  tree:add_le(fields.MsgGameActionAction, message(8, 4))

  -- Lookup the action in the actions table and if found, execute function
  -- passing in remaining buffer and tree to add to
  if actions[action_id] ~= nil then
    actions[action_id](message(16, message:len() - 16):tvb(), tree)
  end
end
