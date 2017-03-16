-- 0x00000004

fields.EvtMessageBoxText        = ProtoField.string("ac.evt.msg_box.text", "Text")

function evtMessageBox(event, tree)
  tree:append_text(" (Message box)")

  local text_len = event(4, 2):le_uint()
  local text_pad = calc_pad(text_len + 2, 4)

  tree:add(fields.EvtMessageBoxText, event(6, text_len + text_pad))
end