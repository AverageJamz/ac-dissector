-- 0xF746

fields.MsgLoginCharacterCharacter             = ProtoField.uint32("ac.msg.login_char_char", "ObjectID",  base.HEX)

function msgLoginCharacter(message, tree)
  tree = tree:add("Login character")

  tree:add_le(fields.MsgLoginCharacterCharacter, message(4, 4))
end