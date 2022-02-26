speaker = peripheral.find("speaker")
if speaker == nil then
  print("Speaker not found")
  return
end

tArgs = { ... }
if #tArgs < 1 then
  print("Usage: player <music file>")
  return
end

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
  speaker.playNote(instruments[instrument], 1, note)
  sleep(time/20)
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
    playNote(tonumber(music[3][i][1]), tonumber(music[3][i][2]), tonumber(music[3][i][3]))
  end
end


file = io.open(tArgs[1])
music_text = file.read(file)
music = decode(music_text)

print('Playing "'..music[1]..'"')
print('Author: '..music[2])

r = number(music[4])
if r == -1 then
  while true do
    play(music)
    sleep(1)
  end
elseif r > 0 then
  for i = 1, r do
    play(music)
  end
else
  play(music)
end
