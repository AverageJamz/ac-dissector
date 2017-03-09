-- 0xF7B0

fields.MsgGameEventRecipient    = ProtoField.uint32("ac.msg.game_evt.rec", "Recipient",  base.HEX)
fields.MsgGameEventSequence     = ProtoField.uint32("ac.msg.game_evt.seq", "Sequence #")
fields.MsgGameEventEventID      = ProtoField.uint32("ac.msg.game_evt.evt_id", "Event ID", base.HEX)

local evt_dir = persconffile_path("ac-dissector/GameEvents")

-- load GameEvent definitions
for f in Dir.open(evt_dir) do
  if f:match(".lua$") then
    local evt_path = evt_dir .. "/" .. f
    message("Loading " .. evt_path)
    dofile(evt_path)
  end
end

-- Events table. Must be defined after GaveEvent function definitions are loaded
local events = {
  EVT_C9000000 = evtMessageBox,
  EVT_13000000 = evtLoginCharacter,
  -- EVT_20000000 = "evtAllegianceInfo",
}

function msgGameEvent(message, tree)
  tree = tree:add("Game event")

  local event_id = "EVT_" .. tostring(message(12, 4):bytes())

  tree:add_le(fields.MsgGameEventRecipient, message(4, 4))
  tree:add_le(fields.MsgGameEventSequence, message(8, 4))
  tree:add_le(fields.MsgGameEventEvent, message(12, 4))

  -- Lookup the event in the events table and if found, execute function
  -- passing in remaining buffer and tree to add to
  if events[event_id] ~= nil then
    events[event_id](message(16, message:len() - 16):tvb(), tree)
  end
end
