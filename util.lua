function calc_pad(length, multiple)
  local rem = length % 4

  if rem == 0 then 
    return 0
  else
    return (length + multiple - rem) - length
  end
end