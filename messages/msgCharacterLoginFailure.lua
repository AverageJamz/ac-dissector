-- 0xF659

fields.MsgCharacterLoginFailureReason      = ProtoField.uint32("ac.msg.login_fail_reason", "Reason",  base.HEX)

function msgCharacterLoginFailure(message, tree)
  tree = tree:add("Character login failure")

  tree:add_le(fields.MsgCharacterLoginFailureReason, message(4, 4))
end