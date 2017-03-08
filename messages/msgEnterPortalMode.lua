-- 0xF751

fields.MsgEnterPortalModeSequence      = ProtoField.uint32("ac.msg.enter_portal_mode.seq", "Sequence")

function msgEnterPortalMode(message, tree)
  tree = tree:add("Enter portal mode")

  tree:add_le(fields.MsgEnterPortalModeSequence, message(4, 4))
end