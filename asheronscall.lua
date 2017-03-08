local path = persconffile_path("ac-dissector\\")
local ac = Proto("ac", "Asheron's Call")

local PacketHeaderFlags = {
  None              = 0x00000000,
  Retransmission    = 0x00000001,
  EncryptedChecksum = 0x00000002,
  BlobFragments     = 0x00000004,
  ServerSwitch      = 0x00000100,
  Referral          = 0x00000800,
  RequestRetransmit = 0x00001000,
  RejectRetransmit  = 0x00002000,
  AckSequence       = 0x00004000,
  Disconnect        = 0x00008000,
  LoginRequest      = 0x00010000,
  WorldLoginRequest = 0x00020000,
  ConnectRequest    = 0x00040000,
  ConnectResponse   = 0x00080000,
  CICMDCommand      = 0x00400000,
  TimeSynch         = 0x01000000,
  EchoRequest       = 0x02000000,
  EchoResponse      = 0x04000000,
  Flow              = 0x08000000,
}

fields = ac.fields

fields.SequenceNumber = ProtoField.uint32("ac.seq_num", "Sequence number", base.DEC)
fields.Flags          = ProtoField.uint32("ac.flags", "Flags", base.HEX)
fields.CRC            = ProtoField.uint32("ac.crc", "CRC", base.HEX)
fields.RecordID       = ProtoField.uint16("ac.rec_id", "RecordID", base.HEX)
fields.Time           = ProtoField.uint16("ac.time", "Time", base.DEC)
fields.Size           = ProtoField.uint16("ac.size", "Size", base.DEC)
fields.Table          = ProtoField.uint16("ac.table", "Table", base.HEX)

fields.OptionalAckSequence          = ProtoField.uint32("ac.opt.ack_seq", "Ack Sequence #")
fields.OptionalTimeSynch            = ProtoField.double("ac.opt.time_synch", "Time synch")
fields.OptionalEchoRequest          = ProtoField.float("ac.opt.echo_req", "Client time")
fields.OptionalFlowA                = ProtoField.uint32("ac.opt.flow_a", "FlowA (???)")
fields.OptionalFlowB                = ProtoField.uint16("ac.opt.flow_b", "FlowB (related to Time field?)")

fields.FragmentHeaderSequenceNumber = ProtoField.uint32("ac.frag_header.seq_num", "Sequence number", base.DEC)
fields.FragmentHeaderID             = ProtoField.uint32("ac.frag_header.id", "ID", base.HEX)
fields.FragmentHeaderCount          = ProtoField.uint16("ac.frag_header.count", "Count", base.DEC)
fields.FragmentHeaderSize           = ProtoField.uint16("ac.frag_header.size", "Size", base.DEC)
fields.FragmentHeaderIndex          = ProtoField.uint16("ac.frag_header.index", "Index", base.HEX)
fields.FragmentHeaderGroup          = ProtoField.uint16("ac.frag_header.group", "Group", base.HEX)
fields.FragmentHeaderData           = ProtoField.bytes("ac.frag_header.data", "Data", base.HEX)

fields.FieldUnknownDWORD  = ProtoField.uint32("ac.msg_field.unknown_dword", "Unknown", base.HEX)
fields.FieldUnknownWORD   = ProtoField.uint16("ac.msg_field.unknown_word", "Unknown", base.HEX)

fields.Message = ProtoField.bytes("ac.msg", "Message")
fields.MessageID = ProtoField.uint32("ac.msg_id", "Message ID", base.HEX)
fields.MessageUnknown = ProtoField.uint32("ac.msg_unknown", "Unknown", base.HEX)

-- load utility functions
dofile(path .. "util.lua")

-- load Message definitions
for f in Dir.open(path .. "messages") do
  dofile(path .. "messages\\" .. f)
end

function process_flags(flags, tree)
  for name, flag in pairs(PacketHeaderFlags) do
    local flag_state = "Not set"
    if bit32.btest(flags, flag) then
      flag_state = "Set"
    end
    tree:add(string.format("%-20s: %-7s", name, flag_state))
  end
end

function process_message(message, tree)
  local msg = message(0, 4):le_uint()
  tree:add_le(fields.MessageID, message(0, 4))
  if msg == 0xF619 then
    msgLifestoneMaterialize(message, tree)
  elseif msg == 0xF625 then
  elseif msg == 0xF657 then
    msgRequestLogin(message, tree)
  elseif msg == 0xF658 then
    msgCharacterList(message, tree)
  elseif msg == 0xF659 then
    msgCharacterLoginFailure(message, tree)
  elseif msg == 0xF745 then
  elseif msg == 0xF746 then
    msgLoginCharacter(message, tree)
  elseif msg == 0xF747 then
    msgRemoveItem(message, tree)
  elseif msg == 0xF748 then
  elseif msg == 0xF749 then
    msgWieldObject(message, tree)
  elseif msg == 0xF74A then
    msgMoveObjectIntoInventory(message, tree)
  elseif msg == 0xF74B then
    msgToggleObjectVisibility(message, tree)
  elseif msg == 0xF74C then
  elseif msg == 0xF74E then
    msgJumping(message, tree)
  elseif msg == 0xF750 then
    msgApplySoundEffect(message, tree)
  elseif msg == 0xF751 then
    msgEnterPortalMode(message, tree)
  elseif msg == 0xF755 then
  elseif msg == 0xF7B0 then
  elseif msg == 0xF7B1 then
  elseif msg == 0xF7DE then
  elseif msg == 0xF7E0 then
  elseif msg == 0xF7E1 then
    msgServerInfo(message, tree)
  elseif msg == 0xF7E2 then
  elseif msg == 0xF7E7 then

  -- elseif msg == 0x0024 then
  -- elseif msg == 0x0197 then
  -- elseif msg == 0x019E then
  -- elseif msg == 0x01E0 then
  -- elseif msg == 0x01E2 then
  -- elseif msg == 0x02BB then
  -- elseif msg == 0x02BC then
  -- elseif msg == 0x02CD then
  -- elseif msg == 0x02CE then
  -- elseif msg == 0x02CF then
  -- elseif msg == 0x02D1 then
  -- elseif msg == 0x02D2 then
  -- elseif msg == 0x02D6 then
  -- elseif msg == 0x02D8 then
  -- elseif msg == 0x02D9 then
  -- elseif msg == 0x02DA then
  -- elseif msg == 0x02DB then
  -- elseif msg == 0x02DD then
  -- elseif msg == 0x02E3 then
  -- elseif msg == 0x02E7 then
  -- elseif msg == 0x02E9 then

  else
    -- tree:add(fields.MessageUnknown, msg)
  end
