-- 0xF750

fields.MsgApplySoundEffectObject    = ProtoField.uint32("ac.msg.apply_snd_fx.obj", "ObjectID",  base.HEX)
fields.MsgApplySoundEffectEffect    = ProtoField.uint32("ac.msg.apply_snd_fx.fx", "Effect", base.HEX)
fields.MsgApplySoundEffectParameter = ProtoField.float("ac.msg.apply_snd_fx.param", "Parameter")

local effects = {
  ID_04000000 = "War Launch",
  ID_05000000 = "War Land",
  ID_06000000 = "Red Clouds Rising (Strength/Health Buff)",
  ID_07000000 = "Red Clouds Falling (Strength/Health Debuff)",
  ID_08000000 = "Orange Clouds Rising (Coordination Buff)",
  ID_09000000 = "Orange Clouds Falling (Coordination Debuff)",
  ID_0A000000 = "Yellow Clouds Rising (Endurance Buff)",
  ID_0B000000 = "Yellow Clouds Falling (Endurance Debuff)",
  ID_0C000000 = "Green Clouds Rising (Quickness Buff)",
  ID_0D000000 = "Green Clouds Falling (Quickness Debuff)",
  ID_0E000000 = "Cyan Clouds Rising (Self Buff, Lifestone Recall/Tie)",
  ID_0F000000 = "Cyan Clouds Falling (Self Debuff)",
  ID_10000000 = "Purple Clouds Rising (Focus Buff, Portal Recall/Summon/Tie)",
  ID_11000000 = "Purple Clouds Falling (Focus Debuff)",
  ID_12000000 = "Red Bubbles Rising (Weapon Skill Buff)",
  ID_13000000 = "Red Bubbles Falling (Weapon Skill Debuff)",
  ID_14000000 = "Orange Bubbles Rising (Allegiance/Crafting Skill Buff)",
  ID_15000000 = "Orange Bubbles Falling (Allegiance/Crafting Skill Debuff)",
  ID_16000000 = "Yellow Bubbles Rising (Defense Skill Buff)",
  ID_17000000 = "Yellow Bubbles Falling (Defense Skill Debuff)",
  ID_18000000 = "Green Bubbles Rising (Run/Jump Skill Buff)",
  ID_19000000 = "Green Bubbles Falling (Run/Jump Skill Debuff)",
  ID_1A000000 = "Cyan Bubbles Rising (Magic/Alchemy Skill Buff)",
  ID_1B000000 = "Cyan Bubbles Falling (Magic/Alchemy Skill Debuff)",
  ID_1C000000 = "Purple Bubbles Rising (Assessment/Tinkering Skill Buff, Learn Spell)",
  ID_1D000000 = "Purple Bubbles Falling (Assessment/Tinkering Skill Debuff)",
  ID_1E000000 = "Red Stars In (Heal, Infuse Health)",
  ID_1F000000 = "Red Stars Out (Harm, Drain Health)",
  ID_20000000 = "Blue Stars In (Mana Boost, Infuse Mana)",
  ID_21000000 = "Blue Stars Out (Mana Drain, Drain Mana)",
  ID_22000000 = "Yellow Stars In (Revitalize, Infuse Stamina)",
  ID_23000000 = "Yellow Stars Out (Enfeeble, Drain Stamina)",
  ID_24000000 = "Red Stars Rotating Out (Regeneration)",
  ID_25000000 = "Red Stars Rotating In (Fester)",
  ID_26000000 = "Blue Stars Rotating Out (Mana Renewal)",
  ID_27000000 = "Blue Stars Rotating In (Mana Depletion)",
  ID_28000000 = "Yellow Stars Rotating In (Rejuvenation)",
  ID_29000000 = "Yellow Stars Rotating Out (Exhaustion)",
  ID_2A000000 = "Red Shield Rising (Fire Protection)",
  ID_2B000000 = "Red Shield Falling (Fire Vulnerability)",
  ID_2C000000 = "Orange Shield Rising (Piercing Protection)",
  ID_2D000000 = "Orange Shield Falling (Piercing Vulnerability)",
  ID_2E000000 = "Yellow Shield Rising (Blade Protection)",
  ID_2F000000 = "Yellow Shield Falling (Blade Vulnerability)",
  ID_30000000 = "Green Shield Rising (Acid Protection)",
  ID_31000000 = "Green Shield Falling (Acid Vulnerability)",
  ID_32000000 = "Cyan Shield Rising (Cold Protection)",
  ID_33000000 = "Cyan Shield Falling (Cold Vulnerability)",
  ID_34000000 = "Purple Shield Rising (Lightning Protection)",
  ID_35000000 = "Purple Shield Falling (Lightning Vulnerability)",
  ID_36000000 = "Black Shield Rising (Bludgeon Protection, Armor)",
  ID_37000000 = "Black Shield Falling (Bludgeon Vulnerability, Imperil)",
  ID_38000000 = "Red/White Sparks (Flame Bane, Blood Drinker)",
  ID_39000000 = "Red/Black Sparks (Flame Lure, Blood Loather)",
  ID_3A000000 = "Orange/White Sparks (Piercing Bane, Heart Seeker, Strengthen Lock)",
  ID_3B000000 = "Orange/Black Sparks (Piercing Lure, Turn Blade, Weaken Lock)",
  ID_3C000000 = "Yellow/White Sparks (Blade Bane, Defender)",
  ID_3D000000 = "Yellow/Black Sparks (Blade Lure, Lure Blade)",
  ID_3E000000 = "Green/White Sparks (Acid Bane, Swift Killer)",
  ID_3F000000 = "Green/Black Sparks (Acid Lure, Leaden Weapon)",
  ID_40000000 = "Cyan/White Sparks (Frost Bane)",
  ID_41000000 = "Cyan/Black Sparks (Frost Lure)",
  ID_42000000 = "Purple/White Sparks (Bludgeon/Lightning Bane, Hermetic Link)",
  ID_43000000 = "Purple/Black Sparks (Bludgeon/Lightning Lure, Hermetic Void, Dispel)",
  ID_48000000 = "Red Stars Out / Yellow Stars In (Health to Stamina)",
  ID_49000000 = "Red Stars Out / Blue Stars In (Health to Mana)",
  ID_4A000000 = "Yellow Stars Out / Red Stars In (Stamina to Health)",
  ID_4B000000 = "Yellow Stars Out / Blue Stars In (Stamina to Mana)",
  ID_4C000000 = "Blue Stars Out / Red Stars In (Mana to Health)",
  ID_4D000000 = "Blue Stars Out / Yellow Stars In (Mana to Stamina)",
  ID_50000000 = "Fizzle",
  ID_57000000 = "Idle Emote",
  ID_58000000 = "Item Dissolve",
  ID_73000000 = "Portal Bubbles",
  ID_76000000 = "Raise Attribute or Skill",
  ID_77000000 = "Equip Item",
  ID_78000000 = "Unequip Item",
  ID_79000000 = "Give Item",
  ID_7A000000 = "Pick Up Item",
  ID_7B000000 = "Drop Item",
  ID_7E000000 = "Unlock Item",
  ID_81000000 = "Enchantment Expiration",
  ID_82000000 = "Item Out of Mana",
  ID_89000000 = "Gain Level",
  ID_8D000000 = "White/White Sparks (Impenetrability)",
  ID_8E000000 = "White/Black Sparks (Brittlemail)",
  ID_91000000 = "White/Purple Clouds (Life Dispel)",
  ID_92000000 = "White/Cyan Clouds (Creature Dispel)",
}

function msgApplySoundEffect(message, tree)
  tree = tree:add("Apply sound effect")

  tree:add_le(fields.MsgApplySoundEffectObject, message(4, 4))

  local effect_id = "ID_" .. tostring(message(8, 4):bytes())
  local description = effects[effect_id]
  
  if description == nil then
    description = "Unknown"
  end

  local item = tree:add_le(fields.MsgApplySoundEffectEffect, message(8, 4))
  item:append_text(" " .. description)

  tree:add_le(fields.MsgApplySoundEffectParameter, message(12, 4))
end