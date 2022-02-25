
-- Supperted instruments
instruments = {
  [1] = "guitar",
  [2] = "chime",
  [3] = "bell",
  [4] = "flute",
  [5] = "basedrum",
  [6] = "snare",
  [7] = "hat",
  [8] = "bass",
  [9] = "harp"
}

function split(inputstr, sep)
  local t = {}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
  return t
end

function playNote(instrument, time, note)
  print(instrument .. " " .. " " .. note)
  sleep(time*20)
end

function decode(text)
  music = split(text, ";")
  music[3] = split(music[3], ":")
  for i = 1, #music[3] do
    music[3][i] = split(music[3][i], ".")
  end
  return music
end

function play(music)
  for i = 1, #music[3] do
    playNote(music[3][i][1], music[3][i][2], music[3][i][3])
  end
end

play(decode(music_text))
