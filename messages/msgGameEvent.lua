-- 0xF7B0

fields.MsgGameEventRecipient    = ProtoField.uint32("ac.msg.game_evt.rec", "Recipient",  base.HEX)
fields.MsgGameEventSequence     = ProtoField.uint32("ac.msg.game_evt.seq", "Sequence #")
fields.MsgGameEventEvent     = ProtoField.uint32("ac.msg.game_evt.evt", "Event")

local events = {
  evtMessageBox     = 0x00000004,
  evtLoginCharacter = 0x00000013,
}

-- load GameEvent definitions
for f in Dir.open(path .. "GameEvent") do
  dofile(path .. "GameEvent\\" .. f)
end

function msgGameEvent(message, tree)
  tree = tree:add("Game event")

end