end

function draw_fragments(fragments, tree)
  local offset = 0
  repeat
    local f = tree:add("Fragment")
    f:add_le(fields.FragmentHeaderSequenceNumber, fragments(offset, 4)); offset = offset + 4
    f:add_le(fields.FragmentHeaderID, fragments(offset, 4)); offset = offset + 4
    f:add_le(fields.FragmentHeaderCount, fragments(offset, 2)); offset = offset + 2
    f:add_le(fields.FragmentHeaderSize, fragments(offset, 2)) 
    local size = fragments(offset, 2):le_uint(); offset = offset + 2
    f:add_le(fields.FragmentHeaderIndex, fragments(offset, 2)); offset = offset + 2
    f:add_le(fields.FragmentHeaderGroup, fragments(offset, 2)); offset = offset + 2
    process_message(fragments(offset, size - 16):tvb(), f:add("Message"))
    offset = offset + size - 16 -- 16 is length of header
  until offset == fragments:len()
end

function ac.dissector(buffer, pinfo, tree)
  local offset = 0
  pinfo.cols.protocol = "AC"

  local subtree = tree:add(ac, buffer(), "Asheron's Call Data")
  subtree:add_le(fields.SequenceNumber, buffer(offset, 4)); offset = offset + 4
  
  local flagtree = subtree:add_le(fields.Flags, buffer(offset, 4))
  process_flags(buffer(offset, 4):le_uint(), flagtree)
  offset = offset + 4

  subtree:add_le(fields.CRC, buffer(offset, 4)); offset = offset + 4
  subtree:add_le(fields.RecordID, buffer(offset, 2)); offset = offset + 2
  subtree:add_le(fields.Time, buffer(offset, 2)); offset = offset + 2
  subtree:add_le(fields.Size, buffer(offset, 2)); offset = offset + 2
  subtree:add_le(fields.Table, buffer(offset, 2)); offset = offset + 2 -- offset = 20

  local flags = buffer(4, 4):le_uint()

  -- if bit32.btest(flags, PacketHeaderFlags.None) then
    
  -- end
  -- if bit32.btest(flags, PacketHeaderFlags.Retransmission) then

  -- end  
  -- if bit32.btest(flags, PacketHeaderFlags.EncryptedChecksum) then

  -- end    
  if bit32.btest(flags, PacketHeaderFlags.ServerSwitch) then
    offset = offset + 8
  end
  -- if bit32.btest(flags, PacketHeaderFlags.Referral) then

  -- end
  if bit32.btest(flags, PacketHeaderFlags.RequestRetransmit) then
    local count = buffer(offset, 4):le_uint()
    offset = offset + (count * 4)
  end
  if bit32.btest(flags, PacketHeaderFlags.RejectRetransmit) then
    local count = buffer(offset, 4):le_uint()
    offset = offset + (count * 4)
  end
  if bit32.btest(flags, PacketHeaderFlags.AckSequence) then
    subtree:add_le(fields.OptionalAckSequence , buffer(offset, 4)); offset = offset + 4
  end
  -- if bit32.btest(flags, PacketHeaderFlags.Disconnect) then

  -- end
  -- if bit32.btest(flags, PacketHeaderFlags.LoginRequest) then

  -- end
  -- if bit32.btest(flags, PacketHeaderFlags.WorldLoginRequest) then

  -- end
  -- if bit32.btest(flags, PacketHeaderFlags.ConnectRequest) then

  -- end
  -- if bit32.btest(flags, PacketHeaderFlags.ConnectResponse) then
  
  -- end
  if bit32.btest(flags, PacketHeaderFlags.CICMDCommand) then
    offset = offset + 8
  end
  if bit32.btest(flags, PacketHeaderFlags.TimeSynch) then
    subtree:add_le(fields.OptionalTimeSynch , buffer(offset, 8)); offset = offset + 8
  end
  if bit32.btest(flags, PacketHeaderFlags.EchoRequest) then
    subtree:add_le(fields.OptionalEchoRequest , buffer(offset, 4)); offset = offset + 4
  end
  if bit32.btest(flags, PacketHeaderFlags.EchoResponse) then
    offset = offset + 8
  end
  if bit32.btest(flags, PacketHeaderFlags.Flow) then
    subtree:add_le(fields.OptionalFlowA , buffer(offset, 4)); offset = offset + 4
    subtree:add_le(fields.OptionalFlowB , buffer(offset, 2)); offset = offset + 2
  end
  if bit32.btest(flags, PacketHeaderFlags.BlobFragments) then
    local fragtree = subtree:add("Fragments")
    draw_fragments(buffer(offset, buffer:len() - offset):tvb(), fragtree)
  end
end

udp_table = DissectorTable.get("udp.port")
for p=9000, 9009 do
  udp_table:add(p, ac)
end